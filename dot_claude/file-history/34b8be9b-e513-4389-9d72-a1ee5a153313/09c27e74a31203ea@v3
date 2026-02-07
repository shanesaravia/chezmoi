import { Play, Pause, RotateCcw } from 'lucide-react';
import { useTimerStore } from '../stores/timerStore';
import { Button } from './Button';

export function Controls() {
  const status = useTimerStore((state) => state.status);
  const currentRound = useTimerStore((state) => state.currentRound);
  const timeRemaining = useTimerStore((state) => state.timeRemaining);
  const toggle = useTimerStore((state) => state.toggle);
  const reset = useTimerStore((state) => state.reset);

  const isRunning = status === 'running';
  const isComplete = status === 'idle' && timeRemaining === 0;

  return (
    <div className="flex items-center gap-4">
      <Button
        variant="primary"
        size="lg"
        onClick={toggle}
        aria-label={isRunning ? 'Pause' : 'Start'}
      >
        {isRunning ? (
          <>
            <Pause className="w-6 h-6" />
            Pause
          </>
        ) : (
          <>
            <Play className="w-6 h-6" />
            {isComplete ? 'Restart' : 'Start'}
          </>
        )}
      </Button>
      <Button
        variant="secondary"
        size="lg"
        onClick={reset}
        aria-label="Reset"
        disabled={status === 'idle' && currentRound === 1}
      >
        <RotateCcw className="w-6 h-6" />
        Reset
      </Button>
    </div>
  );
}
