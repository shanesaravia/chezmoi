import { Settings, X } from 'lucide-react';
import { useState } from 'react';
import { clsx } from 'clsx';
import { useTimerContext } from '../context/TimerContext';
import { formatDuration } from '../utils/formatTime';
import {
  MIN_ROUNDS,
  MAX_ROUNDS,
  MIN_ROUND_DURATION,
  MAX_ROUND_DURATION,
  MIN_REST_DURATION,
  MAX_REST_DURATION,
  MIN_COMBO_INTERVAL,
  MAX_COMBO_INTERVAL,
  MIN_WARNING_THRESHOLD,
  MAX_WARNING_THRESHOLD,
} from '../utils/constants';

export function SettingsPanel() {
  const [isOpen, setIsOpen] = useState(false);
  const { state, settings, dispatch, dispatchSettings } = useTimerContext();

  const isDisabled = state.status !== 'idle';

  return (
    <>
      <button
        onClick={() => setIsOpen(true)}
        className="p-2 rounded-lg text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
        aria-label="Open settings"
      >
        <Settings className="w-5 h-5" />
      </button>

      {isOpen && (
        <div className="fixed inset-0 z-50 flex items-center justify-center p-4">
          <div
            className="absolute inset-0 bg-black/50 backdrop-blur-sm"
            onClick={() => setIsOpen(false)}
          />
          <div className="relative bg-white dark:bg-gray-800 rounded-2xl shadow-xl w-full max-w-md p-6">
            <div className="flex items-center justify-between mb-6">
              <h2 className="text-xl font-bold text-gray-900 dark:text-white">
                Settings
              </h2>
              <button
                onClick={() => setIsOpen(false)}
                className="p-1 rounded-lg hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors"
              >
                <X className="w-5 h-5 text-gray-500" />
              </button>
            </div>

            {isDisabled && (
              <div className="mb-4 p-3 bg-amber-100 dark:bg-amber-900/30 text-amber-800 dark:text-amber-200 rounded-lg text-sm">
                Timer settings can only be changed when the timer is stopped.
              </div>
            )}

            <div className="space-y-6">
              {/* Number of Rounds */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Number of Rounds: {state.totalRounds}
                </label>
                <input
                  type="range"
                  min={MIN_ROUNDS}
                  max={MAX_ROUNDS}
                  value={state.totalRounds}
                  onChange={(e) =>
                    dispatch({ type: 'SET_TOTAL_ROUNDS', payload: Number(e.target.value) })
                  }
                  disabled={isDisabled}
                  className={clsx(
                    'w-full h-2 rounded-lg appearance-none cursor-pointer',
                    'bg-gray-200 dark:bg-gray-700',
                    isDisabled && 'opacity-50 cursor-not-allowed'
                  )}
                />
                <div className="flex justify-between text-xs text-gray-500 mt-1">
                  <span>{MIN_ROUNDS}</span>
                  <span>{MAX_ROUNDS}</span>
                </div>
              </div>

              {/* Round Duration */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Round Duration: {formatDuration(state.roundDuration)}
                </label>
                <input
                  type="range"
                  min={MIN_ROUND_DURATION}
                  max={MAX_ROUND_DURATION}
                  step={30}
                  value={state.roundDuration}
                  onChange={(e) =>
                    dispatch({ type: 'SET_ROUND_DURATION', payload: Number(e.target.value) })
                  }
                  disabled={isDisabled}
                  className={clsx(
                    'w-full h-2 rounded-lg appearance-none cursor-pointer',
                    'bg-gray-200 dark:bg-gray-700',
                    isDisabled && 'opacity-50 cursor-not-allowed'
                  )}
                />
                <div className="flex justify-between text-xs text-gray-500 mt-1">
                  <span>{formatDuration(MIN_ROUND_DURATION)}</span>
                  <span>{formatDuration(MAX_ROUND_DURATION)}</span>
                </div>
              </div>

              {/* Rest Duration */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Rest Duration: {formatDuration(state.restDuration)}
                </label>
                <input
                  type="range"
                  min={MIN_REST_DURATION}
                  max={MAX_REST_DURATION}
                  step={15}
                  value={state.restDuration}
                  onChange={(e) =>
                    dispatch({ type: 'SET_REST_DURATION', payload: Number(e.target.value) })
                  }
                  disabled={isDisabled}
                  className={clsx(
                    'w-full h-2 rounded-lg appearance-none cursor-pointer',
                    'bg-gray-200 dark:bg-gray-700',
                    isDisabled && 'opacity-50 cursor-not-allowed'
                  )}
                />
                <div className="flex justify-between text-xs text-gray-500 mt-1">
                  <span>{formatDuration(MIN_REST_DURATION)}</span>
                  <span>{formatDuration(MAX_REST_DURATION)}</span>
                </div>
              </div>

              {/* Volume */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Volume: {Math.round(settings.volume * 100)}%
                </label>
                <input
                  type="range"
                  min={0}
                  max={1}
                  step={0.1}
                  value={settings.volume}
                  onChange={(e) =>
                    dispatchSettings({ type: 'SET_VOLUME', payload: Number(e.target.value) })
                  }
                  className="w-full h-2 rounded-lg appearance-none cursor-pointer bg-gray-200 dark:bg-gray-700"
                />
              </div>

              {/* Combo Prompts Toggle */}
              <div className="flex items-center justify-between">
                <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
                  Combination Prompts
                </span>
                <button
                  onClick={() => dispatchSettings({ type: 'TOGGLE_COMBOS' })}
                  className={clsx(
                    'relative inline-flex h-6 w-11 items-center rounded-full transition-colors',
                    settings.combosEnabled
                      ? 'bg-green-600'
                      : 'bg-gray-300 dark:bg-gray-600'
                  )}
                >
                  <span
                    className={clsx(
                      'inline-block h-4 w-4 transform rounded-full bg-white transition-transform',
                      settings.combosEnabled ? 'translate-x-6' : 'translate-x-1'
                    )}
                  />
                </button>
              </div>

              {/* Combo Interval (only shown if combos enabled) */}
              {settings.combosEnabled && (
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    Combo Interval: {formatDuration(settings.comboInterval)}
                  </label>
                  <input
                    type="range"
                    min={MIN_COMBO_INTERVAL}
                    max={MAX_COMBO_INTERVAL}
                    step={5}
                    value={settings.comboInterval}
                    onChange={(e) =>
                      dispatchSettings({
                        type: 'SET_COMBO_INTERVAL',
                        payload: Number(e.target.value),
                      })
                    }
                    className="w-full h-2 rounded-lg appearance-none cursor-pointer bg-gray-200 dark:bg-gray-700"
                  />
                  <div className="flex justify-between text-xs text-gray-500 mt-1">
                    <span>{MIN_COMBO_INTERVAL}s</span>
                    <span>{formatDuration(MAX_COMBO_INTERVAL)}</span>
                  </div>
                </div>
              )}

              {/* Warning Threshold */}
              <div>
                <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                  Warning Sound: {settings.warningThreshold}s before end
                </label>
                <input
                  type="range"
                  min={MIN_WARNING_THRESHOLD}
                  max={MAX_WARNING_THRESHOLD}
                  step={5}
                  value={settings.warningThreshold}
                  onChange={(e) =>
                    dispatchSettings({
                      type: 'SET_WARNING_THRESHOLD',
                      payload: Number(e.target.value),
                    })
                  }
                  className="w-full h-2 rounded-lg appearance-none cursor-pointer bg-gray-200 dark:bg-gray-700"
                />
                <div className="flex justify-between text-xs text-gray-500 mt-1">
                  <span>{MIN_WARNING_THRESHOLD}s</span>
                  <span>{formatDuration(MAX_WARNING_THRESHOLD)}</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
