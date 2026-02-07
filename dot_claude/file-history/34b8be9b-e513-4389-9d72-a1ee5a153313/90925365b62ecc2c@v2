import type { TimerState, TimerAction } from '../types/timer';
import {
  DEFAULT_TOTAL_ROUNDS,
  DEFAULT_ROUND_DURATION,
  DEFAULT_REST_DURATION,
} from '../utils/constants';

export const initialTimerState: TimerState = {
  status: 'idle',
  phase: 'round',
  currentRound: 1,
  timeRemaining: DEFAULT_ROUND_DURATION,
  totalRounds: DEFAULT_TOTAL_ROUNDS,
  roundDuration: DEFAULT_ROUND_DURATION,
  restDuration: DEFAULT_REST_DURATION,
  warningPlayed: false,
};

export function timerReducer(state: TimerState, action: TimerAction): TimerState {
  switch (action.type) {
    case 'START':
      return { ...state, status: 'running' };

    case 'PAUSE':
      return { ...state, status: 'paused' };

    case 'TOGGLE':
      if (state.status === 'running') {
        return { ...state, status: 'paused' };
      }
      return { ...state, status: 'running' };

    case 'RESET':
      return {
        ...state,
        status: 'idle',
        phase: 'round',
        currentRound: 1,
        timeRemaining: state.roundDuration,
        warningPlayed: false,
      };

    case 'TICK': {
      if (state.status !== 'running') {
        return state;
      }

      const newTime = state.timeRemaining - 1;

      if (newTime > 0) {
        return { ...state, timeRemaining: newTime };
      }

      // Time has run out, transition to next phase
      if (state.phase === 'round') {
        // Check if this was the last round
        if (state.currentRound >= state.totalRounds) {
          // Workout complete
          return {
            ...state,
            status: 'idle',
            timeRemaining: 0,
            warningPlayed: false,
          };
        }
        // Move to rest phase
        return {
          ...state,
          phase: 'rest',
          timeRemaining: state.restDuration,
          warningPlayed: false,
        };
      } else {
        // Move from rest to next round
        return {
          ...state,
          phase: 'round',
          currentRound: state.currentRound + 1,
          timeRemaining: state.roundDuration,
          warningPlayed: false,
        };
      }
    }

    case 'SET_WARNING_PLAYED':
      return { ...state, warningPlayed: action.payload };

    case 'SET_TOTAL_ROUNDS':
      return {
        ...state,
        totalRounds: action.payload,
        // Reset if currently idle
        ...(state.status === 'idle' && {
          currentRound: 1,
          phase: 'round',
          timeRemaining: state.roundDuration,
        }),
      };

    case 'SET_ROUND_DURATION':
      return {
        ...state,
        roundDuration: action.payload,
        // Update current time if idle and in round phase
        ...(state.status === 'idle' &&
          state.phase === 'round' && {
            timeRemaining: action.payload,
          }),
      };

    case 'SET_REST_DURATION':
      return {
        ...state,
        restDuration: action.payload,
        // Update current time if idle and in rest phase
        ...(state.status === 'idle' &&
          state.phase === 'rest' && {
            timeRemaining: action.payload,
          }),
      };

    default:
      return state;
  }
}
