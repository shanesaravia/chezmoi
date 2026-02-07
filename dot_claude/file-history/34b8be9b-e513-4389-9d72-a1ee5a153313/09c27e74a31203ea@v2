import { Play, Pause, RotateCcw } from 'lucide-react';
import { useTimerContext } from '../context/TimerContext';
import { Button } from './Button';

export function Controls() {
  const { state, toggle, reset } = useTimerContext();

  const isRunning = state.status === 'running';
  const isComplete = state.status === 'idle' && state.timeRemaining === 0;

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
        disabled={state.status === 'idle' && state.currentRound === 1}
      >
        <RotateCcw className="w-6 h-6" />
        Reset
      </Button>
    </div>
  );
}
