import type { Settings, SettingsAction } from '../types/timer';
import { DEFAULT_COMBO_INTERVAL, DEFAULT_WARNING_THRESHOLD } from '../utils/constants';

export const initialSettings: Settings = {
  combosEnabled: false,
  comboInterval: DEFAULT_COMBO_INTERVAL,
  warningThreshold: DEFAULT_WARNING_THRESHOLD,
  theme: 'dark',
  volume: 0.7,
};

export function settingsReducer(state: Settings, action: SettingsAction): Settings {
  switch (action.type) {
    case 'TOGGLE_COMBOS':
      return { ...state, combosEnabled: !state.combosEnabled };

    case 'SET_COMBO_INTERVAL':
      return { ...state, comboInterval: action.payload };

    case 'SET_WARNING_THRESHOLD':
      return { ...state, warningThreshold: action.payload };

    case 'SET_THEME':
      return { ...state, theme: action.payload };

    case 'SET_VOLUME':
      return { ...state, volume: action.payload };

    default:
      return state;
  }
}
