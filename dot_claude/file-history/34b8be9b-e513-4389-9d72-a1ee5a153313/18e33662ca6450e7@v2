import type { ReactNode } from 'react';
import { ThemeToggle } from './ThemeToggle';
import { SettingsPanel } from './SettingsPanel';

interface LayoutProps {
  children: ReactNode;
}

export function Layout({ children }: LayoutProps) {
  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900 transition-colors">
      <header className="fixed top-0 left-0 right-0 flex items-center justify-between p-4 z-40">
        <h1 className="text-lg font-bold text-gray-800 dark:text-white">
          Boxing Timer
        </h1>
        <div className="flex items-center gap-2">
          <ThemeToggle />
          <SettingsPanel />
        </div>
      </header>
      <main className="flex flex-col items-center justify-center min-h-screen px-4">
        {children}
      </main>
    </div>
  );
}
