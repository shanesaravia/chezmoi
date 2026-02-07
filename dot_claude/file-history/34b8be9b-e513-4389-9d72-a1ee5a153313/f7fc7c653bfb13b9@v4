import { useCallback, useRef, useEffect } from 'react';
import { useTimerStore } from '../stores/timerStore';

// Create audio context for generating sounds
function createBellSound(audioContext: AudioContext, volume: number): void {
  const oscillator = audioContext.createOscillator();
  const gainNode = audioContext.createGain();

  oscillator.connect(gainNode);
  gainNode.connect(audioContext.destination);

  oscillator.frequency.value = 800;
  oscillator.type = 'sine';

  gainNode.gain.setValueAtTime(volume, audioContext.currentTime);
  gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.8);

  oscillator.start(audioContext.currentTime);
  oscillator.stop(audioContext.currentTime + 0.8);
}

function createWarningBeep(audioContext: AudioContext, volume: number): void {
  const oscillator = audioContext.createOscillator();
  const gainNode = audioContext.createGain();

  oscillator.connect(gainNode);
  gainNode.connect(audioContext.destination);

  oscillator.frequency.value = 440;
  oscillator.type = 'square';

  gainNode.gain.setValueAtTime(volume * 0.5, audioContext.currentTime);
  gainNode.gain.exponentialRampToValueAtTime(0.01, audioContext.currentTime + 0.15);

  oscillator.start(audioContext.currentTime);
  oscillator.stop(audioContext.currentTime + 0.15);
}

export function useSound() {
  const status = useTimerStore((state) => state.status);
  const phase = useTimerStore((state) => state.phase);
  const currentRound = useTimerStore((state) => state.currentRound);
  const timeRemaining = useTimerStore((state) => state.timeRemaining);
  const roundDuration = useTimerStore((state) => state.roundDuration);
  const warningPlayed = useTimerStore((state) => state.warningPlayed);
  const warningThreshold = useTimerStore((state) => state.warningThreshold);
  const volume = useTimerStore((state) => state.volume);
  const setWarningPlayed = useTimerStore((state) => state.setWarningPlayed);

  const audioContextRef = useRef<AudioContext | null>(null);
  const prevPhaseRef = useRef(phase);
  const prevTimeRef = useRef(timeRemaining);

  const getAudioContext = useCallback(() => {
    if (!audioContextRef.current) {
      audioContextRef.current = new AudioContext();
    }
    return audioContextRef.current;
  }, []);

  const playBell = useCallback(() => {
    const ctx = getAudioContext();
    // Play bell sound twice for round end
    createBellSound(ctx, volume);
    setTimeout(() => createBellSound(ctx, volume), 300);
  }, [getAudioContext, volume]);

  const playWarning = useCallback(() => {
    const ctx = getAudioContext();
    createWarningBeep(ctx, volume);
  }, [getAudioContext, volume]);

  // Handle phase transitions
  useEffect(() => {
    if (status !== 'running') return;

    // Phase changed - play bell
    if (prevPhaseRef.current !== phase) {
      playBell();
      prevPhaseRef.current = phase;
    }

    // Check for warning threshold
    if (
      timeRemaining === warningThreshold &&
      prevTimeRef.current !== warningThreshold &&
      !warningPlayed
    ) {
      playWarning();
      setWarningPlayed(true);
    }

    prevTimeRef.current = timeRemaining;
  }, [status, phase, timeRemaining, warningThreshold, warningPlayed, playBell, playWarning, setWarningPlayed]);

  // Play bell when workout starts
  useEffect(() => {
    if (status === 'running' && currentRound === 1 && phase === 'round') {
      // Only play on initial start
      if (timeRemaining === roundDuration) {
        playBell();
      }
    }
  }, [status, currentRound, phase, timeRemaining, roundDuration, playBell]);

  // Cleanup
  useEffect(() => {
    return () => {
      if (audioContextRef.current) {
        audioContextRef.current.close();
      }
    };
  }, []);

  return { playBell, playWarning };
}
