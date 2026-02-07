import { Settings, X, ChevronDown, ChevronUp } from 'lucide-react';
import { useState } from 'react';
import { clsx } from 'clsx';
import { useTimerStore } from '../stores/timerStore';
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

import type { ComboGroup } from '../types/timer';

const PUNCH_LEGEND = [
  { number: '1', name: 'Jab' },
  { number: '2', name: 'Cross' },
  { number: '3', name: 'Lead Hook' },
  { number: '4', name: 'Rear Hook' },
  { number: '5', name: 'Lead Uppercut' },
  { number: '6', name: 'Rear Uppercut' },
];

const COMBO_GROUPS: { key: ComboGroup; label: string; description: string }[] = [
  { key: 'basic', label: 'Basic', description: '1, 2, 1-1, 1-2' },
  { key: 'standard', label: 'Standard', description: '1-2-3, 2-3-2, etc.' },
  { key: 'withDefense', label: 'With Defense', description: 'Slip, Roll combos' },
  { key: 'long', label: 'Long', description: '5+ punch combos' },
];

export function SettingsPanel() {
  const [isOpen, setIsOpen] = useState(false);
  const [showLegend, setShowLegend] = useState(false);

  // Timer state
  const status = useTimerStore((state) => state.status);
  const totalRounds = useTimerStore((state) => state.totalRounds);
  const roundDuration = useTimerStore((state) => state.roundDuration);
  const restDuration = useTimerStore((state) => state.restDuration);

  // Settings
  const combosEnabled = useTimerStore((state) => state.combosEnabled);
  const comboInterval = useTimerStore((state) => state.comboInterval);
  const comboGroups = useTimerStore((state) => state.comboGroups);
  const warningThreshold = useTimerStore((state) => state.warningThreshold);
  const volume = useTimerStore((state) => state.volume);

  // Actions
  const setTotalRounds = useTimerStore((state) => state.setTotalRounds);
  const setRoundDuration = useTimerStore((state) => state.setRoundDuration);
  const setRestDuration = useTimerStore((state) => state.setRestDuration);
  const toggleCombos = useTimerStore((state) => state.toggleCombos);
  const setComboInterval = useTimerStore((state) => state.setComboInterval);
  const toggleComboGroup = useTimerStore((state) => state.toggleComboGroup);
  const setWarningThreshold = useTimerStore((state) => state.setWarningThreshold);
  const setVolume = useTimerStore((state) => state.setVolume);

  const isDisabled = status !== 'idle';

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
          <div className="relative bg-white dark:bg-gray-800 rounded-2xl shadow-xl w-full max-w-md max-h-[90vh] flex flex-col">
            <div className="flex items-center justify-between p-6 pb-0">
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

            <div className="flex-1 overflow-y-auto p-6 pt-4">
              {isDisabled && (
                <div className="mb-4 p-3 bg-amber-100 dark:bg-amber-900/30 text-amber-800 dark:text-amber-200 rounded-lg text-sm">
                  Timer settings can only be changed when the timer is stopped.
                </div>
              )}

              <div className="space-y-6">
                {/* Number of Rounds */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    Number of Rounds: {totalRounds}
                  </label>
                  <input
                    type="range"
                    min={MIN_ROUNDS}
                    max={MAX_ROUNDS}
                    value={totalRounds}
                    onChange={(e) => setTotalRounds(Number(e.target.value))}
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
                    Round Duration: {formatDuration(roundDuration)}
                  </label>
                  <input
                    type="range"
                    min={MIN_ROUND_DURATION}
                    max={MAX_ROUND_DURATION}
                    step={30}
                    value={roundDuration}
                    onChange={(e) => setRoundDuration(Number(e.target.value))}
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
                    Rest Duration: {formatDuration(restDuration)}
                  </label>
                  <input
                    type="range"
                    min={MIN_REST_DURATION}
                    max={MAX_REST_DURATION}
                    step={15}
                    value={restDuration}
                    onChange={(e) => setRestDuration(Number(e.target.value))}
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
                    Volume: {Math.round(volume * 100)}%
                  </label>
                  <input
                    type="range"
                    min={0}
                    max={1}
                    step={0.1}
                    value={volume}
                    onChange={(e) => setVolume(Number(e.target.value))}
                    className="w-full h-2 rounded-lg appearance-none cursor-pointer bg-gray-200 dark:bg-gray-700"
                  />
                </div>

                {/* Combo Prompts Toggle */}
                <div className="flex items-center justify-between">
                  <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
                    Combination Prompts
                  </span>
                  <button
                    onClick={toggleCombos}
                    className={clsx(
                      'relative inline-flex h-6 w-11 items-center rounded-full transition-colors',
                      combosEnabled
                        ? 'bg-green-600'
                        : 'bg-gray-300 dark:bg-gray-600'
                    )}
                  >
                    <span
                      className={clsx(
                        'inline-block h-4 w-4 transform rounded-full bg-white transition-transform',
                        combosEnabled ? 'translate-x-6' : 'translate-x-1'
                      )}
                    />
                  </button>
                </div>

                {/* Combo Interval (only shown if combos enabled) */}
                {combosEnabled && (
                  <>
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                        Combo Interval: {formatDuration(comboInterval)}
                      </label>
                      <input
                        type="range"
                        min={MIN_COMBO_INTERVAL}
                        max={MAX_COMBO_INTERVAL}
                        step={5}
                        value={comboInterval}
                        onChange={(e) => setComboInterval(Number(e.target.value))}
                        className="w-full h-2 rounded-lg appearance-none cursor-pointer bg-gray-200 dark:bg-gray-700"
                      />
                      <div className="flex justify-between text-xs text-gray-500 mt-1">
                        <span>{MIN_COMBO_INTERVAL}s</span>
                        <span>{formatDuration(MAX_COMBO_INTERVAL)}</span>
                      </div>
                    </div>

                    {/* Combo Groups */}
                    <div>
                      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-3">
                        Combo Types
                      </label>
                      <div className="space-y-2">
                        {COMBO_GROUPS.map(({ key, label, description }) => (
                          <label
                            key={key}
                            className="flex items-center gap-3 cursor-pointer"
                          >
                            <input
                              type="checkbox"
                              checked={comboGroups[key]}
                              onChange={() => toggleComboGroup(key)}
                              className="w-4 h-4 rounded border-gray-300 text-green-600 focus:ring-green-500 dark:border-gray-600 dark:bg-gray-700"
                            />
                            <div className="flex-1">
                              <span className="text-sm font-medium text-gray-700 dark:text-gray-300">
                                {label}
                              </span>
                              <span className="text-xs text-gray-500 dark:text-gray-500 ml-2">
                                {description}
                              </span>
                            </div>
                          </label>
                        ))}
                      </div>
                    </div>

                    {/* Punch Number Legend */}
                    <div className="border-t border-gray-200 dark:border-gray-700 pt-4">
                      <button
                        onClick={() => setShowLegend(!showLegend)}
                        className="flex items-center justify-between w-full text-sm font-medium text-gray-700 dark:text-gray-300"
                      >
                        <span>Punch Number Legend</span>
                        {showLegend ? (
                          <ChevronUp className="w-4 h-4" />
                        ) : (
                          <ChevronDown className="w-4 h-4" />
                        )}
                      </button>
                      {showLegend && (
                        <div className="mt-3 grid grid-cols-2 gap-2">
                          {PUNCH_LEGEND.map(({ number, name }) => (
                            <div
                              key={number}
                              className="flex items-center gap-2 text-sm text-gray-600 dark:text-gray-400"
                            >
                              <span className="font-mono font-bold text-gray-900 dark:text-white w-4">
                                {number}
                              </span>
                              <span>= {name}</span>
                            </div>
                          ))}
                          <div className="col-span-2 mt-2 text-xs text-gray-500 dark:text-gray-500">
                            Slip & Roll = Defensive movements
                          </div>
                        </div>
                      )}
                    </div>
                  </>
                )}

                {/* Warning Threshold */}
                <div>
                  <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                    Warning Sound: {warningThreshold}s before end
                  </label>
                  <input
                    type="range"
                    min={MIN_WARNING_THRESHOLD}
                    max={MAX_WARNING_THRESHOLD}
                    step={5}
                    value={warningThreshold}
                    onChange={(e) => setWarningThreshold(Number(e.target.value))}
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
        </div>
      )}
    </>
  );
}
