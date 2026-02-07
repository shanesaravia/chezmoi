import { clsx } from 'clsx';
import { useTimerContext } from '../context/TimerContext';

export function PhaseIndicator() {
  const { state } = useTimerContext();

  const isComplete = state.status === 'idle' && state.timeRemaining === 0;

  if (isComplete) {
    return (
      <span className="inline-block px-4 py-2 rounded-full text-lg font-semibold bg-green-500/20 text-green-500 border border-green-500/30">
        COMPLETE
      </span>
    );
  }

  return (
    <span
      className={clsx(
        'inline-block px-4 py-2 rounded-full text-lg font-semibold uppercase tracking-wider transition-colors',
        {
          'bg-green-500/20 text-green-500 border border-green-500/30':
            state.phase === 'round' && state.status !== 'paused',
          'bg-blue-500/20 text-blue-500 border border-blue-500/30':
            state.phase === 'rest' && state.status !== 'paused',
          'bg-amber-500/20 text-amber-500 border border-amber-500/30':
            state.status === 'paused',
        }
      )}
    >
      {state.status === 'paused' ? 'Paused' : state.phase === 'round' ? 'Round' : 'Rest'}
    </span>
  );
}
