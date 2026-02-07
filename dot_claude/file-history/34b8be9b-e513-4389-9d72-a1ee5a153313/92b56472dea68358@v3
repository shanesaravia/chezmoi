import { useEffect } from 'react';
import { useTimerStore } from './stores/timerStore';
import { Layout } from './components/Layout';
import { TimerDisplay } from './components/TimerDisplay';
import { Controls } from './components/Controls';
import { KeyboardHint } from './components/KeyboardHint';
import { CombinationPrompt } from './components/CombinationPrompt';
import { useTimer } from './hooks/useTimer';
import { useKeyboard } from './hooks/useKeyboard';
import { useSound } from './hooks/useSound';

function App() {
  const theme = useTimerStore((state) => state.theme);

  // Apply theme to document
  useEffect(() => {
    if (theme === 'dark') {
      document.documentElement.classList.add('dark');
    } else {
      document.documentElement.classList.remove('dark');
    }
  }, [theme]);

  useTimer();
  useKeyboard();
  useSound();

  return (
    <Layout>
      <div className="flex flex-col items-center gap-8">
        <TimerDisplay />
        <Controls />
        <KeyboardHint />
      </div>
      <CombinationPrompt />
    </Layout>
  );
}

export default App;
