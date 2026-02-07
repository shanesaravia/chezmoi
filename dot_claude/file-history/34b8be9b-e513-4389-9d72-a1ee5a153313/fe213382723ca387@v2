import {
  createContext,
  useContext,
  useReducer,
  useCallback,
  useEffect,
  type ReactNode,
} from 'react';
import type { TimerState, TimerAction, Settings, SettingsAction } from '../types/timer';
import { timerReducer, initialTimerState } from '../reducers/timerReducer';
import { settingsReducer, initialSettings } from '../reducers/settingsReducer';

interface TimerContextValue {
  state: TimerState;
  settings: Settings;
  dispatch: React.Dispatch<TimerAction>;
  dispatchSettings: React.Dispatch<SettingsAction>;
  toggle: () => void;
  reset: () => void;
}

const TimerContext = createContext<TimerContextValue | null>(null);

export function TimerProvider({ children }: { children: ReactNode }) {
  const [state, dispatch] = useReducer(timerReducer, initialTimerState);
  const [settings, dispatchSettings] = useReducer(settingsReducer, initialSettings);

  const toggle = useCallback(() => {
    dispatch({ type: 'TOGGLE' });
  }, []);

  const reset = useCallback(() => {
    dispatch({ type: 'RESET' });
  }, []);

  // Apply theme to document
  useEffect(() => {
    if (settings.theme === 'dark') {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [settings.theme]);

  return (
    <TimerContext.Provider
      value={{ state, settings, dispatch, dispatchSettings, toggle, reset }}
    >
      {children}
    </TimerContext.Provider>
  );
}

export function useTimerContext() {
  const context = useContext(TimerContext);
  if (!context) {
    throw new Error('useTimerContext must be used within a TimerProvider');
  }
  return context;
}
