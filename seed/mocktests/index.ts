// Mock-test generator used by seed/build-seed.mjs.
// Each NISM series gets 20 tests x 100 questions, following that series' own pass mark and negative marking.
import { BANK_VA, VA_BY_CHAPTER, RawQ } from './bankVA';
import { BANK_VIII, BANK_XIII, BANK_XV, BANK_XVI, BANK_XXIA } from './bankOthers';
import { BANK_VB, BANK_VII, BANK_XII, BANK_XA, BANK_XB } from './bankMore';
import { GEN_VA, GEN_VII, GEN_XA, GEN_XII, GEN_XIII, GEN_XV, GEN_XVI, GEN_XXI, GenQ, Rng, mulberry32, shuffle } from './generators';

export const TESTS_PER_SERIES = 20;
export const QUESTIONS_PER_TEST = 100;

export interface SeriesRule {
  courseId: string; // courses.id in the catalogue
  code: string;
  pass: number; // pass %
  negative: number; // marks deducted per wrong answer
  minutes: number;
  note: string;
}

// Pass mark / negative marking: NISM certification pamphlet (Aug 2024) and NISM exam pages.
// XIII / XXI-B official papers have 150 questions (3 h); mocks here are 100 questions / 120 min as requested.
export const MOCK_RULES: SeriesRule[] = [
  { courseId: 'nism-5a', code: 'V-A', pass: 50, negative: 0, minutes: 120, note: '100 questions, 120 min, pass 50%, no negative marking' },
  { courseId: 'nism-8', code: 'VIII', pass: 60, negative: 0.25, minutes: 120, note: '100 questions, 120 min, pass 60%, 25% negative marking' },
  { courseId: 'nism-13', code: 'XIII', pass: 60, negative: 0.25, minutes: 120, note: 'Official paper is 150 questions / 180 min; this mock is 100 questions / 120 min. Pass 60%, 25% negative marking' },
  { courseId: 'nism-15', code: 'XV', pass: 60, negative: 0.25, minutes: 120, note: '100 marks, 120 min, pass 60%, 25% negative marking' },
  { courseId: 'nism-16', code: 'XVI', pass: 60, negative: 0.25, minutes: 120, note: '100 questions, 120 min, pass 60%, 25% negative marking' },
  { courseId: 'nism-5b', code: 'V-B', pass: 50, negative: 0, minutes: 120, note: 'Official paper is 50 questions / 120 min; this mock is 100 questions as requested. Pass 50%, no negative marking' },
  { courseId: 'nism-7', code: 'VII', pass: 50, negative: 0.25, minutes: 120, note: '100 questions, 120 min, pass 50%, 25% negative marking' },
  { courseId: 'nism-12', code: 'XII', pass: 60, negative: 0, minutes: 120, note: '100 questions, 120 min, pass 60%, no negative marking' },
  { courseId: 'nism-10a', code: 'X-A', pass: 60, negative: 0.25, minutes: 120, note: 'Official paper is 150 questions / 180 min; this mock is 100 questions / 120 min. Pass 60%, 25% negative marking' },
  { courseId: 'nism-10b', code: 'X-B', pass: 60, negative: 0.25, minutes: 120, note: 'Pass 60%, 25% negative marking (please confirm against the current NISM pamphlet); this mock is 100 questions / 120 min' },
  { courseId: 'nism-21a', code: 'XXI-A', pass: 60, negative: 0.25, minutes: 120, note: '100 marks, 120 min, pass 60%, 25% negative marking' },
];

const BANKS: Record<string, { facts: RawQ[]; gens: ((r: Rng) => GenQ)[]; numeric: number }> = {
  'nism-5a': { facts: BANK_VA, gens: GEN_VA, numeric: 18 },
  'nism-5b': { facts: BANK_VB, gens: GEN_VA, numeric: 30 },
  'nism-7': { facts: BANK_VII, gens: GEN_VII, numeric: 35 },
  'nism-12': { facts: BANK_XII, gens: GEN_XII, numeric: 30 },
  'nism-10a': { facts: BANK_XA, gens: GEN_XA, numeric: 35 },
  'nism-10b': { facts: BANK_XB, gens: GEN_XA, numeric: 35 },
  'nism-8': { facts: BANK_VIII, gens: GEN_XIII, numeric: 30 },
  'nism-13': { facts: BANK_XIII, gens: GEN_XIII, numeric: 30 },
  'nism-15': { facts: BANK_XV, gens: GEN_XV, numeric: 28 },
  'nism-16': { facts: BANK_XVI, gens: GEN_XVI, numeric: 30 },
  'nism-21a': { facts: BANK_XXIA, gens: GEN_XXI, numeric: 25 },
};

const hash = (s: string) => {
  let h = 2166136261;
  for (let i = 0; i < s.length; i++) h = Math.imul(h ^ s.charCodeAt(i), 16777619);
  return h >>> 0;
};

export interface MockQuestion {
  question: string;
  options: string[];
  correctIndex: number;
  explanation: string;
}

/** 20 deterministic tests of 100 unique-within-test questions. */
export function buildMockTests(courseId: string): MockQuestion[][] {
  const bank = BANKS[courseId];
  if (!bank) return [];
  const tests: MockQuestion[][] = [];
  const order = shuffle(mulberry32(hash(courseId)), bank.facts.map((_, i) => i));
  const factsPerTest = Math.min(bank.facts.length, QUESTIONS_PER_TEST - bank.numeric);

  for (let t = 0; t < TESTS_PER_SERIES; t++) {
    const rng = mulberry32(hash(`${courseId}#${t}`));
    const seen = new Set<string>();
    const qs: MockQuestion[] = [];
    for (let k = 0; k < factsPerTest; k++) {
      const raw = bank.facts[order[(t * factsPerTest + k) % order.length]];
      if (seen.has(raw[0])) continue;
      seen.add(raw[0]);
      const opts = shuffle(rng, [raw[1], raw[2], raw[3], raw[4]]);
      qs.push({ question: raw[0], options: opts, correctIndex: opts.indexOf(raw[1]), explanation: raw[5] });
    }
    let guard = 0;
    while (qs.length < QUESTIONS_PER_TEST && guard++ < 8000) {
      const g = bank.gens[Math.floor(rng() * bank.gens.length)](rng);
      if (seen.has(g.question)) continue;
      seen.add(g.question);
      qs.push({ question: g.question, options: g.options, correctIndex: g.correct, explanation: g.explanation });
    }
    tests.push(shuffle(rng, qs));
  }
  return tests;
}

// Generated numerical practice per V-A chapter (indexes into GEN_VA).
const VA_CHAPTER_GENS: Record<number, number[]> = { 1: [8, 13], 6: [3], 7: [0, 2, 10], 8: [4, 5, 12], 9: [1, 7, 9, 14], 10: [6, 11], 11: [6, 11] };

/** Chapter practice sets for NISM V-A: written questions plus calculated numericals where the chapter has them. */
export function vaChapterPractice(ch: number): MockQuestion[] {
  const rng = mulberry32(hash('va-chapter-' + ch));
  const qs: MockQuestion[] = [];
  const seen = new Set<string>();
  for (const raw of shuffle(rng, VA_BY_CHAPTER[ch] || [])) {
    const opts = shuffle(rng, [raw[1], raw[2], raw[3], raw[4]]);
    seen.add(raw[0]);
    qs.push({ question: raw[0], options: opts, correctIndex: opts.indexOf(raw[1]), explanation: raw[5] });
  }
  const gens = (VA_CHAPTER_GENS[ch] || []).map((i) => GEN_VA[i]);
  let guard = 0;
  while (gens.length && qs.length < Math.max(12, Math.min(25, qs.length + 8)) && guard++ < 500) {
    const g = gens[Math.floor(rng() * gens.length)](rng);
    if (seen.has(g.question)) continue;
    seen.add(g.question);
    qs.push({ question: g.question, options: g.options, correctIndex: g.correct, explanation: g.explanation });
  }
  return shuffle(rng, qs);
}

