import { useState, useEffect, useRef, useCallback, useMemo } from 'react';
import { useTimerStore } from '../stores/timerStore';
import { COMBINATIONS } from '../utils/constants';

export function useCombinations() {
  const status = useTimerStore((state) => state.status);
  const phase = useTimerStore((state) => state.phase);
  const currentRound = useTimerStore((state) => state.currentRound);
  const timeRemaining = useTimerStore((state) => state.timeRemaining);
  const roundDuration = useTimerStore((state) => state.roundDuration);
  const combosEnabled = useTimerStore((state) => state.combosEnabled);
  const comboInterval = useTimerStore((state) => state.comboInterval);
  const comboGroups = useTimerStore((state) => state.comboGroups);

  const [currentCombo, setCurrentCombo] = useState<string | null>(null);
  const [isVisible, setIsVisible] = useState(false);
  const lastComboTimeRef = useRef(-1); // -1 means no combo shown yet this round
  const timeoutRef = useRef<number | null>(null);
  const prevRoundRef = useRef(currentRound);
  const prevPhaseRef = useRef(phase);

  // Build filtered combo list based on enabled groups
  const availableCombos = useMemo(() => {
    const combos: string[] = [];
    if (comboGroups.basic) combos.push(...COMBINATIONS.basic);
    if (comboGroups.standard) combos.push(...COMBINATIONS.standard);
    if (comboGroups.withDefense) combos.push(...COMBINATIONS.withDefense);
    if (comboGroups.long) combos.push(...COMBINATIONS.long);
    return combos;
  }, [comboGroups]);

  const showCombo = useCallback(() => {
    if (availableCombos.length === 0) return;
    const randomIndex = Math.floor(Math.random() * availableCombos.length);
    setCurrentCombo(availableCombos[randomIndex]);
    setIsVisible(true);

    // Hide after 2 seconds
    if (timeoutRef.current) {
      clearTimeout(timeoutRef.current);
    }
    timeoutRef.current = window.setTimeout(() => {
      setIsVisible(false);
    }, 2000);
  }, [availableCombos]);

  useEffect(() => {
    // Reset when entering a new round
    if (
      currentRound !== prevRoundRef.current ||
      phase !== prevPhaseRef.current
    ) {
      prevRoundRef.current = currentRound;
      prevPhaseRef.current = phase;
      lastComboTimeRef.current = -1; // Reset for new round
    }

    // Only show combos during active rounds
    if (
      status !== 'running' ||
      phase !== 'round' ||
      !combosEnabled
    ) {
      setIsVisible(false);
      return;
    }

    // Calculate elapsed time in current round
    const elapsedTime = roundDuration - timeRemaining;

    // Show combo immediately when round starts (no combo shown yet this round)
    if (lastComboTimeRef.current === -1) {
      lastComboTimeRef.current = 0;
      showCombo();
      return;
    }

    // Check if it's time to show a new combo based on interval
    if (elapsedTime >= lastComboTimeRef.current + comboInterval) {
      lastComboTimeRef.current = elapsedTime;
      showCombo();
    }
  }, [status, phase, currentRound, timeRemaining, roundDuration, combosEnabled, comboInterval, showCombo]);

  // Reset when timer resets
  useEffect(() => {
    if (status === 'idle') {
      lastComboTimeRef.current = -1;
      setIsVisible(false);
      setCurrentCombo(null);
    }
  }, [status]);

  // Cleanup
  useEffect(() => {
    return () => {
      if (timeoutRef.current) {
        clearTimeout(timeoutRef.current);
      }
    };
  }, []);

  return { currentCombo, isVisible };
}
