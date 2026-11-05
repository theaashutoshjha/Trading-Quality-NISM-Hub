// Generates seed/out/*.sql from the original hub curriculum + catalog + extra notes.
//   node seed/build-seed.mjs
import { build } from 'esbuild';
import { mkdirSync, rmSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';
import { existsSync, readFileSync } from 'node:fs';
import { COURSES, FI_CURATED, MAX_AGE_DAYS } from './catalog.mjs';
import { PATHS } from './paths.mjs';
import { EXTRA } from './extra.mjs';

const here = dirname(fileURLToPath(import.meta.url));
const tmp = join(here, '.tmp');
mkdirSync(tmp, { recursive: true });
await build({ entryPoints: [join(here, 'entry.ts')], bundle: true, format: 'esm', platform: 'node', outfile: join(tmp, 'data.mjs'), logLevel: 'error' });
const D = await import(pathToFileURL(join(tmp, 'data.mjs')).href);

// ---------- video sources ----------
const FI = JSON.parse(readFileSync(join(here, 'data', 'fi-channel.json'), 'utf8'));
const PL = JSON.parse(readFileSync(join(here, 'data', 'playlists.json'), 'utf8'));
const fiById = new Map(FI.map((v) => [v.id, v]));

// Only videos that can actually be embedded (not deleted/private/embedding disabled) are seeded.
const okFile = join(here, 'data', 'embed-ok.json');
const embedCache = existsSync(okFile) ? JSON.parse(readFileSync(okFile, 'utf8')) : {};
async function embeddable(ids) {
  const todo = ids.filter((i) => !(i in embedCache));
  let n = 0;
  await Promise.all(Array.from({ length: 8 }, async () => {
    while (todo.length) {
      const id = todo.pop();
      try {
        const r = await fetch(`https://www.youtube.com/oembed?url=${encodeURIComponent('https://www.youtube.com/watch?v=' + id)}&format=json`);
        embedCache[id] = r.status === 200;
      } catch { /* network hiccup: leave unknown, treated as ok below */ }
      if (++n % 50 === 0) console.log(`  checked ${n} videos…`);
    }
  }));
  writeFileSync(okFile, JSON.stringify(embedCache));
}
const cleanTitle = (t) =>
  t.replace(/#\w+/g, '').replace(/\s*\|\s*(FundsIndia|FundsIndia 360°|FIStocademy|FundsIndiaMarketry)\s*$/i, '').replace(/\s*\[link in Description\]/i, '').replace(/\s{2,}/g, ' ').replace(/[\s|–-]+$/, '').trim();

const allIds = new Set([...FI_CURATED.flatMap(([, ids]) => ids)]);
for (const c of COURSES) {
  for (const s of c.series) for (const v of PL[s.id] || []) allIds.add(v.id);
  for (const v of c.videos || []) allIds.add(v[0]);
}
console.log(`Checking ${allIds.size} candidate videos for embedding…`);
await embeddable([...allIds]);
const playable = (id) => embedCache[id] !== false;

/** Resolve a catalog series into fresh, playable video records. */
function seriesVideos(s) {
  let v = (PL[s.id] || []).filter((x) => playable(x.id));
  if (!s.noAgeFilter) v = v.filter((x) => x.age !== null && x.age <= MAX_AGE_DAYS);
  if (s.limit) v = v.slice(0, s.limit);
  return v.map((x) => ({ id: x.id, title: x.title, mins: Math.max(1, Math.round(x.dur / 60)), channel: s.channel }));
}

// ---------- helpers ----------
const q = (v) => (v === null || v === undefined ? 'NULL' : typeof v === 'number' ? String(v) : `'${String(v).replace(/'/g, "''")}'`);
// UPSERT, never REPLACE: REPLACE deletes the old row first, which would cascade-delete learners'
// progress, resume points and attempts that point at it. An upsert updates content in place.
const PK = { path_items: ['path_id', 'lesson_id'] };
const made = { lessons: new Set(), modules: new Set(), quizzes: new Set() };
const qCount = {};
const insert = (table, row) => {
  if (made[table]) made[table].add(row.id);
  if (table === 'questions') qCount[row.quiz_id] = (qCount[row.quiz_id] || 0) + 1;
  const cols = Object.keys(row);
  const pk = PK[table] || ['id'];
  const set = cols.filter((c) => !pk.includes(c)).map((c) => `${c}=excluded.${c}`).join(',');
  return `INSERT INTO ${table} (${cols.join(',')}) VALUES (${Object.values(row).map(q).join(',')}) ON CONFLICT(${pk.join(',')}) DO ${set ? `UPDATE SET ${set}` : 'NOTHING'};`;
};
const sid = (s) => String(s).toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
const list = (a, f = (x) => `- ${x}`) => (a && a.length ? a.map(f).join('\n') : '');
const sec = (title, body) => (body && String(body).trim() ? `\n## ${title}\n${body}\n` : '');

const stmts = [];
const sizeOf = () => stmts.reduce((n, s) => n + s.length, 0);

// ---------- Markdown generators ----------
function topicMd(t) {
  const e = t.explanation || {};
  let md = `# ${t.title}\n\n*${t.courseCode} - ${t.topicCode} - about ${t.durationMinutes} min read*\n`;
  md += sec('Learning objectives', list(t.learningObjectives));
  md += sec('What is it?', e.what) + sec('Why it matters', e.why) + sec('How it works', e.how);
  md += sec('Key definitions', list(e.definitions, (d) => `- **${d.term}** - ${d.definition}`));
  md += sec('Rules & regulations', list(e.rulesAndRegulations));
  md += sec('Formulas', list(e.formulas, (f) => `- **${f.name}:** \`${f.formula}\`${f.explanation ? ` - ${f.explanation}` : ''}${f.workedExample ? `\n  - *Example:* ${f.workedExample}` : ''}`));
  md += sec('Practical scenario', e.practicalScenario);
  md += sec('Key distinctions', list(e.keyDistinctions));
  md += sec('Common mistakes', list(e.commonMistakes));
  if (t.slides?.length) md += sec('Quick revision slides', t.slides.map((s) => `**${s.slideNumber}. ${s.title}**\n${list(s.bulletPoints)}`).join('\n\n'));
  return md.trim();
}

function workbookMd(w) {
  const p = w.examPattern || {};
  let md = `# ${w.courseCode} - Exam cheat-sheet\n\n**${w.courseTitle}** - ${w.syllabusEdition}\n`;
  md += sec('Exam pattern', `| Item | Detail |\n|---|---|\n| Duration | ${p.durationMinutes} minutes |\n| Questions | ${p.totalQuestions} |\n| Maximum marks | ${p.maximumMarks} |\n| Passing | ${p.passingPercentage}% |\n| Negative marking | ${p.negativeMarking} |\n| Certificate validity | ${p.certificateValidity} |\n\n*Always confirm the current pattern on the official NISM site before you book your exam.*`);
  if (w.chapters?.length) md += sec('Chapter weightage', `| Ch | Title | Weight |\n|---|---|---|\n${w.chapters.map((c) => `| ${c.chapterNumber} | ${c.title} | ${c.weightagePercent}% |`).join('\n')}`);
  if (w.masterFormulaSheet?.length) md += sec('Master formula sheet', w.masterFormulaSheet.map((f) => `- **${f.name}:** \`${f.formula}\` - ${f.context}`).join('\n'));
  if (w.mustKnowComplianceLimits?.length) md += sec('Must-know limits', `| Parameter | Limit | Source |\n|---|---|---|\n${w.mustKnowComplianceLimits.map((l) => `| ${l.parameter} | ${l.limit} | ${l.regulation} |`).join('\n')}`);
  return md.trim();
}
function workbookChapterMd(c) {
  let md = `# Chapter ${c.chapterNumber} summary - ${c.title}\n\n*Exam weightage: ${c.weightagePercent}%*\n`;
  md += sec('Summary notes', list(c.summaryNotes));
  md += sec('Key definitions', list(c.keyDefinitions, (d) => `- **${d.term}** - ${d.explanation}`));
  md += sec('Regulatory rules', list(c.regulatoryRules));
  md += sec('Formulas', list(c.formulas, (f) => `- **${f.name}:** \`${f.formula}\` - e.g. ${f.example}`));
  md += sec('Exam traps', list(c.examTraps));
  return md.trim();
}

const productMd = (l) =>
  `# ${l.title}\n\n*About ${l.durationMinutes} min*\n${sec('Overview', l.overview)}${sec('Key features', list(l.features))}${sec('Who it suits', l.investorSuitability)}${sec('Our advantage', l.fundsIndiaAdvantage)}${sec('How to pitch it', l.advisorPitchGuide)}${sec('Client FAQs', list(l.faqList, (f) => `**Q: ${f.q}**\n\n${f.a}\n`))}`.trim();

const objectionMd = (o) =>
  `# ${o.objectionTitle}\n\n> **Client says:** "${o.clientDialogue}"\n${sec('What is really worrying them', o.rootAnxiety)}${sec('Do NOT say', list(o.wrongResponses, (w) => `- ~~${w}~~`))}${sec('Approved 4-step framework',
    `1. **Empathise** - ${o.approvedFramework.step1Empathize}\n2. **Clarify** - ${o.approvedFramework.step2Clarify}\n3. **Evidence** - ${o.approvedFramework.step3MathematicalProof}\n4. **Next step** - ${o.approvedFramework.step4CallToAction}`)}${sec('Model response', `> ${o.modelResponseScript}`)}
\n> Figures in sample scripts are illustrative. Always quote current, approved data and avoid guarantees.`.trim();

const callMd = (c) =>
  `# ${c.title}\n\n**Call type:** ${c.callType} - **Length:** ${c.durationString}\n\n**Client persona:** ${c.clientPersona}\n${sec('Transcript', c.transcript.map((t) => `**${t.speaker}:** ${t.text}${t.isKeyMoment ? `\n\n> **Key moment:** ${t.note || ''}\n` : ''}`).join('\n\n'))}${sec('Scoring rubric', `| Criteria | What good looks like | Marks |\n|---|---|---|\n${c.rubricScores.map((r) => `| ${r.criteria} | ${r.benchmarkExpectation} | ${r.maxMarks} |`).join('\n')}`)}`.trim();

const supportMd = (w) =>
  `# ${w.workflowTitle}\n\n**Category:** ${w.category} - **SLA:** ${w.slaHours} hours\n${sec('When this applies', w.triggerCondition)}${sec('Common root causes', list(w.rootCauses))}${sec('Resolution steps', list(w.stepByStepResolution, (s) => `1. ${s.replace(/^Step \d+:\s*/, '')}`))}${sec('Client message template', `> ${w.clientCommunicationTemplate}`)}${sec('Escalation matrix', `| Level | Contact | Timeframe |\n|---|---|---|\n${w.escalationMatrix.map((e) => `| ${e.level} | ${e.contact} | ${e.timeframe} |`).join('\n')}`)}`.trim();

// ---------- NISM V-A workbook summary deck (September 2026 edition) -> Markdown notes ----------
const DECK = JSON.parse(readFileSync(join(here, 'data', 'nismVADeck.json'), 'utf8'));
const groups = (a, n) => { const o = []; for (let i = 0; i < a.length; i += n) o.push(a.slice(i, i + n)); return o; };
const videoTitle = (t) => `Video lesson: ${cleanTitle(t).replace(/^NISM( Series)?\s*(V-?A|Mutual Fund)?\s*/i, '').replace(/^Chapter (\d+)\s*[-|:]?\s*/i, 'Chapter $1: ').replace(/\|.*$/, '').trim()}`;
const cell = (s) => String(s ?? '').replace(/\|/g, '/').replace(/\s+/g, ' ').trim();
function deckMd(slides) {
  return slides.map((s) => {
    let md = `## ${s.title}\n\n`;
    for (const b of s.blocks) {
      if (b.rows) {
        const w = Math.max(...b.rows.map((r) => r.length));
        const rows = b.rows.map((r) => Array.from({ length: w }, (_, i) => cell(r[i])));
        md += `| ${rows[0].join(' | ')} |\n|${' --- |'.repeat(w)}\n${rows.slice(1).map((r) => `| ${r.join(' | ')} |`).join('\n')}\n\n`;
      } else {
        md += b.p.map(([t, lvl, bold]) => {
          const pad = '  '.repeat(Math.min(lvl, 3));
          const i = t.indexOf(': ');
          return `${pad}- ${bold ? (i > 0 && i < 70 ? `**${t.slice(0, i)}:** ${t.slice(i + 2)}` : `**${t}**`) : t}`;
        }).join('\n') + '\n\n';
      }
    }
    return md.trim();
  }).join('\n\n');
}

// ---------- assemble ----------
const srcMap = {
  va: { ch: D.NISM_VA_CHAPTERS, pool: D.NISM_VA_QUESTIONS, wb: 'nism-v-a' },
  vb: { ch: D.NISM_VB_CHAPTERS, pool: D.NISM_VB_QUESTIONS, wb: 'nism-v-b' },
  viii: { ch: D.NISM_VIII_CHAPTERS, pool: D.NISM_VIII_QUESTIONS, wb: 'nism-viii' },
  xa: { ch: D.NISM_XA_CHAPTERS, pool: D.NISM_XA_QUESTIONS, wb: 'nism-x-a' },
  xb: { ch: D.NISM_XB_CHAPTERS, pool: D.NISM_XB_QUESTIONS, wb: 'nism-x-b' },
  xv: { ch: D.NISM_XV_CHAPTERS, pool: D.NISM_XV_QUESTIONS, wb: 'nism-xv' },
  xxi: { ch: D.NISM_XXI_CHAPTERS, pool: D.NISM_XXI_QUESTIONS, wb: 'nism-xxi' },
};

const counts = {};
const lessonIds = new Set();
const courseLessons = {};
const allLessons = []; // {id,cid,kind,title,module,vid?} in creation order (used to build learning paths)
const modTitle = {};
let courseSort = 0;
const seenQ = new Set();

function addQuestions(quizId, arr) {
  let i = 0;
  for (const x of arr) {
    const opts = x.options || [];
    const ans = x.correctIndex ?? x.correctAnswer;
    if (!x.question || opts.length < 2 || !Number.isInteger(ans) || ans < 0 || ans >= opts.length) continue;
    const key = quizId + '|' + x.question;
    if (seenQ.has(key)) continue;
    seenQ.add(key);
    const expl = [x.explanation, x.examTip ? `Exam tip: ${x.examTip}` : ''].filter(Boolean).join('\n\n');
    stmts.push(insert('questions', { id: `${quizId}-q${i}`, quiz_id: quizId, question: x.question, options: JSON.stringify(opts), answer: ans, explanation: expl, sort: i }));
    i++;
  }
  return i;
}

for (const c of COURSES) {
  const cid = c.id;
  stmts.push(insert('courses', { id: cid, code: c.code, title: c.title, subtitle: c.subtitle, category: c.category, description: c.description, level: c.level || '', hours: 0, playlists: '[]', links: JSON.stringify(c.links || []), published: 1, popular: c.popular || 0, sort: courseSort++ }));
  const stat = (counts[cid] = { modules: 0, lessons: 0, videos: 0, quizzes: 0, questions: 0, minutes: 0 });
  const chapterSeries = c.series.find((s) => s.byChapter);
  const chapterVideos = chapterSeries ? seriesVideos(chapterSeries) : [];
  const chapterOf = (t) => +(t.match(/chapter\s*(\d+)/i)?.[1] || 0);
  let lessonSort = 0, quizSort = 0, modSort = 0;

  const addModule = (title, weight = null) => {
    const id = `${cid}-m${modSort}`;
    modTitle[id] = title;
    stmts.push(insert('modules', { id, course_id: cid, title, weight, sort: modSort++ }));
    stat.modules++;
    return id;
  };
  const addLesson = (mid, title, body, minutes = 5, extra = {}) => {
    const id = `${cid}-l${lessonSort}`;
    stmts.push(insert('lessons', { id, course_id: cid, module_id: mid, title, kind: 'note', body, minutes, published: 1, sort: lessonSort++, ...extra }));
    stat.lessons++;
    stat.minutes += minutes;
    allLessons.push({ id, cid, kind: 'note', title, module: modTitle[mid] || '' });
    return id;
  };
  const addVideo = (mid, v) => {
    const id = `${cid}-v-${v.id}`;
    if (lessonIds.has(id)) return id;
    lessonIds.add(id);
    stmts.push(insert('lessons', { id, course_id: cid, module_id: mid, title: cleanTitle(v.title), kind: 'video', video_id: v.id, body: '', minutes: v.mins, author: v.channel, published: 1, sort: lessonSort++ }));
    stat.lessons++; stat.videos++;
    stat.minutes += v.mins;
    allLessons.push({ id, cid, kind: 'video', title: cleanTitle(v.title), module: modTitle[mid] || '', vid: v.id });
    return id;
  };
  const addQuiz = (mid, title, questions, opts = {}) => {
    const id = `${cid}-z${quizSort}`;
    stmts.push(insert('quizzes', { id, course_id: cid, module_id: mid, title, minutes: opts.minutes ?? 15, pass_pct: opts.pass ?? 60, negative: opts.negative ?? 0, is_exam: opts.exam ? 1 : 0, mock: 0, published: 1, sort: quizSort++ }));
    const n = addQuestions(id, questions);
    stat.quizzes++;
    stat.questions += n;
    return n;
  };

  const rule = D.MOCK_RULES.find((r) => r.courseId === cid);
  const S = c.src && srcMap[c.src];
  if (c.src === 'va') {
    // NISM V-A is built from the real 12-chapter workbook structure (Sept 2026 edition) + the N V Finance course playlist.
    // The older generated V-A notes/questions followed a different chapter list and some figures are outdated, so they are not used.
    const deckBy = (ch) => DECK.filter((s) => s.ch === ch && !/^Chapter \d+:/.test(s.title));
    const first = addModule('Start here: exam overview');
    addLesson(first, 'Exam pattern & syllabus weightage (September 2026 workbook)', deckMd(DECK.filter((s) => s.ch === 0 && s.n >= 1 && s.n <= 2)), 6);
    for (const v of chapterVideos.filter((x) => chapterOf(x.title) === 0 && /update/i.test(x.title))) addVideo(first, { ...v, title: videoTitle(v.title) });
    for (let n = 1; n <= 12; n++) {
      const div = DECK.find((s) => s.ch === n && /^Chapter \d+:/.test(s.title));
      const marks = +(JSON.stringify(div?.blocks || []).match(/Exam weightage: (\d+) marks/)?.[1] || 0) || null;
      const mid = addModule(`Ch ${n}: ${(div?.title || '').replace(/^Chapter \d+:\s*/, '')}`, marks);
      for (const v of chapterVideos.filter((x) => chapterOf(x.title) === n)) addVideo(mid, { ...v, title: videoTitle(v.title) });
      const parts = groups(deckBy(n), 4);
      parts.forEach((g, k) => addLesson(mid, `Summary notes ${k + 1}/${parts.length}: ${g[0].title}${g.length > 1 ? ' to ' + g[g.length - 1].title : ''}`, deckMd(g), g.length * 3));
      const pq = D.vaChapterPractice(n);
      if (pq.length >= 5) addQuiz(mid, `Chapter ${n} practice`, pq, { minutes: Math.max(10, Math.round(pq.length * 1.2)), pass: 50, negative: 0 });
    }
    const extraVids = chapterVideos.filter((x) => chapterOf(x.title) === 0 && !/update/i.test(x.title));
    const plan = extraVids.filter((x) => !/mock/i.test(x.title)), walk = extraVids.filter((x) => /mock/i.test(x.title));
    if (plan.length) { const m = addModule('Financial planning & model portfolio'); plan.forEach((v) => addVideo(m, { ...v, title: videoTitle(v.title) })); }
    if (walk.length) { const m = addModule('Mock test walkthroughs'); walk.forEach((v, i) => addVideo(m, { ...v, title: `Mock test walkthrough ${i + 1}` })); }
    const apx = deckBy(13);
    if (apx.length) { const m = addModule('Appendices: AMFI codes & resources'); groups(apx, 3).forEach((g, k, a) => addLesson(m, `Appendix notes ${k + 1}/${a.length}: ${g[0].title}`, deckMd(g), g.length * 3)); }
    const exam = addModule('Final assessment');
    const seenTxt = new Set(), bank = [];
    for (const t of D.buildMockTests(cid)) for (const x of t) if (!seenTxt.has(x.question)) { seenTxt.add(x.question); bank.push(x); }
    addQuiz(exam, 'NISM V-A - Final assessment (certificate)', bank, { minutes: 60, pass: rule.pass, negative: rule.negative, exam: true });
  } else if (S) {
    const wb = D.NISM_WORKBOOKS[S.wb];
    const first = addModule('Start here: exam overview & cheat-sheet');
    if (wb) addLesson(first, 'Exam pattern, formulas & must-know limits', workbookMd(wb), 10);
    for (const ch of S.ch) {
      const mid = addModule(`Ch ${ch.chapterNumber}: ${ch.title}`, ch.weightagePercent);
      for (const v of chapterVideos.filter((x) => chapterOf(x.title) === ch.chapterNumber)) addVideo(mid, { ...v, title: `Video lesson: ${cleanTitle(v.title).replace(/^NISM V-?A\s*/i, '')}` });
      for (const t of ch.topics) addLesson(mid, t.title, topicMd(t), t.durationMinutes || 10);
      const wch = wb?.chapters?.find((x) => x.chapterNumber === ch.chapterNumber);
      if (wch) addLesson(mid, `Chapter ${ch.chapterNumber} summary & exam traps`, workbookChapterMd(wch), 8);
      const pq = ch.topics.flatMap((t) => t.practiceQuestions || []);
      if (pq.length >= 2) addQuiz(mid, `Chapter ${ch.chapterNumber} practice`, pq, { minutes: Math.max(10, pq.length * 1.5 | 0), pass: 60, negative: 0 });
    }
    const mock = addModule('Mock exams');
    // Final assessment (issues the internal certificate): drawn from the series' full question bank, 50 random questions per attempt.
    let pool = S.pool || [];
    if (rule) {
      const seenTxt = new Set(); pool = [];
      for (const t of D.buildMockTests(cid)) for (const x of t) if (!seenTxt.has(x.question)) { seenTxt.add(x.question); pool.push(x); }
    }
    const neg = rule ? rule.negative : /zero|none|no negative/i.test(wb?.examPattern?.negativeMarking || '') ? 0 : 0.25;
    if (pool.length) addQuiz(mock, rule ? `${c.code} - Final assessment (certificate)` : `${c.code} - Full mock test`, pool, { minutes: rule ? 60 : 120, pass: rule?.pass || wb?.examPattern?.passingPercentage || 60, negative: neg, exam: true });
  } else if (c.src === 'product') {
    for (const m of D.PRODUCT_SCHOOL_MODULES) {
      const mid = addModule(m.name);
      for (const l of m.lessons) addLesson(mid, l.title, productMd(l), l.durationMinutes || 10);
    }
  } else if (c.src === 'objection') {
    const cats = [...new Set(D.OBJECTION_SCENARIOS.map((o) => o.category))];
    for (const cat of cats) {
      const mid = addModule(cat);
      for (const o of D.OBJECTION_SCENARIOS.filter((x) => x.category === cat)) addLesson(mid, o.objectionTitle, objectionMd(o), 6);
    }
  } else if (c.src === 'call') {
    const mid = addModule('Call observation exercises');
    for (const e of D.CALL_EXCELLENCE_EXERCISES) addLesson(mid, e.title, callMd(e), 10);
  } else if (c.src === 'support') {
    const cats = [...new Set(D.CUSTOMER_SUPPORT_WORKFLOWS.map((o) => o.category))];
    for (const cat of cats) {
      const mid = addModule(cat);
      for (const w of D.CUSTOMER_SUPPORT_WORKFLOWS.filter((x) => x.category === cat)) addLesson(mid, w.workflowTitle, supportMd(w), 8);
    }
  } else if (c.src && EXTRA[c.src]) {
    for (const m of EXTRA[c.src].modules) {
      const mid = addModule(m.title);
      for (const l of m.lessons) addLesson(mid, l.title, l.body, l.minutes);
    }
  }

  // ---- 20 full-length mock tests (100 questions each) ----
  if (rule) {
    const tests = D.buildMockTests(cid);
    const mm = addModule(`Mock tests (${tests.length} x ${D.QUESTIONS_PER_TEST} questions)`);
    tests.forEach((qs, i) => {
      const id = `${cid}-z${quizSort}`;
      stmts.push(insert('quizzes', { id, course_id: cid, module_id: mm, title: `NISM ${rule.code} - Mock Test ${i + 1}`, minutes: rule.minutes, pass_pct: rule.pass, negative: rule.negative, is_exam: 0, mock: 1, published: 1, sort: quizSort++ }));
      const n = addQuestions(id, qs);
      stat.quizzes++; stat.questions += n;
    });
  }

  // ---- video lessons ----
  for (const s of c.series) {
    if (s.byChapter) continue;
    const vids = seriesVideos(s);
    if (!vids.length) continue;
    const mid = addModule(s.module || s.title);
    vids.forEach((v) => addVideo(mid, v));
  }
  if (c.videos?.length) {
    const mid = addModule('Chapter practice walkthroughs');
    c.videos.filter((v) => playable(v[0])).forEach(([id, title, channel, mins]) => addVideo(mid, { id, title, channel, mins }));
  }
  if (c.id === 'fi-academy') {
    for (const [cat, ids] of FI_CURATED) {
      const vids = ids.map((id) => fiById.get(id)).filter((v) => v && playable(v.id));
      if (!vids.length) continue;
      const mid = addModule(cat);
      vids.forEach((v) => addVideo(mid, { id: v.id, title: v.title, mins: Math.max(1, Math.round(v.dur / 60)), channel: 'FundsIndia' }));
    }
  }
  courseLessons[cid] = { videoIds: new Set([...lessonIds].filter((x) => x.startsWith(cid + '-v-'))) };

  // Update hours estimate:
  if (stat.minutes) stmts.push(`UPDATE courses SET hours = ${Math.round((stat.minutes / 60) * 10) / 10} WHERE id = ${q(cid)};`);
}

// ---------- learning paths ----------
const pathCounts = [];
PATHS.forEach((p, i) => {
  const ids = [...new Set(p.steps(allLessons))];
  if (ids.length < 2) { console.warn(`path "${p.title}" has too few steps (${ids.length}); skipped`); return; }
  stmts.push(insert('paths', { id: p.id, title: p.title, description: p.description, level: p.level, icon: p.icon, published: 1, sort: i }));
  ids.forEach((lid, k) => stmts.push(insert('path_items', { path_id: p.id, lesson_id: lid, sort: k })));
  pathCounts.push({ path: p.title, steps: ids.length });
});
console.table(pathCounts);

// ---------- clean up seeded rows that earlier seeds created but this build no longer produces ----------
// Only ids that follow the seed's own naming (<course>-l*, <course>-v-*, <course>-z*, <course>-m*) are touched, so
// lessons, quizzes and modules added by admins in the Admin Portal are never removed.
const inList = (s) => [...s].map(q).join(',');
for (const c of COURSES) {
  const own = (set, prefixes) => [...set].filter((id) => prefixes.some((p) => id.startsWith(`${c.id}-${p}`)));
  const L = own(made.lessons, ['l', 'v-']), M = own(made.modules, ['m']), Z = own(made.quizzes, ['z']);
  stmts.push(`DELETE FROM lessons WHERE course_id=${q(c.id)} AND (id LIKE ${q(c.id + '-l%')} OR id LIKE ${q(c.id + '-v-%')}) AND id NOT IN (${L.length ? inList(L) : "''"});`);
  stmts.push(`DELETE FROM quizzes WHERE course_id=${q(c.id)} AND id LIKE ${q(c.id + '-z%')} AND id NOT IN (${Z.length ? inList(Z) : "''"});`);
  stmts.push(`DELETE FROM modules WHERE course_id=${q(c.id)} AND id LIKE ${q(c.id + '-m%')} AND id NOT IN (${M.length ? inList(M) : "''"});`);
  for (const z of Z) stmts.push(`DELETE FROM questions WHERE quiz_id=${q(z)} AND sort >= ${qCount[z] || 0};`);
}

// ---------- remove videos that cannot be played (deleted, private, or embedding disabled) ----------
const dead = Object.entries(embedCache).filter(([, ok]) => ok === false).map(([id]) => id);
for (let i = 0; i < dead.length; i += 50) stmts.push(`DELETE FROM lessons WHERE kind='video' AND video_id IN (${dead.slice(i, i + 50).map(q).join(',')});`);

// ---------- news seed ----------
const news = [
  ['Welcome to the FundsIndia Learning Hub', 'Your one place for NISM preparation, sales and service skills, and market updates. Check the Market Updates page daily.', 'Announcement', 1],
  ['Reminder: keep your NISM V-A certificate valid', 'AMFI ARN holders must keep NISM V-A certification current. Check the validity on your certificate and re-certify in time.', 'Compliance', 0],
];
news.forEach((n, i) => stmts.push(insert('news', { id: `seed-news-${i}`, title: n[0], body: n[1], category: n[2], pinned: n[3], published: 1 })));

// ---------- write chunked files ----------
const out = join(here, 'out');
rmSync(out, { recursive: true, force: true });
mkdirSync(out, { recursive: true });
let chunk = [], size = 0, idx = 0;
const flush = () => {
  if (!chunk.length) return;
  writeFileSync(join(out, `seed-${String(idx++).padStart(2, '0')}.sql`), chunk.join('\n') + '\n');
  chunk = []; size = 0;
};
for (const s of stmts) {
  if (size + s.length > 350_000) flush();
  chunk.push(s); size += s.length + 1;
}
flush();

console.table(counts);
console.log(`Wrote ${idx} SQL file(s) to seed/out  (${(sizeOf() / 1024).toFixed(0)} KB total, ${stmts.length} statements)`);
rmSync(tmp, { recursive: true, force: true });

