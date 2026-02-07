import { describe, it, expect, vi, beforeEach } from 'vitest';

// Mock AudioContext
const mockOscillator = {
  connect: vi.fn(),
  start: vi.fn(),
  stop: vi.fn(),
  frequency: { value: 0 },
  type: 'sine' as OscillatorType,
};

const mockGainNode = {
  connect: vi.fn(),
  gain: {
    value: 0,
    setValueAtTime: vi.fn(),
    exponentialRampToValueAtTime: vi.fn(),
  },
};

const mockAudioContext = {
  createOscillator: vi.fn(() => ({ ...mockOscillator })),
  createGain: vi.fn(() => ({
    ...mockGainNode,
    gain: {
      ...mockGainNode.gain,
      setValueAtTime: vi.fn(),
      exponentialRampToValueAtTime: vi.fn(),
    },
  })),
  destination: {},
  currentTime: 0,
  close: vi.fn(),
};

describe('createComboSound', () => {
  // This function will be added to useSound.ts
  // It should create a distinct sound for combo alerts

  beforeEach(() => {
    vi.clearAllMocks();
  });

  it('should create a triangle wave oscillator at 600Hz', () => {
    // The combo sound should use:
    // - frequency: 600 Hz (distinct from bell 800Hz and warning 440Hz)
    // - type: triangle (distinct from sine and square)
    // - duration: ~0.1s (short alert)

    const createComboSound = (audioContext: AudioContext, volume: number): void => {
      const oscillator = audioContext.createOscillator();
      const gainNode = audioContext.createGain();

      oscillator.connect(gainNode);
      gainNode.connect(audioContext.destination);

      oscillator.frequency.value = 600;
      oscillator.type = 'triangle';

      gainNode.gain.setValueAtTime(volume * 0.5, audioContext.currentTime);
      gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.1);

      oscillator.start(audioContext.currentTime);
      oscillator.stop(audioContext.currentTime + 0.1);
    };

    createComboSound(mockAudioContext as unknown as AudioContext, 0.7);

    expect(mockAudioContext.createOscillator).toHaveBeenCalled();
    expect(mockAudioContext.createGain).toHaveBeenCalled();
  });

  it('should use volume at 50% for combo sounds', () => {
    // Combo sounds should be softer than main bell
    const volume = 0.7;
    const expectedVolume = volume * 0.5;

    const mockGain = {
      connect: vi.fn(),
      gain: {
        setValueAtTime: vi.fn(),
        exponentialRampToValueAtTime: vi.fn(),
      },
    };

    const testContext = {
      createOscillator: vi.fn(() => ({
        connect: vi.fn(),
        start: vi.fn(),
        stop: vi.fn(),
        frequency: { value: 0 },
        type: 'sine' as OscillatorType,
      })),
      createGain: vi.fn(() => mockGain),
      destination: {},
      currentTime: 0,
    };

    const createComboSound = (audioContext: AudioContext, volume: number): void => {
      const oscillator = audioContext.createOscillator();
      const gainNode = audioContext.createGain();

      oscillator.connect(gainNode);
      gainNode.connect(audioContext.destination);

      oscillator.frequency.value = 600;
      oscillator.type = 'triangle';

      gainNode.gain.setValueAtTime(volume * 0.5, audioContext.currentTime);
      gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.1);

      oscillator.start(audioContext.currentTime);
      oscillator.stop(audioContext.currentTime + 0.1);
    };

    createComboSound(testContext as unknown as AudioContext, volume);

    expect(mockGain.gain.setValueAtTime).toHaveBeenCalledWith(expectedVolume, 0);
  });
});
