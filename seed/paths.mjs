// Step-by-step learning paths. Each `steps` function receives every seeded lesson
// ({id,cid,kind,title,module}) in creation order and returns lesson ids in the order they should be learned.

const inCourse = (L, cid, pred = () => true) => L.filter((l) => l.cid === cid && pred(l)).map((l) => l.id);
const fi = (L, ...mods) => mods.flatMap((m) => inCourse(L, 'fi-academy', (l) => l.module.startsWith(m)));

export const PATHS = [
  { id: 'path-investing-zero', icon: '🌱', level: 'Beginner', title: 'Investing from zero',
    description: 'Start here. Build the right mindset, understand what good advice looks like, and learn how mutual funds fit in — before your first SIP.',
    steps: (L) => fi(L, 'Start here') },
  { id: 'path-sip-mastery', icon: '📈', level: 'Beginner → Intermediate', title: 'SIP mastery',
    description: 'Why SIPs work, how long to stay invested, step-up SIPs, and how to judge mutual funds sensibly.',
    steps: (L) => fi(L, 'SIPs & mutual funds') },
  { id: 'path-bonds-sif', icon: '🏦', level: 'Intermediate', title: 'Bonds & Specialised Investment Funds',
    description: 'What bonds are, what to check before buying, and how SIFs differ across equity, debt and hybrid.',
    steps: (L) => fi(L, 'Bonds') },
  { id: 'path-stocks-ipo', icon: '💹', level: 'Intermediate', title: 'Stocks & IPOs on FundsIndia',
    description: 'Why invest in stocks, stock SIPs, Alpha research reports, placing orders and improving IPO allotment chances.',
    steps: (L) => fi(L, 'Stocks') },
  { id: 'path-markets', icon: '🌐', level: 'All', title: 'Markets & budget literacy',
    description: 'Understand the Union Budget and how to navigate market volatility with your goals in mind.',
    steps: (L) => fi(L, 'Markets & economy') },
  { id: 'path-amfi-distributor', icon: '🎓', level: 'Certification', title: 'Become an AMFI-certified distributor (NISM V-A)',
    description: 'The complete V-A track: exam overview, then each chapter as video → study notes → practice quiz, finishing with the mock exam.',
    steps: (L) => inCourse(L, 'nism-5a') },
  { id: 'path-adviser', icon: '🧭', level: 'Certification', title: 'Investment adviser track (NISM X-A → X-B)',
    description: 'Financial planning and risk profiling (Level 1) followed by advanced advisory topics (Level 2).',
    steps: (L) => [...inCourse(L, 'nism-10a'), ...inCourse(L, 'nism-10b')] },
  { id: 'path-sales-conversations', icon: '🗣️', level: 'Skills', title: 'Client conversations & objection handling',
    description: 'Scenario notes on common client objections, then the full objection-handling video series.',
    steps: (L) => [...inCourse(L, 'objection-handling', (l) => l.kind === 'note'), ...inCourse(L, 'objection-handling', (l) => l.kind === 'video').slice(0, 12)] },
  { id: 'path-tools', icon: '🛠️', level: 'Onboarding', title: 'Tools onboarding: Zoho CRM & Tata Tele',
    description: 'Get productive on the CRM and the dialer: guides first, then video tutorials.',
    steps: (L) => [...inCourse(L, 'zoho-crm', (l) => l.kind === 'note'), ...inCourse(L, 'zoho-crm', (l) => l.kind === 'video').slice(0, 6), ...inCourse(L, 'tata-tele')] },
];
