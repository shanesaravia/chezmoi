import { describe, it, expect, vi, beforeEach } from 'vitest';
import { addBodyShots } from '../utils/comboUtils';

describe('addBodyShots', () => {

  beforeEach(() => {
    vi.restoreAllMocks();
  });

  it('should not modify non-numeric parts like Slip and Roll', () => {
    vi.spyOn(Math, 'random').mockReturnValue(0); // Always trigger "b"

    const result = addBodyShots('Slip-Roll');
    expect(result).toBe('Slip-Roll');
  });

  it('should append "b" to numbers when random is below 0.1', () => {
    vi.spyOn(Math, 'random').mockReturnValue(0.05); // Below 0.1 threshold

    const result = addBodyShots('1-2-3');
    expect(result).toBe('1b-2b-3b');
  });

  it('should not append "b" when random is 0.1 or above', () => {
    vi.spyOn(Math, 'random').mockReturnValue(0.1); // At threshold (not below)

    const result = addBodyShots('1-2-3');
    expect(result).toBe('1-2-3');
  });

  it('should only affect single digits 1-6', () => {
    vi.spyOn(Math, 'random').mockReturnValue(0.05);

    // Numbers 1-6 get "b", but 7+ or multi-digit don't
    const result = addBodyShots('1-2-3-4-5-6');
    expect(result).toBe('1b-2b-3b-4b-5b-6b');
  });

  it('should handle mixed combos with defense moves', () => {
    vi.spyOn(Math, 'random').mockReturnValue(0.05);

    const result = addBodyShots('1-2-Slip-3-Roll-2');
    expect(result).toBe('1b-2b-Slip-3b-Roll-2b');
  });

  it('should handle single punch combos', () => {
    vi.spyOn(Math, 'random').mockReturnValue(0.05);

    expect(addBodyShots('1')).toBe('1b');
    expect(addBodyShots('2')).toBe('2b');
  });
});
