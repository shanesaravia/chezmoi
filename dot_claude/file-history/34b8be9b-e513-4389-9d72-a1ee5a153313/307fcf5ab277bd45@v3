import { useTimerStore } from '../stores/timerStore';

export function RoundIndicator() {
  const currentRound = useTimerStore((state) => state.currentRound);
  const totalRounds = useTimerStore((state) => state.totalRounds);

  return (
    <div className="text-2xl sm:text-3xl font-medium text-gray-600 dark:text-gray-400">
      Round{' '}
      <span className="text-gray-900 dark:text-white font-bold">
        {currentRound}
      </span>{' '}
      of{' '}
      <span className="text-gray-900 dark:text-white font-bold">
        {totalRounds}
      </span>
    </div>
  );
}
