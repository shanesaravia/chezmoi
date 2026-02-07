import { useTimerContext } from '../context/TimerContext';

export function RoundIndicator() {
  const { state } = useTimerContext();

  return (
    <div className="text-2xl sm:text-3xl font-medium text-gray-600 dark:text-gray-400">
      Round{' '}
      <span className="text-gray-900 dark:text-white font-bold">
        {state.currentRound}
      </span>{' '}
      of{' '}
      <span className="text-gray-900 dark:text-white font-bold">
        {state.totalRounds}
      </span>
    </div>
  );
}
