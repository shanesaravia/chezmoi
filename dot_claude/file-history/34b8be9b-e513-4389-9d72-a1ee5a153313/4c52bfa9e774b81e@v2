import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import type { TimerStatus, Phase, Theme, ComboGroup } from '../types/timer';
import {
  DEFAULT_TOTAL_ROUNDS,
  DEFAULT_ROUND_DURATION,
  DEFAULT_REST_DURATION,
  DEFAULT_COMBO_INTERVAL,
  DEFAULT_WARNING_THRESHOLD,
} from '../utils/constants';

interface TimerState {
  // Timer state
  status: TimerStatus;
  phase: Phase;
  currentRound: number;
  timeRemaining: number;
  warningPlayed: boolean;

  // Timer config (persisted)
  totalRounds: number;
  roundDuration: number;
  restDuration: number;

  // Settings (persisted)
  combosEnabled: boolean;
  comboInterval: number;
  comboGroups: Record<ComboGroup, boolean>;
  warningThreshold: number;
  theme: Theme;
  volume: number;
}

interface TimerActions {
  // Timer actions
  start: () => void;
  pause: () => void;
  toggle: () => void;
  reset: () => void;
  tick: () => void;
  setWarningPlayed: (played: boolean) => void;

  // Config actions
  setTotalRounds: (rounds: number) => void;
  setRoundDuration: (duration: number) => void;
  setRestDuration: (duration: number) => void;

  // Settings actions
  toggleCombos: () => void;
  setComboInterval: (interval: number) => void;
  toggleComboGroup: (group: ComboGroup) => void;
  setWarningThreshold: (threshold: number) => void;
  setTheme: (theme: Theme) => void;
  setVolume: (volume: number) => void;
}

type TimerStore = TimerState & TimerActions;

const initialState: TimerState = {
  // Timer state
  status: 'idle',
  phase: 'round',
  currentRound: 1,
  timeRemaining: DEFAULT_ROUND_DURATION,
  warningPlayed: false,

  // Timer config
  totalRounds: DEFAULT_TOTAL_ROUNDS,
  roundDuration: DEFAULT_ROUND_DURATION,
  restDuration: DEFAULT_REST_DURATION,

  // Settings
  combosEnabled: false,
  comboInterval: DEFAULT_COMBO_INTERVAL,
  comboGroups: {
    basic: true,
    standard: true,
    withDefense: true,
    long: true,
  },
  warningThreshold: DEFAULT_WARNING_THRESHOLD,
  theme: 'dark',
  volume: 0.7,
};

export const useTimerStore = create<TimerStore>()(
  persist(
    (set, get) => ({
      ...initialState,

      // Timer actions
      start: () => set({ status: 'running' }),

      pause: () => set({ status: 'paused' }),

      toggle: () => {
        const { status } = get();
        set({ status: status === 'running' ? 'paused' : 'running' });
      },

      reset: () => {
        const { roundDuration } = get();
        set({
          status: 'idle',
          phase: 'round',
          currentRound: 1,
          timeRemaining: roundDuration,
          warningPlayed: false,
        });
      },

      tick: () => {
        const state = get();
        if (state.status !== 'running') return;

        const newTime = state.timeRemaining - 1;

        if (newTime > 0) {
          set({ timeRemaining: newTime });
          return;
        }

        // Time has run out, transition to next phase
        if (state.phase === 'round') {
          // Check if this was the last round
          if (state.currentRound >= state.totalRounds) {
            // Workout complete
            set({
              status: 'idle',
              timeRemaining: 0,
              warningPlayed: false,
            });
            return;
          }
          // Move to rest phase
          set({
            phase: 'rest',
            timeRemaining: state.restDuration,
            warningPlayed: false,
          });
        } else {
          // Move from rest to next round
          set({
            phase: 'round',
            currentRound: state.currentRound + 1,
            timeRemaining: state.roundDuration,
            warningPlayed: false,
          });
        }
      },

      setWarningPlayed: (played) => set({ warningPlayed: played }),

      // Config actions
      setTotalRounds: (rounds) => {
        const { status } = get();
        set({
          totalRounds: rounds,
          ...(status === 'idle' && {
            currentRound: 1,
            phase: 'round' as const,
          }),
        });
      },

      setRoundDuration: (duration) => {
        const { status, phase } = get();
        set({
          roundDuration: duration,
          ...(status === 'idle' && phase === 'round' && {
            timeRemaining: duration,
          }),
        });
      },

      setRestDuration: (duration) => {
        const { status, phase } = get();
        set({
          restDuration: duration,
          ...(status === 'idle' && phase === 'rest' && {
            timeRemaining: duration,
          }),
        });
      },

      // Settings actions
      toggleCombos: () => set((state) => ({ combosEnabled: !state.combosEnabled })),

      setComboInterval: (interval) => set({ comboInterval: interval }),

      toggleComboGroup: (group) =>
        set((state) => ({
          comboGroups: {
            ...state.comboGroups,
            [group]: !state.comboGroups[group],
          },
        })),

      setWarningThreshold: (threshold) => set({ warningThreshold: threshold }),

      setTheme: (theme) => set({ theme }),

      setVolume: (volume) => set({ volume }),
    }),
    {
      name: 'boxing-timer-storage',
      partialize: (state) => ({
        // Only persist config and settings, not runtime state
        totalRounds: state.totalRounds,
        roundDuration: state.roundDuration,
        restDuration: state.restDuration,
        combosEnabled: state.combosEnabled,
        comboInterval: state.comboInterval,
        comboGroups: state.comboGroups,
        warningThreshold: state.warningThreshold,
        theme: state.theme,
        volume: state.volume,
      }),
      onRehydrateStorage: () => (state) => {
        // Set initial timeRemaining based on restored roundDuration
        if (state) {
          state.timeRemaining = state.roundDuration;
        }
      },
    }
  )
);
