import { useEffect, useCallback } from 'react';
import { useTimerContext } from '../context/TimerContext';

export function useKeyboard() {
  const { toggle, reset } = useTimerContext();

  const handleKeyDown = useCallback(
    (event: KeyboardEvent) => {
      // Ignore if typing in an input field
      if (
        event.target instanceof HTMLInputElement ||
        event.target instanceof HTMLTextAreaElement ||
        event.target instanceof HTMLSelectElement
      ) {
        return;
      }

      switch (event.code) {
        case 'Space':
          event.preventDefault(); // Prevent page scroll
          toggle();
          break;
        case 'KeyR':
          if (!event.metaKey && !event.ctrlKey) {
            event.preventDefault();
            reset();
          }
          break;
        case 'Escape':
          reset();
          break;
      }
    },
    [toggle, reset]
  );

  useEffect(() => {
    window.addEventListener('keydown', handleKeyDown);
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, [handleKeyDown]);
}
