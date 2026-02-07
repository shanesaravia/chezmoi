import { Sun, Moon } from 'lucide-react';
import { useTimerContext } from '../context/TimerContext';

export function ThemeToggle() {
  const { settings, dispatchSettings } = useTimerContext();

  const toggleTheme = () => {
    dispatchSettings({
      type: 'SET_THEME',
      payload: settings.theme === 'dark' ? 'light' : 'dark',
    });
  };

  return (
    <button
      onClick={toggleTheme}
      className="p-2 rounded-lg text-gray-500 hover:text-gray-700 dark:text-gray-400 dark:hover:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition-colors"
      aria-label={`Switch to ${settings.theme === 'dark' ? 'light' : 'dark'} mode`}
    >
      {settings.theme === 'dark' ? (
        <Sun className="w-5 h-5" />
      ) : (
        <Moon className="w-5 h-5" />
      )}
    </button>
  );
}
