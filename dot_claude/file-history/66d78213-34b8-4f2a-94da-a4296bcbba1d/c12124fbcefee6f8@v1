import { clsx } from 'clsx';
import { useCombinations } from '../hooks/useCombinations';

export function CombinationPrompt() {
  const { currentCombo, isVisible } = useCombinations();

  if (!currentCombo) return null;

  return (
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
        {currentCombo}
      </div>
    </div>
  );
}
