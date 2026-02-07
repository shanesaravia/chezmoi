import { clsx } from 'clsx';
import { useTimerStore } from '../stores/timerStore';
import { formatTime } from '../utils/formatTime';

export function TimeDisplay() {
  const status = useTimerStore((state) => state.status);
  const phase = useTimerStore((state) => state.phase);
  const timeRemaining = useTimerStore((state) => state.timeRemaining);
  const warningThreshold = useTimerStore((state) => state.warningThreshold);

  const isWarning = timeRemaining <= warningThreshold && status === 'running';

  return (
    <div
      className={clsx(
        'font-mono text-8xl sm:text-9xl font-bold tracking-tight transition-all duration-300',
        {
          'text-green-500': phase === 'round' && status === 'running' && !isWarning,
          'text-blue-500': phase === 'rest' && status === 'running' && !isWarning,
          'text-amber-500': status === 'paused',
          'text-gray-400 dark:text-gray-500': status === 'idle',
          'text-red-500 animate-pulse': isWarning,
        }
      )}
    >
      {formatTime(timeRemaining)}
    </div>
  );
}
