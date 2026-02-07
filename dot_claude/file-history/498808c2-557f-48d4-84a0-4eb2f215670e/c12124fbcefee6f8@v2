import { clsx } from 'clsx';
import { useEffect, useMemo, useRef, useState } from 'react';
import { useCombinations } from '../hooks/useCombinations';
import { useSound } from '../hooks/useSound';
import { addBodyShots } from '../utils/comboUtils';

export function CombinationPrompt() {
  const { currentCombo, lastCombo, isVisible } = useCombinations();
  const { playComboAlert } = useSound();
  const [lastDisplayCombo, setLastDisplayCombo] = useState<string | null>(null);
  const prevComboRef = useRef<string | null>(null);

  const displayCombo = useMemo(() => {
    return currentCombo ? addBodyShots(currentCombo) : null;
  }, [currentCombo]);

  // Play sound and save displayed combo when a new combo appears
  useEffect(() => {
    if (currentCombo && currentCombo !== prevComboRef.current) {
      playComboAlert();
      if (displayCombo) {
        setLastDisplayCombo(displayCombo);
      }
      prevComboRef.current = currentCombo;
    }
    // Reset when timer resets
    if (!lastCombo) {
      setLastDisplayCombo(null);
      prevComboRef.current = null;
    }
  }, [currentCombo, lastCombo, displayCombo, playComboAlert]);

  return (
    <>
      {/* Main combo prompt - centered overlay */}
      {displayCombo && (
        <div
          className={clsx(
            'fixed inset-0 flex items-center justify-center pointer-events-none z-50',
            'transition-opacity duration-300',
            isVisible ? 'opacity-100' : 'opacity-0'
          )}
        >
          <div
            className={clsx(
              'text-5xl sm:text-7xl font-bold text-white',
              'bg-black/60 px-8 py-6 rounded-2xl backdrop-blur-sm',
              'transform transition-transform duration-300',
              isVisible ? 'scale-100' : 'scale-90'
            )}
          >
            {displayCombo}
          </div>
        </div>
      )}

      {/* Last combo display - bottom right corner */}
      {lastDisplayCombo && !isVisible && (
        <div className="fixed bottom-4 right-4 pointer-events-none z-40">
          <div className="text-lg sm:text-xl font-medium text-white/70 bg-black/40 px-3 py-1.5 rounded-lg">
            {lastDisplayCombo}
          </div>
        </div>
      )}
    </>
  );
}
