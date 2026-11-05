export interface NismWorkbookChapter {
  chapterNumber: number;
  title: string;
  weightagePercent: number;
  summaryNotes: string[];
  keyDefinitions: { term: string; explanation: string }[];
  regulatoryRules: string[];
  formulas?: { name: string; formula: string; example: string }[];
  examTraps: string[];
}

export interface NismWorkbook {
  courseCode: string;
  courseTitle: string;
  syllabusEdition: string;
  totalChapters: number;
  totalWeightage: number;
  examPattern: {
    durationMinutes: number;
    totalQuestions: number;
    maximumMarks: number;
    passingPercentage: number;
    negativeMarking: string;
    certificateValidity: string;
  };
  chapters: NismWorkbookChapter[];
  masterFormulaSheet: { name: string; formula: string; context: string }[];
  mustKnowComplianceLimits: { parameter: string; limit: string; regulation: string }[];
}

export const NISM_WORKBOOKS: Record<string, NismWorkbook> = {
  'nism-v-a': {
    courseCode: 'NISM V-A',
    courseTitle: 'Mutual Fund Distributors Certification Examination',
    syllabusEdition: '2025-2026 SEBI Master Circular Updated Edition',
    totalChapters: 12,
    totalWeightage: 100,
    examPattern: {
      durationMinutes: 120,
      totalQuestions: 100,
      maximumMarks: 100,
      passingPercentage: 50,
      negativeMarking: 'Zero (No negative marking in V-A)',
      certificateValidity: '3 Years (Renewable via CPE training)',
    },
    masterFormulaSheet: [
      {
        name: 'Net Asset Value (NAV)',
        formula: 'NAV = (Market Value of Investments + Current Assets + Accrued Income - Current Liabilities - Accrued Expenses) / Number of Outstanding Units',
        context: 'Computed daily up to 4 decimal places for liquid/debt funds, 2 decimal places for equity/balanced funds.',
      },
      {
        name: 'Sharpe Ratio',
        formula: 'Sharpe = (Rp - Rf) / σp',
        context: 'Measures excess return per unit of Total Risk (Standard Deviation). Higher is superior.',
      },
      {
        name: 'Treynor Ratio',
        formula: 'Treynor = (Rp - Rf) / βp',
        context: 'Measures excess return per unit of Systematic Risk (Beta). Used for well-diversified portfolios.',
      },
      {
        name: 'Jensen’s Alpha (α)',
        formula: 'α = Rp - [Rf + βp * (Rm - Rf)]',
        context: 'Measures fund manager’s value add above the CAPM benchmark expectation. Positive alpha signifies outperformance.',
      },
      {
        name: 'Expense Ratio (TER)',
        formula: 'TER = Total Recurring Scheme Operating Expenses / Daily Average Net Assets',
        context: 'Subject to SEBI statutory decreasing slab limits as AUM grows.',
      },
    ],
    mustKnowComplianceLimits: [
      { parameter: 'Liquid Fund Cut-off', limit: '1:30 PM (Funds must be credited before 1:30 PM)', regulation: 'SEBI Cut-off Circular' },
      { parameter: 'Other Schemes Cut-off', limit: '3:00 PM (Funds must be credited before 3:00 PM)', regulation: 'SEBI Uniform NAV Mandate' },
      { parameter: 'ELSS Mandatory Lock-in', limit: '3 Years from unit allotment date', regulation: 'Equity Linked Savings Scheme' },
      { parameter: 'Equity LTCG Tax', limit: '12.5% for gains exceeding ₹1.25 Lakhs per FY', regulation: 'Finance Act' },
      { parameter: 'Equity STCG Tax', limit: '20% flat without indexation', regulation: 'Finance Act' },
      { parameter: 'Maximum Sponsor Share', limit: 'Min 40% net worth contribution for 5 years', regulation: 'SEBI MF Reg 1996' },
    ],
    chapters: [
      {
        chapterNumber: 1,
        title: 'Investment Landscape & Concept of Mutual Funds',
        weightagePercent: 8,
        summaryNotes: [
          'Mutual funds in India are constitutionally organized as Trusts under the Indian Trusts Act, 1882.',
          'Three-tier regulatory architecture: Sponsor (creates the trust) -> Board of Trustees (fiduciary custodians) -> Asset Management Company (manages investments).',
          'Sponsor must have at least 5 years of track record in financial services with positive net worth in all 5 years and contribute minimum 40% net worth of AMC.',
          'Trustees must consist of at least 50% independent trustees (not affiliated with sponsor). AMC board must also have 50% independent directors.',
        ],
        keyDefinitions: [
          { term: 'Fiduciary Duty', explanation: 'The legal obligation of trustees to act exclusively in the best interests of unit-holders.' },
          { term: 'Custodian', explanation: 'Independent SEBI-registered entity holding the fund securities in safe custody; completely separate from the AMC.' },
        ],
        regulatoryRules: [
          'AMCs cannot act as trustee for any other mutual fund.',
          'Trustees must hold minimum 4 board meetings every financial year.',
        ],
        examTraps: [
          'Confusing the AMC with the Trust: The AMC is an operational company hired by the Trustees, not the owner of fund assets.',
        ],
      },
      {
        chapterNumber: 2,
        title: 'Legal Structure & SEBI Mutual Fund Regulations',
        weightagePercent: 10,
        summaryNotes: [
          'Offer Document consists of two parts: Scheme Information Document (SID) and Statement of Additional Information (SAI).',
          'Key Information Memorandum (KIM) is a concise summary of SID & SAI and must accompany every physical application form.',
          'SID must be updated annually within 6 months of the close of financial year.',
          'Material changes in scheme attributes (fundamental attribute changes) require a 30-day exit window at prevailing NAV without exit load.',
        ],
        keyDefinitions: [
          { term: 'Fundamental Attribute', explanation: 'Core investment objective, asset allocation pattern, or fee structure of the scheme.' },
          { term: 'Exit Window', explanation: 'A 30-day period during which unitholders can redeem without exit load if fundamental attributes change.' },
        ],
        regulatoryRules: [
          'Advertisements must include standard statutory disclaimer: "Mutual fund investments are subject to market risks...".',
          'Past performance can never be annualized for periods under 1 year.',
        ],
        examTraps: [
          'Assuming KIM replaces SID: KIM is only a summary; the legally binding contract is SID + SAI.',
        ],
      },
      {
        chapterNumber: 3,
        title: 'Scheme Categorization & Asset Allocation',
        weightagePercent: 12,
        summaryNotes: [
          'SEBI circular categorized funds into 5 broad groups: Equity, Debt, Hybrid, Solution Oriented, and Other Schemes.',
          'Large Cap Funds: Minimum 80% in top 100 stocks by full market capitalization.',
          'Mid Cap Funds: Minimum 65% in 101st to 250th stocks.',
          'Small Cap Funds: Minimum 65% in 251st and below.',
          'Flexi Cap Funds: Minimum 65% in equity with dynamic allocation across Large, Mid, Small caps.',
          'Multi Cap Funds: Minimum 25% in Large, 25% in Mid, and 25% in Small caps at all times.',
        ],
        keyDefinitions: [
          { term: 'Large Cap', explanation: '1st to 100th company in terms of full market capitalization.' },
          { term: 'Mid Cap', explanation: '101st to 250th company.' },
          { term: 'Small Cap', explanation: '251st company onwards.' },
        ],
        regulatoryRules: [
          'AMCs can only offer ONE scheme per category (except Index funds, ETFs, Sectoral/Thematic, and Fund of Funds).',
          'Balanced Advantage Funds have dynamic asset allocation without rigid equity/debt bounds.',
        ],
        examTraps: [
          'Confusing Multi Cap with Flexi Cap: Multi Cap requires strict 25% minimum in large, mid, and small caps; Flexi Cap has zero sub-category minimums.',
        ],
      },
      {
        chapterNumber: 4,
        title: 'NAV Computation, Total Expense Ratio & Accounting',
        weightagePercent: 10,
        summaryNotes: [
          'All expenses charged to the scheme must be within SEBI statutory limits under Regulation 52.',
          'Maximum base TER for first ₹500 Cr of daily net assets in equity schemes is 2.25%.',
          'Direct plans must have a lower TER than Regular plans by the exact amount of distributor commission.',
          'Additional 30 bps (0.30%) TER can be charged if 30% of gross new inflows come from B-30 (Beyond Top 30) cities.',
        ],
        keyDefinitions: [
          { term: 'TER', explanation: 'Total Expense Ratio representing operating costs expressed as a percentage of daily net assets.' },
          { term: 'Mark-to-Market', explanation: 'Valuing all securities in the portfolio at prevailing market prices at the end of each trading day.' },
        ],
        regulatoryRules: [
          'Brokerage and transaction costs charged to the scheme cannot exceed 0.12% for cash market trades and 0.05% for derivatives.',
        ],
        examTraps: [
          'Thinking Direct and Regular plans hold different portfolios: The portfolio is 100% identical; only the NAV differs due to commission deduction.',
        ],
      },
    ],
  },
  'nism-v-b': {
    courseCode: 'NISM V-B',
    courseTitle: 'Mutual Fund Foundation Certification Examination',
    syllabusEdition: '2025-2026 Foundation Syllabus Edition',
    totalChapters: 6,
    totalWeightage: 50,
    examPattern: {
      durationMinutes: 120,
      totalQuestions: 50,
      maximumMarks: 50,
      passingPercentage: 50,
      negativeMarking: 'Zero',
      certificateValidity: '3 Years',
    },
    masterFormulaSheet: [
      { name: 'Simple Return', formula: 'Return = (Sale Price - Purchase Price + Dividends) / Purchase Price * 100', context: 'Used for single period holding.' },
      { name: 'Compound Annual Growth Rate (CAGR)', formula: 'CAGR = (Ending Value / Beginning Value)^(1/n) - 1', context: 'Standard measure for multi-year equity returns.' },
    ],
    mustKnowComplianceLimits: [
      { parameter: 'Passing Score', limit: '25 marks out of 50 (50%)', regulation: 'NISM Examination Rules' },
      { parameter: 'Eligible Candidates', limit: 'Postal agents, retired teachers, bank branch personnel', regulation: 'AMFI Foundation Cadre' },
    ],
    chapters: [
      {
        chapterNumber: 1,
        title: 'Basics of Financial Planning and Mutual Funds',
        weightagePercent: 20,
        summaryNotes: [
          'Role of mutual funds as an indirect investment vehicle for retail investors.',
          'Difference between physical assets (Gold, Real Estate) and financial assets (Stocks, Bonds, Mutual Funds).',
          'Concept of compounding and inflation eroding purchasing power over time.',
        ],
        keyDefinitions: [
          { term: 'Compounding', explanation: 'Earning interest on interest over multiple periods.' },
          { term: 'Inflation', explanation: 'The general rise in price levels over time, reducing real value of money.' },
        ],
        regulatoryRules: [
          'Distributors must be registered with AMFI and hold an active ARN card.',
        ],
        examTraps: ['Confusing bank fixed deposits with mutual fund debt schemes.'],
      },
    ],
  },
  'nism-viii': {
    courseCode: 'NISM VIII',
    courseTitle: 'Equity Derivatives Certification Examination',
    syllabusEdition: '2025-2026 Derivatives Regulations Edition',
    totalChapters: 8,
    totalWeightage: 100,
    examPattern: {
      durationMinutes: 120,
      totalQuestions: 100,
      maximumMarks: 100,
      passingPercentage: 60,
      negativeMarking: '25% (0.25 marks deducted per wrong answer)',
      certificateValidity: '3 Years',
    },
    masterFormulaSheet: [
      { name: 'Cost of Carry Futures Price', formula: 'F = S * [1 + r*(t/365)] - D', context: 'Theoretical fair value of index and stock futures.' },
      { name: 'Call Option Intrinsic Value', formula: 'IV = Max(0, Spot - Strike)', context: 'Positive for In-The-Money Call options; Zero for OTM/ATM.' },
      { name: 'Put Option Intrinsic Value', formula: 'IV = Max(0, Strike - Spot)', context: 'Positive for In-The-Money Put options; Zero for OTM/ATM.' },
      { name: 'Option Premium', formula: 'Premium = Intrinsic Value + Time Value', context: 'Time value decays to zero on contract expiration day.' },
    ],
    mustKnowComplianceLimits: [
      { parameter: 'SPAN Margin Collection', limit: '100% upfront margin collection before trade execution', regulation: 'SEBI Peak Margin Norms' },
      { parameter: 'Physical Settlement', limit: 'Mandatory physical delivery for all stock derivative contracts', regulation: 'SEBI Derivatives Circular' },
      { parameter: 'Client Position Limit', limit: 'Higher of 1% of free float market cap or 5% of open interest', regulation: 'Exchange Position Limits' },
    ],
    chapters: [
      {
        chapterNumber: 1,
        title: 'Introduction to Derivatives & Forward Contracts',
        weightagePercent: 12,
        summaryNotes: [
          'Derivatives derive value from underlying securities (Indices, Equities, Currencies, Commodities).',
          'Futures are standardized exchange-traded contracts; forwards are bilateral OTC contracts with counterparty default risk.',
          'Clearing Corporation guarantees settlement of all exchange trades through legal novation.',
        ],
        keyDefinitions: [
          { term: 'Novation', explanation: 'Clearing Corp becomes buyer to every seller and seller to every buyer.' },
          { term: 'Basis', explanation: 'Spot Price minus Futures Price. Converges to zero at contract expiry.' },
        ],
        regulatoryRules: [
          'All trades on Indian exchanges are physically settled for stock derivatives at expiry.',
        ],
        examTraps: ['Forgetting that basis can be positive (Backwardation) or negative (Contango).'],
      },
    ],
  },
  'nism-x-a': {
    courseCode: 'NISM X-A',
    courseTitle: 'Investment Adviser (Level 1) Certification Examination',
    syllabusEdition: '2025-2026 SEBI RIA Level 1 Edition',
    totalChapters: 8,
    totalWeightage: 100,
    examPattern: {
      durationMinutes: 120,
      totalQuestions: 100,
      maximumMarks: 100,
      passingPercentage: 60,
      negativeMarking: '25% (0.25 marks deducted per wrong answer)',
      certificateValidity: '3 Years',
    },
    masterFormulaSheet: [
      { name: 'Capital Asset Pricing Model (CAPM)', formula: 'E(R) = Rf + β * (Rm - Rf)', context: 'Calculates required rate of return for risky securities.' },
      { name: 'Rule of 72', formula: 'Years to Double = 72 / Annual Interest Rate', context: 'Quick estimation of capital doubling period.' },
      { name: 'Net Present Value (NPV)', formula: 'NPV = ∑ [CFt / (1 + r)^t] - Initial Outlay', context: 'Project feasibility: invest if NPV > 0.' },
    ],
    mustKnowComplianceLimits: [
      { parameter: 'RIA Client Level Segregation', limit: 'Strict segregation between advisory and distribution activities', regulation: 'SEBI RIA Regulations 2020' },
      { parameter: 'RIA Fee Cap (AUM Model)', limit: 'Maximum 2.5% of AUM per family per annum', regulation: 'SEBI Advisory Fee Slab' },
      { parameter: 'RIA Fee Cap (Fixed Fee Model)', limit: 'Maximum ₹1,25,000 per family per annum', regulation: 'SEBI Advisory Fee Slab' },
    ],
    chapters: [
      {
        chapterNumber: 1,
        title: 'Personal Financial Planning & Client Profiling',
        weightagePercent: 15,
        summaryNotes: [
          'The 6-step financial planning process: (1) Establishing relationship, (2) Gathering client data, (3) Analyzing client status, (4) Developing recommendations, (5) Implementing recommendations, (6) Monitoring portfolio.',
          'Emergency fund sizing: 3 to 6 months of mandatory household expenses in liquid instruments.',
          'Debt servicing ratio: Total monthly EMIs should not exceed 40-45% of net monthly take-home income.',
        ],
        keyDefinitions: [
          { term: 'Risk Profile', explanation: 'Composite assessment of client willingness and financial capacity to absorb volatility.' },
          { term: 'Solvency Ratio', explanation: 'Net worth divided by total assets. Indicates financial cushion.' },
        ],
        regulatoryRules: [
          'Investment advisers cannot charge execution fees or receive distribution commissions from recommended products.',
        ],
        examTraps: ['Confusing fee caps: AUM model cap is 2.5%, Fixed fee cap is ₹1.25 Lakhs per family.'],
      },
    ],
  },
  'nism-x-b': {
    courseCode: 'NISM X-B',
    courseTitle: 'Investment Adviser (Level 2) Certification Examination',
    syllabusEdition: '2025-2026 SEBI RIA Level 2 Case Study Edition',
    totalChapters: 8,
    totalWeightage: 100,
    examPattern: {
      durationMinutes: 120,
      totalQuestions: 100,
      maximumMarks: 100,
      passingPercentage: 60,
      negativeMarking: '25% (0.25 marks deducted per wrong answer)',
      certificateValidity: '3 Years',
    },
    masterFormulaSheet: [
      { name: 'Modified Duration (MD)', formula: 'MD = Macaulay Duration / (1 + YTM / m)', context: 'Measures percentage price change of a bond for a 1% change in yield.' },
      { name: 'Dollar Duration (DV01)', formula: 'DV01 = MD * Price * 0.0001', context: 'Change in absolute bond value per 1 basis point (0.01%) yield move.' },
    ],
    mustKnowComplianceLimits: [
      { parameter: 'Corporate RIA Net Worth', limit: 'Minimum ₹50 Lakhs net worth at all times', regulation: 'SEBI RIA Regulations' },
      { parameter: 'Individual RIA Net Worth', limit: 'Minimum ₹5 Lakhs net worth', regulation: 'SEBI RIA Regulations' },
    ],
    chapters: [
      {
        chapterNumber: 1,
        title: 'Advanced Risk Management & Estate Planning',
        weightagePercent: 18,
        summaryNotes: [
          'Estate planning structures: Wills, Private Family Trusts (Revocable vs Irrevocable), Powers of Attorney.',
          'A Private Discretionary Trust protects assets against future creditors and bankruptcy of beneficiaries.',
          'Tax implications of estate transfers: Inheritances and gifts received under a Will are exempt from income tax in India.',
        ],
        keyDefinitions: [
          { term: 'Probate', explanation: 'Official certification of the validity of a Will by a competent civil court.' },
          { term: 'Discretionary Trust', explanation: 'Trust where trustee decides how and when income is distributed to beneficiaries.' },
        ],
        regulatoryRules: [
          'RIAs must maintain audit trail of all client advice and risk evaluations for minimum 5 years.',
        ],
        examTraps: ['Assuming inheritances are taxed: There is currently zero estate duty / inheritance tax in India.'],
      },
    ],
  },
  'nism-xv': {
    courseCode: 'NISM XV',
    courseTitle: 'Research Analyst Certification Examination',
    syllabusEdition: '2025-2026 SEBI RA Regulations Edition',
    totalChapters: 8,
    totalWeightage: 100,
    examPattern: {
      durationMinutes: 120,
      totalQuestions: 100,
      maximumMarks: 100,
      passingPercentage: 60,
      negativeMarking: '25% (0.25 marks deducted per wrong answer)',
      certificateValidity: '3 Years',
    },
    masterFormulaSheet: [
      { name: 'Price to Earnings (P/E) Ratio', formula: 'P/E = Market Price per Share / Earnings per Share (EPS)', context: 'Valuation multiple comparing stock price to net profitability.' },
      { name: 'Enterprise Value (EV)', formula: 'EV = Market Cap + Total Debt - Cash & Cash Equivalents', context: 'Total theoretical acquisition cost of an entire firm.' },
      { name: 'EV / EBITDA', formula: 'EV / EBITDA = Enterprise Value / EBITDA', context: 'Capital structure-neutral operating valuation metric.' },
    ],
    mustKnowComplianceLimits: [
      { parameter: 'Personal Trading Blackout', limit: '30 days after publishing research report', regulation: 'SEBI (Research Analysts) Regulations 2014' },
      { parameter: 'Pre-Publication Freeze', limit: '5 days before releasing research report', regulation: 'SEBI RA Code of Conduct' },
      { parameter: 'Holding Disclosure Threshold', limit: '1% or more shareholding in subject company', regulation: 'Mandatory Report Disclosures' },
    ],
    chapters: [
      {
        chapterNumber: 1,
        title: 'Macroeconomic Analysis & Regulatory Framework',
        weightagePercent: 14,
        summaryNotes: [
          'Macroeconomic indicators: Real GDP vs Nominal GDP, CPI vs WPI inflation, Fiscal Deficit, Current Account Deficit.',
          'Monetary policy transmission: Repo rate hikes increase borrowing costs, slowing corporate capex and cooling inflation.',
          'SEBI (Research Analysts) Regulations 2014 mandate Chinese Walls between research teams and merchant banking/trading desks.',
        ],
        keyDefinitions: [
          { term: 'Chinese Wall', explanation: 'Strict physical and operational barriers preventing insider deal information from reaching analysts.' },
          { term: 'Front-Running', explanation: 'Illegal practice of buying securities before publishing a positive research recommendation.' },
        ],
        regulatoryRules: [
          'Research reports must prominently display analyst shareholding and compensation conflict disclosures.',
        ],
        examTraps: ['Forgetting the 30-day trading freeze: An analyst cannot trade against their call for 30 days.'],
      },
    ],
  },
  'nism-xxi': {
    courseCode: 'NISM XXI',
    courseTitle: 'Portfolio Managers & Alternative Investment Funds Certification',
    syllabusEdition: '2025-2026 SEBI PMS & AIF Master Regulations Edition',
    totalChapters: 8,
    totalWeightage: 100,
    examPattern: {
      durationMinutes: 120,
      totalQuestions: 100,
      maximumMarks: 100,
      passingPercentage: 60,
      negativeMarking: '25% (0.25 marks deducted per wrong answer)',
      certificateValidity: '3 Years',
    },
    masterFormulaSheet: [
      { name: 'Time-Weighted Rate of Return (TWRR)', formula: 'TWRR = [(1 + R1) * (1 + R2) * ... * (1 + Rn)] - 1', context: 'SEBI mandated standard for reporting PMS portfolio performance, eliminating cash flow distortion.' },
      { name: 'AIF Waterfall Carried Interest', formula: 'Carried Interest = 20% of (Net Profit - Hurdle Return)', context: 'GP profit participation once LPs achieve preferred hurdle rate.' },
    ],
    mustKnowComplianceLimits: [
      { parameter: 'Minimum PMS Ticket Size', limit: '₹50 Lakhs per client', regulation: 'SEBI (Portfolio Managers) Regulations 2020' },
      { parameter: 'Minimum AIF Ticket Size', limit: '₹1 Crore per investor (₹25 Lakhs for employees)', regulation: 'SEBI (Alternative Investment Funds) Regulations 2012' },
      { parameter: 'Minimum AIF Fund Corpus', limit: '₹20 Crores (₹10 Crores for Angel Funds)', regulation: 'SEBI AIF Corpus Rule' },
      { parameter: 'Discretionary PMS Leverage', limit: 'Strictly prohibited from borrowing or leveraging', regulation: 'SEBI PMS Investment Limits' },
      { parameter: 'AIF Leverage Permission', limit: 'Permitted ONLY in Category III AIFs', regulation: 'SEBI AIF Category III Rule' },
    ],
    chapters: [
      {
        chapterNumber: 1,
        title: 'SEBI Portfolio Managers Regulations & Fiduciary Governance',
        weightagePercent: 15,
        summaryNotes: [
          'PMS services: Discretionary (manager makes decisions), Non-Discretionary (manager recommends, client approves), Advisory (pure advice).',
          'Statutory minimum investment: ₹50 Lakhs per client. A client cannot start or maintain a PMS with less than ₹50 Lakhs.',
          'Performance reporting must strictly use Time-Weighted Rate of Return (TWRR) net of all fees.',
          'PMS assets are held in the client’s individual demat account and bank account under power of attorney (separate from manager).',
        ],
        keyDefinitions: [
          { term: 'Discretionary PMS', explanation: 'Manager has full power of attorney to execute buy/sell trades without prior client consent.' },
          { term: 'TWRR', explanation: 'Eliminates the impact of external client cash inflows/outflows on manager skill measurement.' },
        ],
        regulatoryRules: [
          'No upfront fees can be charged to PMS clients; all fees must be rationalized.',
        ],
        examTraps: ['Confusing PMS ticket with AIF ticket: Minimum PMS is ₹50 Lakhs; Minimum AIF is ₹1 Crore.'],
      },
    ],
  },
};
