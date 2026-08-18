#!/bin/sh
# Reflect Claude session state onto the kitty tab bar.
#   ○ idle   ◐ working   ● needs you   ✓ done
#   ⋯N = N background tasks still in flight   ⏱ = will wake itself on a timer
#
# A tab holding several Claude splits shows the most urgent state plus a
# per-state tally, so nothing hides behind a sibling.
#
# Usage: kitty-tab-state.sh <start|prompt|post-tool|notify|stop|subagent-stop|end>
#        hook JSON on stdin

set -u
event="${1:-}"

[ -n "${KITTY_WINDOW_ID:-}" ] || exit 0
[ -n "${KITTY_LISTEN_ON:-}" ] || exit 0

KITTY=$(command -v kitty 2>/dev/null) || KITTY=/Applications/kitty.app/Contents/MacOS/kitty
[ -x "$KITTY" ] || exit 0
command -v jq >/dev/null 2>&1 || exit 0

STATE_DIR="$HOME/.claude/kitty-sessions"
STATE_FILE="$STATE_DIR/$KITTY_WINDOW_ID"
mkdir -p "$STATE_DIR" 2>/dev/null || exit 0

# PostToolUse fires constantly; it only matters as a transition back to
# "working", so bail out cheaply when we are already there.
if [ "$event" = "post-tool" ] && [ -f "$STATE_FILE" ]; then
  read -r cur _ < "$STATE_FILE" 2>/dev/null || cur=""
  [ "$cur" = "working" ] && exit 0
fi

payload=$(cat 2>/dev/null)

# Events raised *by* a subagent carry agent_id and must not drive the tab.
# SubagentStop is the exception: the main session fires it, and its agent_id
# names the subagent that just finished.
if [ "$event" != "subagent-stop" ]; then
  case "$payload" in *'"agent_id"'*) exit 0 ;; esac
fi

[ -f "$STATE_DIR/CAPTURE" ] && {
  printf '%s %s %s\n' "$(date +%H:%M:%S)" "$event" "$payload" >> "$STATE_DIR/payloads.log"
  tail -n 40 "$STATE_DIR/payloads.log" > "$STATE_DIR/payloads.tmp" 2>/dev/null &&
    mv "$STATE_DIR/payloads.tmp" "$STATE_DIR/payloads.log"
}

cwd=$(printf '%s' "$payload" | jq -r '.cwd // empty' 2>/dev/null)
[ -n "$cwd" ] || cwd="$PWD"

# --- in-flight work, straight from the hook payload --------------------------
bg=0; cron=0
case "$event" in
  stop|subagent-stop)
    counts=$(printf '%s' "$payload" | jq -r \
      '"\((.background_tasks // []) | length) \((.session_crons // []) | length)"' 2>/dev/null)
    case "$counts" in
      [0-9]*" "[0-9]*) bg=${counts%% *}; cron=${counts##* } ;;
    esac ;;
esac

case "$event" in
  start)     state=idle    ;;
  prompt)    state=working ;;
  post-tool) state=working ;;
  end)       state=gone    ;;

  stop-failure)
    # The turn died on an API error (rate_limit, overloaded, billing, ...).
    # Stop never fires for these, so without this the tab stays blue forever
    # on a session that has actually given up and wants you.
    state=needs ;;

  stop)
    # A turn ending is not the same as the session being done. If background
    # work is still registered, the session is only paused waiting to be woken
    # by it — stay blue instead of flashing green between wake-ups.
    if [ "$bg" -gt 0 ]; then state=working; else state=done; fi ;;

  subagent-stop)
    # Only ever refreshes the in-flight count while work remains. When the last
    # one finishes the main loop wakes and fires Stop, which paints green — so
    # never paint it from here, or we would flash green mid-turn.
    [ "$bg" -gt 0 ] || exit 0
    state=working ;;

  notify)
    # The Notification hook covers two very different things. Only a real block
    # should turn the tab red; idle_prompt is just Claude pointing out that a
    # finished turn has been sitting unread for 60s.
    ntype=$(printf '%s' "$payload" | jq -r '.notification_type // empty' 2>/dev/null)
    case "$ntype" in
      permission_prompt|worker_permission_prompt|agent_needs_input|elicitation_response)
        state=needs ;;
      idle_prompt)
        # Claude only emits this while it is NOT responding, so it is proof the
        # session is parked at the prompt. If the tab still claims "working",
        # the turn was interrupted (ctrl+c) and Stop never fired — correct it.
        # Background work still in flight is the one case where "working" is
        # legitimate despite an idle prompt, so leave that alone.
        [ -f "$STATE_FILE" ] || exit 0
        read -r cur _ curbg _ < "$STATE_FILE" 2>/dev/null || exit 0
        case "$curbg" in ''|*[!0-9]*) curbg=0 ;; esac
        [ "$cur" = "working" ] && [ "$curbg" -eq 0 ] || exit 0
        state=done ;;
      "")
        msg=$(printf '%s' "$payload" | jq -r '.message // empty' 2>/dev/null)
        case "$msg" in
          *permission*) state=needs ;;
          *) exit 0 ;;
        esac ;;
      *) exit 0 ;;
    esac ;;

  *) exit 0 ;;
esac

[ "${CLAUDE_KITTY_DEBUG:-}" = "1" ] && \
  printf '%s win=%s event=%s bg=%s cron=%s -> %s\n' "$(date +%H:%M:%S)" \
    "$KITTY_WINDOW_ID" "$event" "$bg" "$cron" "$state" \
    >> "$STATE_DIR/debug.log" 2>/dev/null

# --- this tab: its title and every Claude window living in it ----------------
info=$("$KITTY" @ ls 2>/dev/null | jq -r --arg w "$KITTY_WINDOW_ID" '
  .[].tabs[]
  | select(any(.windows[]; (.id|tostring) == $w))
  | { t: .title,
      ids: [ .windows[]
             | select(any(.foreground_processes[]?;
                          (.cmdline[0]? // "") | test("(^|/)claude$")))
             | .id ] }
  | "\(.t)\n\(.ids | join(" "))"' 2>/dev/null)
[ -n "$info" ] || exit 0
tab_title=$(printf '%s' "$info" | sed -n '1p')
tab_wids=$(printf '%s' "$info" | sed -n '2p')

# --- base label: keep a name the user set by hand ----------------------------
base=""
[ -f "$STATE_FILE" ] && base=$(sed -n '2p' "$STATE_FILE" 2>/dev/null)
if [ -z "$base" ]; then
  base=$(printf '%s' "$tab_title" \
         | sed -E 's/^[○◐●✓] ?//; s/ +[○◐●✓][0-9]+( [○◐●✓][0-9]+)*//; s/ +⋯[0-9]+//; s/ +⏱//')
  case "$base" in
    ""|zsh|bash|fish|claude|node) base=$(basename "$cwd") ;;
  esac
fi

if [ "$state" = "gone" ]; then
  rm -f "$STATE_FILE"
else
  printf '%s %s %s %s\n%s\n%s\n' "$state" "$(date +%s)" "$bg" "$cron" "$base" "$cwd" > "$STATE_FILE"
fi

# --- aggregate across every Claude window in this tab ------------------------
n_needs=0; n_work=0; n_done=0; n_idle=0; bg_sum=0; cron_sum=0
for wid in $tab_wids; do
  s=idle; b=0; c=0
  [ -f "$STATE_DIR/$wid" ] && read -r s _ b c < "$STATE_DIR/$wid" 2>/dev/null
  case "$b" in ''|*[!0-9]*) b=0 ;; esac
  case "$c" in ''|*[!0-9]*) c=0 ;; esac
  bg_sum=$((bg_sum + b)); cron_sum=$((cron_sum + c))
  case "$s" in
    needs)   n_needs=$((n_needs+1)) ;;
    working) n_work=$((n_work+1))   ;;
    done)    n_done=$((n_done+1))   ;;
    *)       n_idle=$((n_idle+1))   ;;
  esac
done
total=$((n_needs + n_work + n_done + n_idle))

# Two variants per state: vivid for the tab you are on, muted for the rest.
if   [ "$n_needs" -gt 0 ]; then
  glyph="●"; abg="#ff5f56"; afg="#2b0000"; ibg="#5c1f1f"; ifg="#e8a0a0"
elif [ "$n_work" -gt 0 ]; then
  glyph="◐"; abg="#5aa9ff"; afg="#00182e"; ibg="#1f3a5c"; ifg="#9dc4e8"
elif [ "$n_done" -gt 0 ]; then
  glyph="✓"; abg="#5ddc7a"; afg="#002a12"; ibg="#1f4d2c"; ifg="#9fd9ae"
else
  glyph="○"; abg="NONE"; afg="NONE"; ibg="NONE"; ifg="NONE"
fi

sfx=""
[ "$bg_sum"   -gt 0 ] && sfx=" ⋯$bg_sum"
[ "$cron_sum" -gt 0 ] && sfx="$sfx ⏱"

if [ "$total" -le 1 ]; then
  title="$glyph $base$sfx"
else
  tally=""
  [ "$n_needs" -gt 0 ] && tally="$tally ●$n_needs"
  [ "$n_work"  -gt 0 ] && tally="$tally ◐$n_work"
  [ "$n_done"  -gt 0 ] && tally="$tally ✓$n_done"
  [ "$n_idle"  -gt 0 ] && tally="$tally ○$n_idle"
  title="$base$tally$sfx"
fi

if [ "$state" = "gone" ] && [ "$total" -le 1 ]; then
  title="$base"; abg=NONE; afg=NONE; ibg=NONE; ifg=NONE
fi

"$KITTY" @ set-tab-title --match "window_id:$KITTY_WINDOW_ID" "$title" >/dev/null 2>&1
"$KITTY" @ set-tab-color --match "window_id:$KITTY_WINDOW_ID" \
    "active_bg=$abg" "active_fg=$afg" \
    "inactive_bg=$ibg" "inactive_fg=$ifg" >/dev/null 2>&1
exit 0
