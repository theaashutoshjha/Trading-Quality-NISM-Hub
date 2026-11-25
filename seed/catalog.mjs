// Course catalogue + video sources.
// Videos are discovered from public YouTube listings by seed/tools/*.mjs and stored in seed/data/*.json.
// FRESHNESS RULE: third-party series keep only videos published within MAX_AGE_DAYS (YouTube reports
// age in coarse buckets: "11 months ago" -> "1 year ago"). FundsIndia's own evergreen videos are hand-picked.
export const MAX_AGE_DAYS = 364;

const S = (id, title, channel, lang = 'English', extra = {}) => ({ id, title, channel, lang, ...extra });

export const NISM_LINKS = [
  { title: 'NISM - certification & exam information', url: 'https://www.nism.ac.in/certification/' },
  { title: 'NISM - official workbooks', url: 'https://www.nism.ac.in/publication/' },
];

export const COURSES = [
  // ---- FundsIndia's own academy (every channel video, grouped by seed/fi-academy.mjs) ----
  { id: 'fi-academy', src: null, code: 'FI ACADEMY', title: 'FundsIndia Academy', subtitle: 'Investing, SIPs, bonds, stocks & markets', category: 'academy', level: 'All employees', popular: 1,
    description: 'Every public video from the FundsIndia YouTube channel, grouped by topic: investor mindset, getting started on the platform, SIPs and mutual funds, bonds and SIFs, stocks and IPOs, NPS, market views, fund-manager talks, media appearances, customer voices and brand films.', series: [], links: [] },

  // ---- NISM ----
  { id: 'nism-5a', src: 'va', code: 'NISM V-A', title: 'NISM Series V-A', subtitle: 'Mutual Fund Distributors Certification', category: 'nism', level: 'Mandatory (AMFI ARN)', popular: 1,
    description: 'The mandatory certification for mutual fund distributors. Chapter-wise video lessons from the full V-A course playlist, chapter summary notes from the September 2026 workbook, chapter practice, 20 full mock tests and a final assessment.',
    series: [S('PLmFN7_8sAtp-jEW3BRN_VwHm1iLO8LMs_', 'NISM V-A complete course (2026)', 'N V Finance', 'English', { byChapter: true, noAgeFilter: true })], links: NISM_LINKS },
  { id: 'nism-5b', src: 'vb', code: 'NISM V-B', title: 'NISM Series V-B', subtitle: 'Mutual Fund Foundation', category: 'nism', level: 'Foundation',
    description: 'Foundation-level mutual fund certification. Study notes and chapter practice; videos are mock-test walkthroughs aligned to the V-B chapters.',
    series: [], videos: [
      ['OdU189lVu-A', 'Chapter 1: Investment Landscape (mock test)', 'TradebookInsight', 14], ['4kkDzOaRlG4', 'Chapter 2: Concept & Role of a Mutual Fund (mock test)', 'TradebookInsight', 12],
      ['1kPXichd_wM', 'Chapter 4: Mutual Fund Products (mock test)', 'TradebookInsight', 12], ['bzKGhu3KODE', 'Chapter 5: Scheme Related Information (mock test)', 'TradebookInsight', 15],
      ['TUmZj44xZ0g', 'Chapter 6: Fund Distribution & Channel Management (mock test)', 'TradebookInsight', 12], ['Q9mMt4wgItU', 'Chapter 7: Performance of Mutual Funds (mock test)', 'TradebookInsight', 14],
      ['1TcMWHQ8I8g', 'Chapter 9: Investor Services (mock test)', 'TradebookInsight', 14]], links: NISM_LINKS },
  { id: 'nism-5d', src: null, code: 'NISM V-D', title: 'NISM Series V-D', subtitle: 'Mutual Fund - SIF Distributors', category: 'nism', level: 'Specialised',
    description: 'Certification for distributing Specialised Investment Funds (SIF). Structured video series from Kotak Mutual Fund\'s ProStart programme.',
    series: [S('PLeZnOoUn7J9aQ6Fp-OcLfR13D2TSWDvC4', 'SIF programme', 'ProStart by Kotak Mutual Fund', 'English')], links: NISM_LINKS },
  { id: 'nism-7', src: null, code: 'NISM VII', title: 'NISM Series VII', subtitle: 'Securities Operations & Risk Management', category: 'nism', level: 'Operations',
    description: 'Clearing, settlement, risk management and operations in securities markets (2026 syllabus videos).',
    series: [S('PLMdK_Oe95V-Emz2u-MKMqi308DUFKaFw2', 'SORM 2026', 'Tech Courses', 'English')], links: NISM_LINKS },
  { id: 'nism-8', src: 'viii', code: 'NISM VIII', title: 'NISM Series VIII', subtitle: 'Equity Derivatives', category: 'nism', level: 'Advanced',
    description: 'Futures, options, payoffs, Greeks, strategies, clearing and settlement and risk management.',
    series: [S('PLmFN7_8sAtp-sbsYOJQT1CtkFa7Y71b99', 'Equity Derivatives - complete syllabus (N V Finance)', 'N V Finance', 'English', { noAgeFilter: true })], links: NISM_LINKS },
  { id: 'nism-10a', src: 'xa', code: 'NISM X-A', title: 'NISM Series X-A', subtitle: 'Investment Adviser (Level 1)', category: 'nism', level: 'Advisory', popular: 1,
    description: 'Financial planning, risk profiling and the SEBI (Investment Advisers) Regulations.',
    series: [S('PLfHD8HnzzO3gZVRWxiv_npF6fKa9x1c5-', 'X-A complete course (2026)', 'NISM Series', 'English'), S('PLmFN7_8sAtp_cMYiseT7gmvRMRngbcmZJ', 'N V Finance: Investment Adviser course (earlier combined syllabus)', 'N V Finance', 'English', { noAgeFilter: true })], links: NISM_LINKS },
  { id: 'nism-10b', src: 'xb', code: 'NISM X-B', title: 'NISM Series X-B', subtitle: 'Investment Adviser (Level 2)', category: 'nism', level: 'Advisory',
    description: 'Advanced advisory: portfolio construction, tax and estate planning, insurance, retirement planning.',
    series: [S('PLfHD8HnzzO3iRmhhHrcPvIO90gXVsQ9Qe', 'X-B complete course (2026)', 'NISM Series', 'English'), S('PLmFN7_8sAtp_cMYiseT7gmvRMRngbcmZJ', 'N V Finance: Investment Adviser course (earlier combined syllabus)', 'N V Finance', 'English', { noAgeFilter: true })], links: NISM_LINKS },
  { id: 'nism-12', src: null, code: 'NISM XII', title: 'NISM Series XII', subtitle: 'Securities Markets Foundation', category: 'nism', level: 'Foundation',
    description: 'Introductory certification on securities markets, intermediaries, products and regulation.',
    series: [S('PLnoEvI4d8KbqX1Xrd4hvaGWrDrkNtsiVc', 'Securities Markets Foundation', 'DeepStratAI', 'English')], links: NISM_LINKS },
  { id: 'nism-13', src: null, code: 'NISM XIII', title: 'NISM Series XIII', subtitle: 'Common Derivatives (SIF)', category: 'nism', level: 'Specialised',
    description: 'Common derivatives knowledge for SIF-related roles.',
    series: [S('PLxiuyl6opD1lJM-IGtVY8Cb5WMPb6YBH5', 'IGNITE Knowledge Series', 'KFin Technologies', 'English')], links: NISM_LINKS },
  { id: 'nism-15', src: 'xv', code: 'NISM XV', title: 'NISM Series XV', subtitle: 'Research Analyst', category: 'nism', level: 'Research', popular: 1,
    description: 'Fundamental and technical analysis, valuation, report writing and SEBI (Research Analysts) Regulations.',
    series: [S('PL3uUjzLk6PukW-3vHcwrHQmTfRVLo3KZ8', 'Research Analyst 2026 full course', 'The Valuation School', 'English'), S('PLMdK_Oe95V-GVbCQMRnd4qowd6OgSqk7A', 'Research Analyst 2026', 'Tech Courses', 'English')], links: NISM_LINKS },
  { id: 'nism-16', src: null, code: 'NISM XVI', title: 'NISM Series XVI', subtitle: 'Commodity Derivatives', category: 'nism', level: 'Specialised',
    description: 'Commodity markets, futures and options on commodities, delivery and settlement.',
    series: [S('PLb7qySHhh8nBXIjmIQxYQ_0WuEKFbWfVF', 'Commodity Derivatives', 'Finshala', 'English')], links: NISM_LINKS },
  { id: 'nism-21a', src: 'xxi', code: 'NISM XXI-A', title: 'NISM Series XXI-A', subtitle: 'Portfolio Managers (PMS)', category: 'nism', level: 'Specialised',
    description: 'Portfolio management services: regulations, strategies, performance measurement and risk.',
    series: [S('PLMdK_Oe95V-ET_SRJgBJwWoxul01yEuix', 'PMS Distributors', 'Tech Courses', 'English'), S('PLfHD8HnzzO3ihoJKb1Yh5Y8KBQ3Tkn6ox', 'XXI-A complete course (2026)', 'NISM Series', 'English')], links: NISM_LINKS },

  // ---- Sales & service ----
  { id: 'product-school', src: 'product', code: 'PRODUCT', title: 'Product School', subtitle: 'Know what you sell', category: 'sales', level: 'All advisors', popular: 1,
    description: 'Mutual fund products, SIP/STP/SWP mechanics and how to position them. Pair with the FundsIndia Academy videos.', series: [], links: [] },
  { id: 'objection-handling', src: 'objection', code: 'SALES-OBJ', title: 'Objection Handling', subtitle: 'Turn "no" into a conversation', category: 'sales', level: 'All advisors',
    description: 'Scenario notes on market highs/lows, fees and trust, plus the full objection-handling video series for financial professionals.',
    series: [S('PLHm1pyF7GOrSXcPgU9RAsaiTLEG7yXZ76', 'Objection handling for financial professionals', 'Dr. Sanjay Tolani', 'English', { noAgeFilter: true })], links: [] },
  { id: 'call-excellence', src: 'call', code: 'SALES-CALL', title: 'Call Excellence Lab', subtitle: 'Better client conversations', category: 'sales', level: 'All advisors',
    description: 'Annotated call transcripts with rubrics, plus call-centre communication training videos.',
    series: [S('PLU_eVIGNvkSU8ZO6Twyf5koGHFlLfsqyN', 'Call centre training', 'Call Center Academy', 'English', { limit: 24 })], links: [] },
  { id: 'customer-support', src: 'support', code: 'SERVICE', title: 'Customer Support Workflows', subtitle: 'Resolve fast, escalate right', category: 'sales', level: 'Service & ops',
    description: 'Step-by-step service workflows, SLAs and templates, plus customer-service skills videos.',
    series: [S('PLIJnEk2VdPAUCzHl1WurwKuFAjFsXjW9E', 'Customer service training 2026', 'Business Training', 'English'), S('PLCcteVWYyBttgFMp1ihqWo2ZVgO3kAetA', 'Customer service skills', 'CareerVidz', 'English')], links: [] },

  // ---- Tools ----
  { id: 'zoho-crm', src: 'zoho', code: 'ZOHO CRM', title: 'Zoho CRM', subtitle: 'Daily CRM discipline', category: 'tools', level: 'All sales & service', popular: 1,
    description: 'How to use Zoho CRM for leads, follow-ups, deals, call notes and reports, with beginner video tutorials.',
    series: [S('PLvIl24i0xtieCluSLlhmcIC74fChT2Ffm', 'Zoho CRM beginner series', 'Hema Glory', 'English'), S('PLZKqUC9F58AoLjPnALl22w3E_oVwGKTz-', 'Zoho training tutorials', 'Drew Brockbank', 'English')],
    links: [{ title: 'Zoho CRM Help Center', url: 'https://help.zoho.com/portal/en/kb/crm' }, { title: 'Zoho Academy', url: 'https://www.zoho.com/academy/' }] },
  { id: 'tata-tele', src: 'tata', code: 'TATA TELE', title: 'Tata Tele (Smartflo) Telephony', subtitle: 'Calling, IVR and recordings', category: 'tools', level: 'All sales & service',
    description: 'Using the cloud-telephony dialer: agent status, click-to-call, dispositions, recordings and troubleshooting.',
    series: [S('PLrW9y48k3aJOtFRGCa4D4B5sfZdt40xJ_', 'Product explainers', 'Tata Tele Business Services', 'English')], links: [{ title: 'Tata Tele Business Services', url: 'https://www.tatatelebusiness.com/' }] },

  // ---- Foundations ----
  { id: 'markets-basics', src: 'markets', code: 'MARKETS', title: 'Following the Markets', subtitle: 'A daily 5-minute routine', category: 'foundation', level: 'All staff',
    description: 'How to follow market and regulatory changes without noise. Live headlines are on the Market Updates page.', series: [], links: [] },
  { id: 'compliance', src: 'compliance', code: 'COMPLIANCE', title: 'Regulators & Compliance Library', subtitle: 'SEBI, AMFI, RBI, NISM', category: 'foundation', level: 'All staff',
    description: 'Conduct rules and the official sources every employee should know.', series: [],
    links: [
      { title: 'SEBI - Circulars', url: 'https://www.sebi.gov.in/sebiweb/home/HomeAction.do?doListing=yes&sid=1&ssid=7&smid=0' },
      { title: 'AMFI India', url: 'https://www.amfiindia.com/' }, { title: 'Mutual Funds Sahi Hai', url: 'https://www.mutualfundssahihai.com/' },
      { title: 'RBI - Press releases', url: 'https://www.rbi.org.in/Scripts/Pr_View.aspx' }, { title: 'SEBI Investor Website', url: 'https://investor.sebi.gov.in/' },
    ] },
];

// FundsIndia channel: curated, education-only, evergreen. Order = step-by-step order inside each category.
// Excluded on purpose: weekly/yearly market roundups, single-stock analyses, promos/ads, festival & trivia clips,
// interviews/PR, and anything older than ~2 years (outdated).
export const FI_CURATED = [
  ['Start here: investor mindset', [
    'QmCKI5RHTGU', '1yJcubWlynY', 'RKFsagBxtuk', 'JENU8-ro9pY', 'gc_xDznuLA4', '9NipFPxWBl4', 'ck_lq0jPQDI', 'QYxyYwu7dvE', 'Mde1tgG_aUI', 'pIGL4DTDfuU']],
  ['SIPs & mutual funds', [
    '8RTfHWsJ_TA', 'BWypUHxs7ck', '3fOy1tqLgp0', 's4YofbPmFRc', 'sNkayWd_fQY', 'xF0jL15KWw8', '74xLvlUMdUc', 'sZ5Uv3duh80']],
  ['Bonds & Specialised Investment Funds (SIF)', ['kTt6LJmBmcY', '1G303rytQhc', 'pTXA4FFsdds', '_uMEDzinY_M', 'bJrM2cdiPkA']],
  ['Stocks & IPOs on FundsIndia', ['wA5CgGp1bFs', 'TTDz4GMIbiY', 'I8T6We19qNs', 'ZCvHa913oZU', '1YUMa8PEwZ4', 'KjcthL4isKY']],
  ['Markets & economy', ['UhGGYwxRWOI', 'g9OhCpnfX14', '1D2slk7daWI', 'juwyOl0XqYo']],
];
