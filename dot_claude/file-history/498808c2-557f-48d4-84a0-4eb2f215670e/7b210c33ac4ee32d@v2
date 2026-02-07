import { describe, it, expect, vi, beforeEach, afterEach } from 'vitest';
import { renderHook } from '@testing-library/react';
import { useSound } from './useSound';

const mockState: Record<string, any> = {};

vi.mock('../stores/timerStore', () => ({
  useTimerStore: (selector: (state: any) => any) => selector(mockState),
}));

function createMockGainNode() {
  return {
    connect: vi.fn(),
    gain: {
      value: 0,
      setValueAtTime: vi.fn(),
      exponentialRampToValueAtTime: vi.fn(),
    },
  };
}

function createMockOscillator() {
  return {
    connect: vi.fn(),
    start: vi.fn(),
    stop: vi.fn(),
    frequency: { value: 0 },
    type: 'sine' as OscillatorType,
  };
}

let mockGainNode: ReturnType<typeof createMockGainNode>;
let mockOscillator: ReturnType<typeof createMockOscillator>;

function setMockState(overrides: Record<string, any> = {}) {
  for (const key of Object.keys(mockState)) delete mockState[key];
  Object.assign(mockState, {
    status: 'idle',
    phase: 'round',
    currentRound: 1,
    timeRemaining: 180,
    roundDuration: 180,
    warningPlayed: false,
    warningThreshold: 30,
    volume: 0.7,
    setWarningPlayed: vi.fn(),
    ...overrides,
  });
}

describe('playComboAlert', () => {
  beforeEach(() => {
    mockGainNode = createMockGainNode();
    mockOscillator = createMockOscillator();

    vi.stubGlobal('AudioContext', vi.fn(() => ({
      createOscillator: vi.fn(() => mockOscillator),
      createGain: vi.fn(() => mockGainNode),
      destination: {},
      currentTime: 0,
      close: vi.fn(),
    })));

    setMockState();
  });

  afterEach(() => {
    vi.restoreAllMocks();
    vi.unstubAllGlobals();
  });

  it('should create a triangle wave oscillator at 600Hz', () => {
    const { result } = renderHook(() => useSound());
    result.current.playComboAlert();

    expect(mockOscillator.frequency.value).toBe(600);
    expect(mockOscillator.type).toBe('triangle');
    expect(mockOscillator.connect).toHaveBeenCalledWith(mockGainNode);
    expect(mockGainNode.connect).toHaveBeenCalled();
    expect(mockOscillator.start).toHaveBeenCalled();
    expect(mockOscillator.stop).toHaveBeenCalled();
  });

  it('should use volume at 50% for combo sounds', () => {
    const volume = 0.7;
    setMockState({ volume });

    const { result } = renderHook(() => useSound());
    result.current.playComboAlert();

    expect(mockGainNode.gain.setValueAtTime).toHaveBeenCalledWith(volume * 0.5, 0);
    expect(mockGainNode.gain.exponentialRampToValueAtTime).toHaveBeenCalledWith(0.01, 0.1);
  });
});
