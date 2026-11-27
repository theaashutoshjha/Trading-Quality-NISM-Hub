export type ThemeMode = 'system' | 'light' | 'dark';

export const COLOR_PRESETS: { name: string; color: string; pair: string }[] = [
  { name: 'FundsIndia Blue', color: '#1d6ff2', pair: '#10b86c' },
  { name: 'Emerald', color: '#059669', pair: '#10b86c' },
  { name: 'Indigo', color: '#4f46e5', pair: '#06b6d4' },
  { name: 'Teal', color: '#0d9488', pair: '#1d6ff2' },
  { name: 'Rose', color: '#e11d48', pair: '#f97316' },
  { name: 'Amber', color: '#d97706', pair: '#10b86c' },
  { name: 'Purple', color: '#7c3aed', pair: '#ec4899' },
];

const MODE_KEY = 'fi_theme_mode';
const COLOR_KEY = 'fi_ui_color';

function hexToRgb(hex: string): [number, number, number] {
  const h = hex.replace('#', '');
  return [
    parseInt(h.slice(0, 2), 16) || 29,
    parseInt(h.slice(2, 4), 16) || 111,
    parseInt(h.slice(4, 6), 16) || 242,
  ];
}

function mixHex(baseHex: string, tintHex: string, ratio: number): string {
  const [r1, g1, b1] = hexToRgb(baseHex);
  const [r2, g2, b2] = hexToRgb(tintHex);
  const r = Math.round(r1 * (1 - ratio) + r2 * ratio);
  const g = Math.round(g1 * (1 - ratio) + g2 * ratio);
  const b = Math.round(b1 * (1 - ratio) + b2 * ratio);
  return `#${[r, g, b].map((x) => Math.max(0, Math.min(255, x)).toString(16).padStart(2, '0')).join('')}`;
}

export function getSavedTheme(): { mode: ThemeMode; color: string } {
  let mode: ThemeMode = 'system';
  let color = '#1d6ff2';
  try {
    const m = localStorage.getItem(MODE_KEY);
    if (m === 'light' || m === 'dark' || m === 'system') mode = m;
    const c = localStorage.getItem(COLOR_KEY);
    if (c && /^#[0-9a-fA-F]{6}$/.test(c)) color = c;
  } catch { /* ignore */ }
  return { mode, color };
}

export function applyTheme(mode: ThemeMode, color: string) {
  const root = document.documentElement;
  if (mode === 'system') root.removeAttribute('data-theme');
  else root.setAttribute('data-theme', mode);

  const isDark = mode === 'dark' || (mode === 'system' && typeof window !== 'undefined' && window.matchMedia?.('(prefers-color-scheme: dark)').matches);
  const preset = COLOR_PRESETS.find((p) => p.color.toLowerCase() === color.toLowerCase());
  const pair = preset ? preset.pair : '#10b86c';
  const [r, g, b] = hexToRgb(color);

  // Tint page background, card surface, sidebar, and shadows with the selected color
  const bg = isDark ? mixHex('#181d2b', color, 0.12) : mixHex('#eef2f7', color, 0.08);
  const card = isDark ? mixHex('#1d2334', color, 0.14) : mixHex('#f3f6fb', color, 0.06);
  const side = isDark ? mixHex('#151a27', color, 0.16) : mixHex('#e9eef7', color, 0.11);
  const shD = isDark ? mixHex('#0d111b', color, 0.15) : mixHex('#b5c1d6', color, 0.18);
  const shL = isDark ? mixHex('#273047', color, 0.12) : '#ffffff';

  root.style.setProperty('--pri', color);
  root.style.setProperty('--pri-d', color);
  root.style.setProperty('--pri-t', `rgba(${r},${g},${b},0.14)`);
  root.style.setProperty('--bg', bg);
  root.style.setProperty('--card', card);
  root.style.setProperty('--side', side);
  root.style.setProperty('--sh-d', shD);
  root.style.setProperty('--sh-l', shL);
  root.style.setProperty('--page-glow', `rgba(${r},${g},${b},${isDark ? 0.18 : 0.11})`);
  root.style.setProperty('--brand', `linear-gradient(135deg, ${pair} 0%, ${color} 100%)`);

  try {
    localStorage.setItem(MODE_KEY, mode);
    localStorage.setItem(COLOR_KEY, color);
  } catch { /* ignore */ }
}

export function initTheme() {
  const { mode, color } = getSavedTheme();
  applyTheme(mode, color);
}
