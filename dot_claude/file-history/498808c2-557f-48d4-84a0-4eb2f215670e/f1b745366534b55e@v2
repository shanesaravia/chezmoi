import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { renderHook, act } from '@testing-library/react';
import { useCombinations } from './useCombinations';
import { COMBINATIONS } from '../utils/constants';

const mockState: Record<string, any> = {};

vi.mock('../stores/timerStore', () => ({
  useTimerStore: (selector: (state: any) => any) => selector(mockState),
}));

const allCombos = [
  ...COMBINATIONS.basic,
  ...COMBINATIONS.standard,
  ...COMBINATIONS.withDefense,
  ...COMBINATIONS.long,
];

const defaultState = {
  status: 'idle',
  phase: 'round',
  currentRound: 1,
  timeRemaining: 180,
  roundDuration: 180,
  combosEnabled: true,
  comboInterval: 60,
  comboGroups: { basic: true, standard: true, withDefense: true, long: true },
};

function setMockState(overrides: Partial<typeof defaultState> = {}) {
  for (const key of Object.keys(mockState)) delete mockState[key];
  Object.assign(mockState, { ...defaultState, ...overrides });
}

describe('useCombinations', () => {
  beforeEach(() => {
    vi.useFakeTimers();
    vi.spyOn(Math, 'random').mockReturnValue(0);
    setMockState();
  });

  afterEach(() => {
    vi.useRealTimers();
    vi.restoreAllMocks();
  });

  it('should return currentCombo, lastCombo, and isVisible', () => {
    const { result } = renderHook(() => useCombinations());

    expect(result.current).toEqual({
      currentCombo: null,
      lastCombo: null,
      isVisible: false,
    });
  });

  it('should show a combo immediately when round starts', () => {
    setMockState({ status: 'running', phase: 'round' });
    const { result } = renderHook(() => useCombinations());

    expect(result.current.currentCombo).toBe(allCombos[0]);
    expect(result.current.isVisible).toBe(true);
  });

  it('should update lastCombo when a new combo is shown', () => {
    setMockState({ status: 'running', phase: 'round' });
    const { result } = renderHook(() => useCombinations());

    expect(result.current.lastCombo).toBe(allCombos[0]);
    expect(result.current.lastCombo).toBe(result.current.currentCombo);
  });

  it('should keep lastCombo after visibility fades', () => {
    setMockState({ status: 'running', phase: 'round' });
    const { result } = renderHook(() => useCombinations());

    const combo = result.current.lastCombo;
    expect(result.current.isVisible).toBe(true);

    act(() => {
      vi.advanceTimersByTime(2000);
    });

    expect(result.current.isVisible).toBe(false);
    expect(result.current.lastCombo).toBe(combo);
  });

  it('should reset lastCombo when timer resets to idle', () => {
    setMockState({ status: 'running', phase: 'round' });
    const { result, rerender } = renderHook(() => useCombinations());
    expect(result.current.lastCombo).not.toBeNull();

    setMockState({ status: 'idle' });
    rerender();

    expect(result.current.lastCombo).toBeNull();
    expect(result.current.currentCombo).toBeNull();
    expect(result.current.isVisible).toBe(false);
  });

  it('should preserve lastCombo during rest phase', () => {
    setMockState({ status: 'running', phase: 'round' });
    const { result, rerender } = renderHook(() => useCombinations());
    const combo = result.current.lastCombo;
    expect(combo).not.toBeNull();

    setMockState({ status: 'running', phase: 'rest' });
    rerender();

    expect(result.current.lastCombo).toBe(combo);
    expect(result.current.isVisible).toBe(false);
  });

  it('should not show combos when combosEnabled is false', () => {
    setMockState({ status: 'running', phase: 'round', combosEnabled: false });
    const { result } = renderHook(() => useCombinations());

    expect(result.current.currentCombo).toBeNull();
    expect(result.current.isVisible).toBe(false);
  });

  it('should show new combo after interval elapses', () => {
    setMockState({ status: 'running', phase: 'round', timeRemaining: 180, comboInterval: 60 });
    const { result, rerender } = renderHook(() => useCombinations());

    expect(result.current.currentCombo).toBe(allCombos[0]);

    // Simulate 60 seconds elapsed (timeRemaining drops from 180 to 120)
    vi.spyOn(Math, 'random').mockReturnValue(0.1);
    setMockState({ status: 'running', phase: 'round', timeRemaining: 120, comboInterval: 60 });
    rerender();

    const expectedIndex = Math.floor(0.1 * allCombos.length);
    expect(result.current.currentCombo).toBe(allCombos[expectedIndex]);
    expect(result.current.isVisible).toBe(true);
  });

  it('should not show combos when paused', () => {
    setMockState({ status: 'running', phase: 'round' });
    const { result, rerender } = renderHook(() => useCombinations());
    expect(result.current.isVisible).toBe(true);

    setMockState({ status: 'paused', phase: 'round' });
    rerender();

    expect(result.current.isVisible).toBe(false);
  });

  it('should not show combos when no combo groups are enabled', () => {
    setMockState({
      status: 'running',
      phase: 'round',
      comboGroups: { basic: false, standard: false, withDefense: false, long: false },
    });
    const { result } = renderHook(() => useCombinations());

    expect(result.current.currentCombo).toBeNull();
  });
});
