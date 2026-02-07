# Boxing Rounds Timer

A modern, feature-rich boxing training timer built with React and TypeScript. Perfect for boxing, MMA, kickboxing, or any interval-based training.

![Boxing Rounds Timer Screenshot](./screenshot.png)

## Features

### Timer Controls
- **Start/Pause/Reset** - Full control over your training session
- **Space Bar Support** - Quick start/pause without touching your device
- **Keyboard Shortcuts** - `Space` to toggle, `R` or `Escape` to reset

### Configurable Rounds
- **Round Count** - Set 1 to 20 rounds
- **Round Duration** - 1 to 5 minutes per round
- **Rest Duration** - 30 seconds to 2 minutes between rounds

### Audio Notifications
- **Bell Sounds** - Clear audio cues at round/rest transitions
- **Warning Alert** - Configurable warning beep (5-60 seconds before phase ends)
- **Volume Control** - Adjust audio levels to your environment

### Combination Prompts
Random boxing combination callouts during rounds to keep your training dynamic:

| Number | Punch |
|--------|-------|
| 1 | Jab |
| 2 | Cross |
| 3 | Lead Hook |
| 4 | Rear Hook |
| 5 | Lead Uppercut |
| 6 | Rear Uppercut |

**Combo Categories:**
- **Basic** - Single punches and simple combos (1, 2, 1-1, 1-2)
- **Standard** - Common combinations (1-2-3, 2-3-2, 1-2-3-2, etc.)
- **With Defense** - Combos including slips and rolls (1-2-Slip-2, Roll-2-3-2, etc.)
- **Long** - Extended combinations (1-2-3-4-5-6, 1-2-3-2-1-2)

### Visual Feedback
- **Color-Coded Phases**
  - 🟢 Green - Active round
  - 🔵 Blue - Rest period
  - 🟡 Amber - Paused
  - 🔴 Red pulse - Warning countdown
- **Large Timer Display** - Easily visible from across the room
- **Round Counter** - Always know where you are in your workout

### Theme Support
- **Dark Mode** - Easy on the eyes (default)
- **Light Mode** - For bright environments
- Toggle with a single click

### Settings Persistence
All your preferences are automatically saved to your browser's local storage:
- Timer configuration (rounds, durations)
- Combo settings (enabled, interval, selected groups)
- Theme preference
- Volume level

## Tech Stack

- **React 18** - UI framework
- **TypeScript** - Type safety
- **Vite** - Build tool with fast HMR
- **Zustand** - Lightweight state management
- **Tailwind CSS v4** - Utility-first styling
- **Lucide React** - Beautiful icons
- **Vitest** - Unit testing

## Getting Started

### Prerequisites

- Node.js 18+
- npm or yarn

### Installation

```bash
# Clone the repository
git clone https://github.com/shanesaravia/boxing-rounds.git
cd boxing-rounds

# Install dependencies
npm install

# Start development server
npm run dev
```

Open [http://localhost:5173](http://localhost:5173) in your browser.

### Build for Production

```bash
npm run build
npm run preview  # Preview production build locally
```

## Usage

1. **Configure Your Workout** - Click the gear icon to open settings
   - Set number of rounds
   - Adjust round and rest durations
   - Enable/disable combo prompts
   - Choose which combo types to include

2. **Start Training** - Press the Start button or hit `Space`

3. **Follow the Timer** - The display shows:
   - Current phase (Round/Rest/Paused)
   - Time remaining
   - Current round number

4. **React to Combos** - When enabled, combination prompts appear during rounds

5. **Pause/Resume** - Press `Space` or click Pause anytime

6. **Reset** - Press `R` or click Reset to start over

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| `Space` | Start / Pause / Resume |
| `R` | Reset timer |
| `Escape` | Reset timer |

## Configuration Options

### Timer Settings
| Setting | Range | Default |
|---------|-------|---------|
| Number of Rounds | 1-20 | 12 |
| Round Duration | 1-5 min | 3 min |
| Rest Duration | 30s-2 min | 1 min |
| Warning Sound | 5-60s | 30s |

### Combo Settings
| Setting | Range | Default |
|---------|-------|---------|
| Combo Prompts | On/Off | Off |
| Combo Interval | 5s-3 min | 1 min |
| Basic Combos | On/Off | On |
| Standard Combos | On/Off | On |
| Defense Combos | On/Off | On |
| Long Combos | On/Off | On |

## Development

```bash
# Run development server
npm run dev

# Run tests
npm run test

# Run tests once
npm run test:run

# Build for production
npm run build

# Preview production build
npm run preview
```

## Project Structure

```
src/
├── components/       # React components
│   ├── Button.tsx
│   ├── CombinationPrompt.tsx
│   ├── Controls.tsx
│   ├── KeyboardHint.tsx
│   ├── Layout.tsx
│   ├── PhaseIndicator.tsx
│   ├── RoundIndicator.tsx
│   ├── SettingsPanel.tsx
│   ├── ThemeToggle.tsx
│   ├── TimeDisplay.tsx
│   └── TimerDisplay.tsx
├── hooks/            # Custom React hooks
│   ├── useCombinations.ts
│   ├── useKeyboard.ts
│   ├── useSound.ts
│   └── useTimer.ts
├── stores/           # Zustand state management
│   └── timerStore.ts
├── types/            # TypeScript types
│   └── timer.ts
├── utils/            # Utility functions
│   ├── constants.ts
│   └── formatTime.ts
├── App.tsx
├── index.css
└── main.tsx
```

## License

ISC

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
