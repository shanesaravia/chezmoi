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

const STORAGE_KEYS = {
  settings: 'boxing-timer-settings',
  timerConfig: 'boxing-timer-config',
} as const;

function loadSettings(): Settings {
  try {
    const saved = localStorage.getItem(STORAGE_KEYS.settings);
    if (saved) {
      const parsed = JSON.parse(saved);
      // Merge with defaults to handle new properties
      return { ...initialSettings, ...parsed };
    }
  } catch {
    // Ignore parse errors
  }
  return initialSettings;
}

function loadTimerConfig(): TimerState {
  try {
    const saved = localStorage.getItem(STORAGE_KEYS.timerConfig);
    if (saved) {
      const parsed = JSON.parse(saved);
      // Only restore config values, not runtime state
      return {
        ...initialTimerState,
        totalRounds: parsed.totalRounds ?? initialTimerState.totalRounds,
        roundDuration: parsed.roundDuration ?? initialTimerState.roundDuration,
        restDuration: parsed.restDuration ?? initialTimerState.restDuration,
        timeRemaining: parsed.roundDuration ?? initialTimerState.roundDuration,
      };
    }
  } catch {
    // Ignore parse errors
  }
  return initialTimerState;
}

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
  const [state, dispatch] = useReducer(timerReducer, null, loadTimerConfig);
  const [settings, dispatchSettings] = useReducer(settingsReducer, null, loadSettings);

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

  // Persist settings to localStorage
  useEffect(() => {
    localStorage.setItem(STORAGE_KEYS.settings, JSON.stringify(settings));
  }, [settings]);

  // Persist timer config to localStorage
  useEffect(() => {
    const config = {
      totalRounds: state.totalRounds,
      roundDuration: state.roundDuration,
      restDuration: state.restDuration,
    };
    localStorage.setItem(STORAGE_KEYS.timerConfig, JSON.stringify(config));
  }, [state.totalRounds, state.roundDuration, state.restDuration]);

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
