import { useEffect, useRef } from 'react';
import { useTimerContext } from '../context/TimerContext';

export function useTimer() {
  const { state, dispatch } = useTimerContext();
  const intervalRef = useRef<number | null>(null);

  useEffect(() => {
    if (state.status === 'running') {
      intervalRef.current = window.setInterval(() => {
        dispatch({ type: 'TICK' });
      }, 1000);
    } else {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
        intervalRef.current = null;
      }
    }

    return () => {
      if (intervalRef.current) {
        clearInterval(intervalRef.current);
      }
    };
  }, [state.status, dispatch]);

  return state;
}
