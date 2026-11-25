// What each team is here to do. Drives the home page headline, the "Your focus" cards and the order / names
// of the sidebar sections. What a team can actually open is still decided by the server (Admin -> Team access).

export interface FocusCard { icon: string; title: string; text: string; course?: string; cat?: string }
export interface TeamUi {
  headline: string;
  blurb: string;
  /** Sidebar "Browse" order (course categories). */
  order: string[];
  /** Friendlier section names for this team. */
  labels?: Record<string, string>;
  focus: FocusCard[];
}

const SECTION: Record<string, { icon: string; label: string }> = {
  process: { icon: '📑', label: 'Process documents' },
  academy: { icon: '🌱', label: 'FundsIndia Academy' },
  nism: { icon: '🎓', label: 'NISM certifications' },
  sales: { icon: '💼', label: 'Sales & service' },
  tools: { icon: '🛠️', label: 'Zoho & Tata Tele' },
};
export const sectionInfo = (cat: string, team?: string | null) => ({ ...SECTION[cat], label: TEAMS[team || '']?.labels?.[cat] || SECTION[cat]?.label });

const growth = (extra: FocusCard[] = []): FocusCard[] => [
  { icon: '📊', title: 'Review the portfolio', text: 'Read the client’s holdings, spot gaps and what to review next.', course: 'nism-5a' },
  { icon: '➕', title: 'Bring additional investment', text: 'Position the right product for a top-up, a new SIP or a switch.', course: 'product-school' },
  { icon: '💬', title: 'Handle objections', text: 'Practise answers for “market is high”, fees and trust.', course: 'objection-handling' },
  ...extra,
  { icon: '📞', title: 'Better client conversations', text: 'Call structure and examples that build the relationship.', course: 'call-excellence' },
];

export const TEAMS: Record<string, TeamUi> = {
  'Customer Support': {
    headline: 'Resolve customer issues quickly and correctly',
    blurb: 'Your focus is customer pain points and service issues: understand the problem, resolve it within the turnaround time, and escalate correctly. Nothing on this page is about selling.',
    order: ['process', 'tools', 'sales', 'academy', 'nism'],
    labels: { sales: 'Service skills' },
    focus: [
      { icon: '📑', title: 'Process documents', text: 'Documents required, steps, turnaround time and a ready reply for every service request.', course: 'process-mf-support' },
      { icon: '🧭', title: 'Service workflows', text: 'Step-by-step resolution, SLAs and escalation paths.', course: 'customer-support' },
      { icon: '📞', title: 'Communicating on calls', text: 'Calm, clear call handling for upset or confused customers.', course: 'call-excellence' },
      { icon: '🛠️', title: 'Zoho & Tata Tele', text: 'Log every case, set dispositions, use recordings.', cat: 'tools' },
    ],
  },
  'MF Onboarding': {
    headline: 'Onboard new clients and get the first investment done',
    blurb: 'Your focus is client onboarding: complete KYC and bank set-up correctly, then help the new client make their first mutual-fund investment.',
    order: ['process', 'nism', 'sales', 'academy', 'tools'],
    labels: { sales: 'Client conversations', academy: 'Platform walkthroughs' },
    focus: [
      { icon: '📑', title: 'Onboarding documents', text: 'KYC, bank, nominee and status processes with the exact documents needed.', course: 'process-mf-support' },
      { icon: '🚀', title: 'First investment', text: 'Which SIP or lump sum to start a new client with, and how to explain it.', course: 'product-school' },
      { icon: '🎓', title: 'NISM V-A', text: 'The certification behind everything you recommend.', course: 'nism-5a' },
      { icon: '💬', title: 'Handle hesitation', text: 'Answers for “I will start later” and “is my money safe?”.', course: 'objection-handling' },
    ],
  },
  'Equity Onboarding': {
    headline: 'Open demat accounts and place the first investment',
    blurb: 'Your focus is client onboarding for equity: demat account opening, getting the account active, and the new client’s first investment.',
    order: ['process', 'nism', 'academy', 'sales', 'tools'],
    labels: { sales: 'Client conversations', academy: 'Stocks & platform videos' },
    focus: [
      { icon: '📑', title: 'Account & KYC documents', text: 'Documents and steps for KYC, bank and account changes.', course: 'process-mf-support' },
      { icon: '🏦', title: 'Securities market basics', text: 'Demat, trading, settlement and the market in plain terms.', course: 'nism-12' },
      { icon: '⚙️', title: 'Operations & risk', text: 'How trades settle and how margins protect the client.', course: 'nism-7' },
      { icon: '💬', title: 'Get the first trade placed', text: 'Move a new demat holder from “opened” to “invested”.', course: 'objection-handling' },
    ],
  },
  'MF Digital': {
    headline: 'Grow your onboarded clients',
    blurb: 'Your focus is developing clients who have already onboarded: review their mutual-fund portfolio and bring additional investment.',
    order: ['nism', 'sales', 'academy', 'tools', 'process'],
    labels: { sales: 'Client conversations' },
    focus: growth(),
  },
  'MF Silver': {
    headline: 'Grow your onboarded clients',
    blurb: 'Your focus is developing onboarded Silver clients: review their portfolio regularly and bring additional investment.',
    order: ['nism', 'sales', 'academy', 'tools', 'process'],
    labels: { sales: 'Client conversations' },
    focus: growth(),
  },
  'MF Gold': {
    headline: 'Deepen relationships with Gold clients',
    blurb: 'Your focus is developing onboarded Gold clients: review portfolios against goals and bring additional investment.',
    order: ['nism', 'sales', 'academy', 'tools', 'process'],
    labels: { sales: 'Client conversations' },
    focus: growth([{ icon: '🧭', title: 'Advisory depth', text: 'Financial planning and risk profiling for larger portfolios.', course: 'nism-10a' }]),
  },
  'MF Platinum': {
    headline: 'Advise Platinum clients end to end',
    blurb: 'Your focus is developing onboarded Platinum clients: full portfolio reviews and bringing additional investment, including advanced products.',
    order: ['nism', 'sales', 'academy', 'tools', 'process'],
    labels: { sales: 'Client conversations' },
    focus: growth([{ icon: '🧭', title: 'Advisory & PMS', text: 'Advanced advisory and portfolio-management topics.', course: 'nism-10b' }]),
  },
  'Equity Regular': {
    headline: 'Develop your demat account holders',
    blurb: 'Your focus is developing onboarded demat account holders: review their stock holdings and bring additional investment.',
    order: ['nism', 'academy', 'sales', 'tools', 'process'],
    labels: { sales: 'Client conversations', academy: 'Stocks & markets' },
    focus: [
      { icon: '📊', title: 'Review stock holdings', text: 'Fundamental and technical analysis to review what the client owns.', course: 'nism-15' },
      { icon: '📈', title: 'Derivatives & hedging', text: 'Futures, options and hedging a client’s holdings.', course: 'nism-8' },
      { icon: '➕', title: 'Bring additional investment', text: 'Ideas, IPOs and stock SIPs to add to the portfolio.', course: 'fi-academy' },
      { icon: '💬', title: 'Handle objections', text: 'Answers for volatility, timing and trust.', course: 'objection-handling' },
    ],
  },
  'Training & Quality': {
    headline: 'Training & Quality',
    blurb: 'You can open every course, process document and quiz. Use them to coach teams, audit quality, and send feedback on what needs improving.',
    order: ['process', 'nism', 'sales', 'academy', 'tools'],
    focus: [
      { icon: '📑', title: 'Process documents', text: 'The reference every service request should follow.', course: 'process-mf-support' },
      { icon: '🎓', title: 'NISM certifications', text: 'Course content and mock tests for every series.', cat: 'nism' },
      { icon: '💼', title: 'Sales & service skills', text: 'Objection handling, calls and service workflows.', cat: 'sales' },
      { icon: '✉️', title: 'Send feedback', text: 'Tell the admin team what to fix or add.', cat: 'contact' },
    ],
  },
};

export const DEFAULT_UI: TeamUi = {
  headline: 'Learn, certify and advise with confidence',
  blurb: 'Pick up where you left off, or start a learning path.',
  order: ['process', 'academy', 'nism', 'sales', 'tools'],
  focus: [],
};
export const teamUi = (team?: string | null): TeamUi => TEAMS[team || ''] || DEFAULT_UI;
