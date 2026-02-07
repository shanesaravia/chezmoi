import { describe, it, expect } from 'vitest';
import { timerReducer, initialTimerState } from './timerReducer';
import type { TimerState } from '../types/timer';

describe('timerReducer', () => {
  describe('START action', () => {
    it('changes status from idle to running', () => {
      const state = timerReducer(initialTimerState, { type: 'START' });
      expect(state.status).toBe('running');
    });

    it('changes status from paused to running', () => {
      const pausedState: TimerState = { ...initialTimerState, status: 'paused' };
      const state = timerReducer(pausedState, { type: 'START' });
      expect(state.status).toBe('running');
    });
  });

  describe('PAUSE action', () => {
    it('changes status from running to paused', () => {
      const runningState: TimerState = { ...initialTimerState, status: 'running' };
      const state = timerReducer(runningState, { type: 'PAUSE' });
      expect(state.status).toBe('paused');
    });
  });

  describe('TOGGLE action', () => {
    it('toggles from idle to running', () => {
      const state = timerReducer(initialTimerState, { type: 'TOGGLE' });
      expect(state.status).toBe('running');
    });

    it('toggles from running to paused', () => {
      const runningState: TimerState = { ...initialTimerState, status: 'running' };
      const state = timerReducer(runningState, { type: 'TOGGLE' });
      expect(state.status).toBe('paused');
    });

    it('toggles from paused to running', () => {
      const pausedState: TimerState = { ...initialTimerState, status: 'paused' };
      const state = timerReducer(pausedState, { type: 'TOGGLE' });
      expect(state.status).toBe('running');
    });
  });

  describe('RESET action', () => {
    it('resets to initial state', () => {
      const runningState: TimerState = {
        ...initialTimerState,
        status: 'running',
        currentRound: 3,
        timeRemaining: 45,
        phase: 'rest',
        warningPlayed: true,
      };
      const state = timerReducer(runningState, { type: 'RESET' });
      expect(state.status).toBe('idle');
      expect(state.currentRound).toBe(1);
      expect(state.phase).toBe('round');
      expect(state.timeRemaining).toBe(state.roundDuration);
      expect(state.warningPlayed).toBe(false);
    });
  });

  describe('TICK action', () => {
    it('decrements time when running', () => {
      const runningState: TimerState = {
        ...initialTimerState,
        status: 'running',
        timeRemaining: 100,
      };
      const state = timerReducer(runningState, { type: 'TICK' });
      expect(state.timeRemaining).toBe(99);
    });

    it('does nothing when not running', () => {
      const state = timerReducer(initialTimerState, { type: 'TICK' });
      expect(state.timeRemaining).toBe(initialTimerState.timeRemaining);
    });

    it('transitions from round to rest when time expires', () => {
      const runningState: TimerState = {
        ...initialTimerState,
        status: 'running',
        phase: 'round',
        timeRemaining: 1,
        currentRound: 1,
        totalRounds: 3,
        restDuration: 60,
      };
      const state = timerReducer(runningState, { type: 'TICK' });
      expect(state.phase).toBe('rest');
      expect(state.timeRemaining).toBe(60);
      expect(state.currentRound).toBe(1);
    });

    it('transitions from rest to next round when time expires', () => {
      const runningState: TimerState = {
        ...initialTimerState,
        status: 'running',
        phase: 'rest',
        timeRemaining: 1,
        currentRound: 1,
        totalRounds: 3,
        roundDuration: 180,
      };
      const state = timerReducer(runningState, { type: 'TICK' });
      expect(state.phase).toBe('round');
      expect(state.timeRemaining).toBe(180);
      expect(state.currentRound).toBe(2);
    });

    it('completes workout after last round', () => {
      const runningState: TimerState = {
        ...initialTimerState,
        status: 'running',
        phase: 'round',
        timeRemaining: 1,
        currentRound: 3,
        totalRounds: 3,
      };
      const state = timerReducer(runningState, { type: 'TICK' });
      expect(state.status).toBe('idle');
      expect(state.timeRemaining).toBe(0);
    });
  });

  describe('SET_TOTAL_ROUNDS action', () => {
    it('sets total rounds', () => {
      const state = timerReducer(initialTimerState, {
        type: 'SET_TOTAL_ROUNDS',
        payload: 10,
      });
      expect(state.totalRounds).toBe(10);
    });
  });

  describe('SET_ROUND_DURATION action', () => {
    it('sets round duration', () => {
      const state = timerReducer(initialTimerState, {
        type: 'SET_ROUND_DURATION',
        payload: 120,
      });
      expect(state.roundDuration).toBe(120);
    });

    it('updates timeRemaining when idle in round phase', () => {
      const state = timerReducer(initialTimerState, {
        type: 'SET_ROUND_DURATION',
        payload: 120,
      });
      expect(state.timeRemaining).toBe(120);
    });
  });

  describe('SET_REST_DURATION action', () => {
    it('sets rest duration', () => {
      const state = timerReducer(initialTimerState, {
        type: 'SET_REST_DURATION',
        payload: 90,
      });
      expect(state.restDuration).toBe(90);
    });
  });

  describe('SET_WARNING_PLAYED action', () => {
    it('sets warning played flag', () => {
      const state = timerReducer(initialTimerState, {
        type: 'SET_WARNING_PLAYED',
        payload: true,
      });
      expect(state.warningPlayed).toBe(true);
    });
  });
});
