import { TimerProvider } from './context/TimerContext';
import { Layout } from './components/Layout';
import { TimerDisplay } from './components/TimerDisplay';
import { Controls } from './components/Controls';
import { KeyboardHint } from './components/KeyboardHint';
import { CombinationPrompt } from './components/CombinationPrompt';
import { useTimer } from './hooks/useTimer';
import { useKeyboard } from './hooks/useKeyboard';
import { useSound } from './hooks/useSound';

function TimerApp() {
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

function App() {
  return (
    <TimerProvider>
      <TimerApp />
    </TimerProvider>
  );
}

export default App;
