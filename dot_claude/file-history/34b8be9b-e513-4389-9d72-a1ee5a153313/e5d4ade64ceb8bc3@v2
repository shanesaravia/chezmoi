import { useTimerContext } from '../context/TimerContext';

export function KeyboardHint() {
  const { state } = useTimerContext();

  const hint =
    state.status === 'idle'
      ? 'Press SPACE to start'
      : state.status === 'running'
        ? 'Press SPACE to pause'
        : 'Press SPACE to resume';

  return (
    <div className="text-sm text-gray-500 dark:text-gray-400">
      {hint} · <span className="text-gray-400 dark:text-gray-500">R to reset</span>
    </div>
  );
}
