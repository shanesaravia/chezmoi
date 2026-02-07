import { describe, it, expect } from 'vitest';
import { formatTime, formatDuration } from './formatTime';

describe('formatTime', () => {
  it('formats 0 seconds correctly', () => {
    expect(formatTime(0)).toBe('00:00');
  });

  it('formats seconds less than a minute', () => {
    expect(formatTime(30)).toBe('00:30');
    expect(formatTime(5)).toBe('00:05');
    expect(formatTime(59)).toBe('00:59');
  });

  it('formats full minutes', () => {
    expect(formatTime(60)).toBe('01:00');
    expect(formatTime(120)).toBe('02:00');
    expect(formatTime(180)).toBe('03:00');
  });

  it('formats minutes and seconds', () => {
    expect(formatTime(90)).toBe('01:30');
    expect(formatTime(125)).toBe('02:05');
    expect(formatTime(599)).toBe('09:59');
  });

  it('formats 10+ minutes', () => {
    expect(formatTime(600)).toBe('10:00');
    expect(formatTime(725)).toBe('12:05');
  });
});

describe('formatDuration', () => {
  it('formats full minutes', () => {
    expect(formatDuration(60)).toBe('1 min');
    expect(formatDuration(120)).toBe('2 min');
    expect(formatDuration(180)).toBe('3 min');
  });

  it('formats minutes and seconds', () => {
    expect(formatDuration(90)).toBe('1:30');
    expect(formatDuration(150)).toBe('2:30');
    expect(formatDuration(45)).toBe('0:45');
  });
});
