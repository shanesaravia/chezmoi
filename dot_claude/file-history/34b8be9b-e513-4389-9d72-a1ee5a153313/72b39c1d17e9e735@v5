export const DEFAULT_TOTAL_ROUNDS = 12;
export const DEFAULT_ROUND_DURATION = 180; // 3 minutes in seconds
export const DEFAULT_REST_DURATION = 60; // 1 minute in seconds

export const MIN_ROUNDS = 1;
export const MAX_ROUNDS = 20;
export const MIN_ROUND_DURATION = 60; // 1 minute
export const MAX_ROUND_DURATION = 300; // 5 minutes
export const MIN_REST_DURATION = 30; // 30 seconds
export const MAX_REST_DURATION = 120; // 2 minutes

export const DEFAULT_WARNING_THRESHOLD = 30; // seconds before phase ends
export const MIN_WARNING_THRESHOLD = 5;
export const MAX_WARNING_THRESHOLD = 60; // 1 minute

export const DEFAULT_COMBO_INTERVAL = 60; // seconds between combo prompts
export const MIN_COMBO_INTERVAL = 5;
export const MAX_COMBO_INTERVAL = 180; // 3 minutes

export const COMBINATIONS = {
  // Basic punches
  basic: ['1', '2', '1-1', '1-2'],
  // Standard combos
  standard: [
    '1-1-2',
    '1-2-3',
    '1-2-1-2',
    '1-2-3-2',
    '1-2-5-2',
    '1-6-3-2',
    '2-3-2',
    '1-2-3-4',
    '1-2-3-6',
    '1-4-3-2',
    '5-2-3-2',
    '3-2',
    '5-6',
    '1-2-5-6',
    '6-3-2',
  ],
  // Combos with defense
  withDefense: [
    '1-2-Slip-2',
    '1-2-3-Roll',
    'Slip-1-2',
    'Roll-2-3-2',
    '1-2-3-Roll-2',
    '1-2-5-2-Roll',
    'Slip-2-3-2',
    '1-2-3-2-Slip-2',
    '1-2-Roll-2',
    '1-2-3-Roll-3-2',
  ],
  // Long combos
  long: ['1-2-3-4-5-6', '1-2-3-2-1-2', '1-1-2-3-2'],
} as const;

export const ALL_COMBINATIONS = [
  ...COMBINATIONS.basic,
  ...COMBINATIONS.standard,
  ...COMBINATIONS.withDefense,
  ...COMBINATIONS.long,
];
