# Boxing Rounds App - Implementation Plan

## Overview
A React + TypeScript boxing training timer app with start/pause/reset controls, space bar keyboard support, configurable rounds, and audio notifications.

## Tech Stack
- **Build Tool**: Vite (fast HMR, native TypeScript)
- **Framework**: React 18 + TypeScript
- **Styling**: Tailwind CSS (rapid development, responsive, dark mode support)
- **State Management**: React Context + useReducer (simple, no external deps)
- **Icons**: lucide-react
- **Testing**: Vitest + React Testing Library

## Core Features (MVP)
1. **Timer Display** - Large MM:SS format, visible from distance
2. **Round/Rest Phases** - Default 3-minute rounds, 1-minute rest
3. **Round Counter** - "Round X of Y" display
4. **Controls** - Play/Pause, Reset buttons
5. **Space Bar Control** - Primary keyboard control
6. **Sound Notifications** - Bell at round/rest transitions
7. **Configurable Settings**:
   - Number of rounds (1-20)
   - Round duration (1-5 minutes)
   - Rest duration (30 seconds - 2 minutes)
8. **Visual States** - Color-coded phases (green=round, blue=rest, amber=paused)
9. **10-Second Warning** - Audio beep + visual pulse before phase ends
10. **Dark Mode** - Dark theme by default with light mode toggle
11. **Combination Prompts** - Random boxing combo callouts during rounds:
    - Basic: "Jab", "Cross", "Hook", "Uppercut"
    - Combos: "1-2", "1-2-3", "Jab-Cross-Hook", "Body-Head"
    - Configurable frequency/on-off toggle

## Future Features (Post-MVP)
- Settings persistence (localStorage)
- Fullscreen mode
- Wake lock (prevent screen sleep)
- PWA support (offline, installable)
- Custom sound selection
- Workout history/stats

## Project Structure
```
/src
├── main.tsx
├── App.tsx
├── index.css
├── components/
│   ├── Layout.tsx
│   ├── TimerDisplay.tsx
│   ├── TimeDisplay.tsx
│   ├── PhaseIndicator.tsx
│   ├── RoundIndicator.tsx
│   ├── Controls.tsx
│   ├── Button.tsx
│   ├── SettingsPanel.tsx
│   ├── KeyboardHint.tsx
│   ├── CombinationPrompt.tsx
│   └── ThemeToggle.tsx
├── context/
│   └── TimerContext.tsx
├── hooks/
│   ├── useTimer.ts
│   ├── useKeyboard.ts
│   ├── useSound.ts
│   └── useCombinations.ts
├── reducers/
│   └── timerReducer.ts
├── types/
│   └── timer.ts
├── utils/
│   ├── formatTime.ts
│   └── constants.ts
└── assets/sounds/
    ├── bell.mp3
    └── warning.mp3
```

## Timer State Shape
```typescript
interface TimerState {
  status: 'idle' | 'running' | 'paused';
  phase: 'round' | 'rest';
  currentRound: number;
  timeRemaining: number;
  totalRounds: number;
  roundDuration: number;   // in seconds (60-300)
  restDuration: number;    // in seconds (30-120)
  warningPlayed: boolean;  // track if 10-sec warning played
}

interface Settings {
  combosEnabled: boolean;
  comboInterval: number;   // seconds between prompts
  theme: 'dark' | 'light';
  volume: number;
}
```

## Implementation Steps

### Phase 1: Project Setup
1. Initialize Vite React-TS project in existing repo
2. Install dependencies (tailwindcss, lucide-react, clsx)
3. Configure Tailwind CSS with dark mode
4. Set up base layout and global styles

### Phase 2: Core Timer Logic
1. Define TypeScript types for timer state and actions
2. Create timerReducer with state transitions (START, PAUSE, TOGGLE, RESET, TICK)
3. Create TimerContext provider
4. Create useTimer hook (manages setInterval, dispatches TICK)

### Phase 3: Keyboard & Sound
1. Create useKeyboard hook (space bar handling, prevent scroll)
2. Create useSound hook (preload and play bell sounds)
3. Source royalty-free boxing bell sound (MP3)

### Phase 4: UI Components
1. Build TimerDisplay with large time, phase badge, round counter
2. Build Controls with Play/Pause and Reset buttons
3. Build SettingsPanel for configuring rounds/durations
4. Add color-coded visual states and transitions
5. Make responsive for mobile

### Phase 5: Combination Prompts
1. Create useCombinations hook (random selection, configurable interval)
2. Define combo library (jabs, crosses, hooks, numbered combos)
3. Build CombinationPrompt component (large text overlay, fade animation)
4. Add combo settings toggle in SettingsPanel

### Phase 6: Polish & Integration
1. Wire all components together
2. Implement dark mode with Tailwind (dark: classes, default dark)
3. Add ThemeToggle component
4. Add keyboard hints ("Press SPACE to start")
5. Test full workout flow with all features

## Verification Plan
1. **Manual Testing**:
   - Start/pause/reset via buttons and space bar
   - Complete a full 3-round workout
   - Verify sounds play at each transition
   - Test settings changes
   - Test on mobile viewport

2. **Unit Tests**:
   - timerReducer state transitions
   - formatTime utility
   - useTimer hook behavior

3. **Run Commands**:
   - `npm run dev` - Start development server
   - `npm run build` - Verify production build
   - `npm run test` - Run test suite
