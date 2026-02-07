import { useState, useEffect, useRef, useCallback, useMemo } from 'react';
import { useTimerContext } from '../context/TimerContext';
import { COMBINATIONS } from '../utils/constants';

export function useCombinations() {
  const { state, settings } = useTimerContext();
  const [currentCombo, setCurrentCombo] = useState<string | null>(null);
  const [isVisible, setIsVisible] = useState(false);
  const lastComboTimeRef = useRef(-1); // -1 means no combo shown yet this round
  const timeoutRef = useRef<number | null>(null);
  const prevRoundRef = useRef(state.currentRound);
  const prevPhaseRef = useRef(state.phase);

  // Build filtered combo list based on enabled groups
  const availableCombos = useMemo(() => {
    const combos: string[] = [];
    if (settings.comboGroups.basic) combos.push(...COMBINATIONS.basic);
    if (settings.comboGroups.standard) combos.push(...COMBINATIONS.standard);
    if (settings.comboGroups.withDefense) combos.push(...COMBINATIONS.withDefense);
    if (settings.comboGroups.long) combos.push(...COMBINATIONS.long);
    return combos;
  }, [settings.comboGroups]);

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
      state.currentRound !== prevRoundRef.current ||
      state.phase !== prevPhaseRef.current
    ) {
      prevRoundRef.current = state.currentRound;
      prevPhaseRef.current = state.phase;
      lastComboTimeRef.current = -1; // Reset for new round
    }

    // Only show combos during active rounds
    if (
      state.status !== 'running' ||
      state.phase !== 'round' ||
      !settings.combosEnabled
    ) {
      setIsVisible(false);
      return;
    }

    // Calculate elapsed time in current round
    const elapsedTime = state.roundDuration - state.timeRemaining;

    // Show combo immediately when round starts (no combo shown yet this round)
    if (lastComboTimeRef.current === -1) {
      lastComboTimeRef.current = 0;
      showCombo();
      return;
    }

    // Check if it's time to show a new combo based on interval
    if (elapsedTime >= lastComboTimeRef.current + settings.comboInterval) {
      lastComboTimeRef.current = elapsedTime;
      showCombo();
    }
  }, [state, settings.combosEnabled, settings.comboInterval, showCombo]);

  // Reset when timer resets
  useEffect(() => {
    if (state.status === 'idle') {
      lastComboTimeRef.current = -1;
      setIsVisible(false);
      setCurrentCombo(null);
    }
  }, [state.status]);

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
