import { useTimerStore } from '../stores/timerStore';

export function KeyboardHint() {
  const status = useTimerStore((state) => state.status);

  const hint =
    status === 'idle'
      ? 'Press SPACE to start'
      : status === 'running'
        ? 'Press SPACE to pause'
        : 'Press SPACE to resume';

  return (
    <div className="text-sm text-gray-500 dark:text-gray-400">
      {hint} · <span className="text-gray-400 dark:text-gray-500">R to reset</span>
    </div>
  );
}
