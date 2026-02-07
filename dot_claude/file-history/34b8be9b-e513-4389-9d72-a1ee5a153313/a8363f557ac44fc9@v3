import { clsx } from 'clsx';
import { useTimerStore } from '../stores/timerStore';

export function PhaseIndicator() {
  const status = useTimerStore((state) => state.status);
  const phase = useTimerStore((state) => state.phase);
  const timeRemaining = useTimerStore((state) => state.timeRemaining);

  const isComplete = status === 'idle' && timeRemaining === 0;

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
            phase === 'round' && status !== 'paused',
          'bg-blue-500/20 text-blue-500 border border-blue-500/30':
            phase === 'rest' && status !== 'paused',
          'bg-amber-500/20 text-amber-500 border border-amber-500/30':
            status === 'paused',
        }
      )}
    >
      {status === 'paused' ? 'Paused' : phase === 'round' ? 'Round' : 'Rest'}
    </span>
  );
}
