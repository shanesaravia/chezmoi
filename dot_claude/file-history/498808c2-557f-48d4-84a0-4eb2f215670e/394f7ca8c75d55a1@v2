export function addBodyShots(combo: string): string {
  return combo
    .split('-')
    .map((part) => {
      if (/^[1-6]$/.test(part) && Math.random() < 0.1) {
        return part + 'b';
      }
      return part;
    })
    .join('-');
}
