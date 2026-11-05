import { Course, SyllabusChapter } from '../../types';

// ==========================================
// NISM V-B: Mutual Fund Foundation
// ==========================================
export const NISM_VB_CHAPTERS: SyllabusChapter[] = [
  {
    id: 'vb-ch-01',
    chapterNumber: 1,
    title: 'Financial Planning & The Role of Mutual Funds',
    weightagePercent: 20,
    targetDurationMinutes: 45,
    learningObjectives: [
      'Understand investor lifecycle and emergency savings buffers',
      'Explain the impact of inflation on long-term purchasing power',
      'Differentiate direct equity investing from pooled mutual fund investing',
    ],
    topics: [
      {
        id: 'VB-CH01-T01',
        chapterId: 'vb-ch-01',
        courseCode: 'NISM V-B',
        topicCode: 'T1.1',
        title: 'Concept of Compounding, Inflation & Long-term Wealth Creation',
        durationMinutes: 25,
        learningObjectives: ['Calculate real rate of return', 'Explain the Rule of 72'],
        explanation: {
          what: 'Mutual funds pool savings from small investors to create a professionally managed diversified portfolio. Compounding reinvests returns to generate exponential wealth growth over time.',
          why: 'Retail investors lack the time, capital, and analytical tools to buy 40-50 individual stocks directly. Mutual funds provide instant diversification starting with as little as ₹500/month.',
          how: 'Investor buys units at prevailing Net Asset Value (NAV). The AMC invests across equities, debt, or money market instruments according to scheme objective.',
          definitions: [
            { term: 'Compounding', definition: 'The exponential growth process where earnings from an investment are reinvested to generate their own additional returns.' },
            { term: 'Inflation', definition: 'The general increase in price levels over time which reduces purchasing power.' },
          ],
          rulesAndRegulations: [
            'All mutual fund distributors must hold a valid AMFI Registration Number (ARN).',
            'No distributor can offer cash rebates or commission pass-backs to investors.',
          ],
          formulas: [
            {
              name: 'Rule of 72 (Doubling Time)',
              formula: 'Years to Double ≈ 72 / Annual Return Rate (%)',
              workedExample: 'At 12% expected equity return: 72 / 12 = 6 years to double capital.',
            },
          ],
          practicalScenario: 'An investor in Tier-2 India saving ₹2,000 monthly in a recurring deposit earns 6.5% interest, barely beating inflation. By switching to a diversified hybrid mutual fund delivering 11-13% long-term returns, their retirement corpus doubles over a 15-year horizon.',
          commonMistakes: ['Thinking mutual funds only invest in risky stock market equities.'],
        },
        instructorScript: 'Welcome to NISM Series V-B Foundation course. As an advisor, your mission is to guide first-time savers from fixed deposits into well-diversified mutual funds...',
        slides: [
          {
            slideNumber: 1,
            title: 'Foundations of Wealth & Mutual Funds',
            bulletPoints: [
              'Pooled investment architecture: Professional management with low minimums',
              'Power of Compounding: Small systematic SIPs compound exponentially',
              'Diversification: Instant exposure to 40+ corporate champions across sectors',
            ],
            narration: 'Systematic discipline is the single greatest determinant of investor wealth.',
          },
        ],
        practiceQuestions: [
          {
            id: 'Q-VB-1-1',
            question: 'Using the Rule of 72, approximately how many years will it take for an investment to double at a compounding annual return of 9%?',
            options: ['6 years', '8 years', '10 years', '12 years'],
            correctIndex: 1,
            explanation: '72 / 9 = 8 years.',
            examTip: 'Rule of 72: Divide 72 by the annual percentage rate to find doubling time.',
          },
        ],
      },
    ],
  },
];

export const NISM_VB_COURSE: Course = {
  id: 'nism-v-b',
  code: 'NISM V-B',
  title: 'NISM Series V-B',
  subtitle: 'Mutual Fund Foundation Certification Examination',
  category: 'nism',
  certification: 'NISM V-B (SEBI & AMFI Mandated)',
  chaptersCount: 1,
  totalTopics: 1,
  totalModules: 1,
  durationHours: 4.0,
  isPopular: true,
  published: true,
  bannerColor: 'from-slate-950 via-teal-950 to-slate-900',
  illustrationType: 'coins',
  description: 'Foundational certification curriculum designed for new mutual fund entrants, postal agents, and branch advisors covering financial planning, risk categories, KYC onboarding, and scheme basics.',
  chapters: NISM_VB_CHAPTERS,
};

// ==========================================
// NISM VIII: Equity Derivatives
// ==========================================
export const NISM_VIII_CHAPTERS: SyllabusChapter[] = [
  {
    id: 'viii-ch-01',
    chapterNumber: 1,
    title: 'Basics of Derivatives & Forward Contracts',
    weightagePercent: 12,
    targetDurationMinutes: 50,
    learningObjectives: [
      'Define derivative instruments and underlying assets (Equities, Indices, Currencies, Commodities)',
      'Contrast OTC forwards with standardized exchange-traded futures',
      'Explain counterparty risk, settlement mechanisms, and novation by Clearing Corporation',
    ],
    topics: [
      {
        id: 'VIII-CH01-T01',
        chapterId: 'viii-ch-01',
        courseCode: 'NISM VIII',
        topicCode: 'T1.1',
        title: 'Derivatives Market Architecture, Cost of Carry & Novation',
        durationMinutes: 28,
        learningObjectives: [
          'Calculate theoretical futures price using Cost of Carry model',
          'Identify cash-and-carry arbitrage opportunities',
        ],
        explanation: {
          what: 'A derivative is a financial contract whose value is derived from an underlying asset. Futures contracts are standardized, exchange-traded agreements where the Clearing Corporation guarantees settlement through legal Novation.',
          why: 'Derivatives enable risk transfer (hedging), price discovery, and capital efficiency through leverage.',
          how: 'Futures price equals Spot price plus Cost of Carry (financing interest minus dividends received). F = S * [1 + r*(d/365)] - Dividend.',
          definitions: [
            { term: 'Novation', definition: 'The legal process whereby the Clearing Corporation interposes itself as buyer to every seller and seller to every buyer.' },
            { term: 'Cost of Carry', definition: 'The net financing cost incurred to hold the underlying physical asset until futures maturity.' },
          ],
          rulesAndRegulations: [
            'SEBI mandates 100% upfront SPAN and Extreme Loss Margins before order placement.',
            'Physical delivery settlement is mandatory for all stock derivatives in India.',
          ],
          formulas: [
            {
              name: 'Futures Fair Value Formula',
              formula: 'F = S + Financing Cost - Dividend = S * [1 + r * (t / 365)] - D',
              workedExample: 'Spot stock = ₹1,000, r = 8%, 90 days, expected dividend = ₹15. F = 1000 * [1 + 0.08 * (90/365)] - 15 = ₹1,004.70.',
            },
          ],
          practicalScenario: 'If actual futures price is ₹1,020 but fair value is ₹1,004.70, an arbitrageur will buy spot stock at ₹1,000 and sell futures at ₹1,020 (Cash and Carry Arbitrage), locking in a risk-free profit.',
          commonMistakes: ['Forgetting to subtract dividends from the cost of carry equation.'],
        },
        instructorScript: 'Cost of carry is the bedrock of futures pricing. If futures trade above fair price, Cash-and-Carry arbitrage forces them back down...',
        slides: [
          {
            slideNumber: 1,
            title: 'Cost of Carry & Futures Arbitrage',
            bulletPoints: [
              'Standardized contract specifications: Lot size, Expiry (last Thursday)',
              'Cost of Carry = Financing cost minus Dividend yield',
              'Clearing Corporation Novation: Zero counterparty credit default',
            ],
            narration: 'Futures prices converge to spot prices on expiry day (Basis becomes zero).',
          },
        ],
        practiceQuestions: [
          {
            id: 'Q-VIII-1-1',
            question: 'What is the primary role of the Clearing Corporation in exchange-traded derivatives contracts?',
            options: [
              'To advise investors on stock selection',
              'To act as legal counterparty to every trade through novation',
              'To fix the closing price of underlying stocks',
              'To manage AMC mutual fund portfolios',
            ],
            correctIndex: 1,
            explanation: 'Through legal novation, the Clearing Corporation becomes the buyer to every seller and seller to every buyer, guaranteeing trade settlement and eliminating counterparty default risk.',
            examTip: 'Novation = Exchange becomes counterparty to both sides.',
          },
        ],
      },
    ],
  },
  {
    id: 'viii-ch-02',
    chapterNumber: 2,
    title: 'Option Payoffs, Greeks & Trading Strategies',
    weightagePercent: 18,
    targetDurationMinutes: 55,
    learningObjectives: [
      'Deconstruct Call and Put option premiums into Intrinsic Value and Time Value',
      'Master the Option Greeks: Delta, Gamma, Theta, Vega, and Rho',
      'Construct Covered Calls, Protective Puts, and Bull Call Spreads',
    ],
    topics: [
      {
        id: 'VIII-CH02-T01',
        chapterId: 'viii-ch-02',
        courseCode: 'NISM VIII',
        topicCode: 'T2.1',
        title: 'Option Greeks (Delta, Theta, Vega) & Multi-Leg Hedging',
        durationMinutes: 32,
        learningObjectives: [
          'Calculate portfolio Delta and Gamma sensitivities',
          'Deploy Covered Call and Protective Put strategies',
        ],
        explanation: {
          what: 'Option Greeks measure option price sensitivities. Delta measures rate of change per rupee move in spot stock. Theta measures daily time decay. Vega measures price change per 1% change in implied volatility.',
          why: 'Professional traders manage risk by hedging Greeks rather than predicting directional market moves.',
          how: 'Call Delta ranges from 0 to +1 (ATM ≈ +0.5). Put Delta ranges from 0 to -1 (ATM ≈ -0.5). Covered Call involves holding long stock and writing an OTM Call option.',
          definitions: [
            { term: 'Delta (Δ)', definition: 'Change in option price per 1-unit change in underlying spot price.' },
            { term: 'Theta (θ)', definition: 'Daily time decay of option premium (erodes buyer value).' },
            { term: 'Vega (ν)', definition: 'Sensitivity of option price to changes in Implied Volatility.' },
          ],
          rulesAndRegulations: [
            'Short option positions require upfront SPAN and Extreme Loss Margins maintained at all times.',
            'Brokers must issue real-time margin alerts when losses breach 70% of initial margin deposit.',
          ],
          formulas: [
            {
              name: 'Option Premium Decomposition',
              formula: 'Option Premium = Intrinsic Value + Time Value',
              workedExample: 'Spot stock = ₹1,550. Strike 1,500 Call trades at ₹75 premium. Intrinsic Value = 1550 - 1500 = ₹50. Time Value = 75 - 50 = ₹25.',
            },
          ],
          practicalScenario: 'An investor holding 500 shares of Reliance at ₹3,000 fears a short-term drop after quarterly earnings. They buy a 2,900 Put option for ₹40. If Reliance crashes to ₹2,600, the put option gains ₹260 in intrinsic value, protecting the portfolio.',
          commonMistakes: ['Thinking an OTM option has negative intrinsic value; intrinsic value can never be less than zero.'],
        },
        instructorScript: 'Remember: Theta is the option buyer’s worst enemy and the option writer’s best friend. Every day the market stays still, Theta puts money into the writer’s pocket.',
        slides: [
          {
            slideNumber: 1,
            title: 'Option Greeks at a Glance',
            bulletPoints: [
              'Delta: Price sensitivity (Call: 0 to +1, Put: -1 to 0)',
              'Theta: Time decay (accelerates rapidly in the final 10 days to expiry)',
              'Vega: Volatility sensitivity (highest for ATM options)',
            ],
            narration: 'Managing Delta and Vega is essential for institutional derivatives risk management.',
          },
        ],
        practiceQuestions: [
          {
            id: 'Q-VIII-2-1',
            question: 'Which option Greek measures the sensitivity of the option price to changes in the implied volatility of the underlying asset?',
            options: ['Delta', 'Gamma', 'Vega', 'Theta'],
            correctIndex: 2,
            explanation: 'Vega measures option price sensitivity per 1% change in implied volatility (IV).',
            examTip: 'Vega = Volatility sensitivity.',
          },
        ],
      },
    ],
  },
];

export const NISM_VIII_COURSE: Course = {
  id: 'nism-viii',
  code: 'NISM VIII',
  title: 'NISM Series VIII',
  subtitle: 'Equity Derivatives Certification Examination',
  category: 'nism',
  certification: 'NISM VIII (SEBI Mandated for Dealers & Advisors)',
  chaptersCount: 2,
  totalTopics: 2,
  totalModules: 2,
  durationHours: 8.0,
  isPopular: true,
  published: true,
  bannerColor: 'from-slate-950 via-cyan-950 to-slate-900',
  illustrationType: 'barchart',
  description: 'Comprehensive curriculum on equity derivatives, index futures and options, Greek sensitivities (Delta, Gamma, Theta, Vega), trading strategies, clearing, settlement and risk management.',
  chapters: NISM_VIII_CHAPTERS,
};

// ==========================================
// NISM X-A: Investment Adviser Level 1
// ==========================================
export const NISM_XA_CHAPTERS: SyllabusChapter[] = [
  {
    id: 'xa-ch-01',
    chapterNumber: 1,
    title: 'Personal Financial Planning & Client Risk Profiling',
    weightagePercent: 15,
    targetDurationMinutes: 50,
    learningObjectives: [
      'Master the 6-step financial planning process according to ISO 22222',
      'Perform cash flow budgeting and emergency reserve calculations',
      'Administer SEBI-mandated suitability and risk tolerance assessments',
    ],
    topics: [
      {
        id: 'XA-CH01-T01',
        chapterId: 'xa-ch-01',
        courseCode: 'NISM X-A',
        topicCode: 'T1.1',
        title: 'Financial Planning Framework, Solvency Ratios & Risk Profiling',
        durationMinutes: 28,
        learningObjectives: ['Calculate Net Worth and Solvency Ratios', 'Structure emergency fund buffers'],
        explanation: {
          what: 'Financial planning is the holistic process of helping clients meet life goals through proper management of finances. It evaluates cash flows, asset allocation, debt, tax planning, and insurance.',
          why: 'SEBI (Investment Advisers) Regulations 2013 strictly mandate that any advice provided to clients must be suitable and backed by documented risk profiling.',
          how: 'Advisers collect quantitative balance sheet data and qualitative risk tolerance preferences, generating a comprehensive Financial Plan with asset allocation targets.',
          definitions: [
            { term: 'Solvency Ratio', definition: 'Total Net Worth divided by Total Assets. Indicates long-term financial cushion against bankruptcy.' },
            { term: 'Emergency Buffer', definition: '3 to 6 months of mandatory household fixed expenses parked in liquid instruments.' },
          ],
          rulesAndRegulations: [
            'RIAs must strictly segregate advisory activities from distribution/execution activities.',
            'Advisory fees are capped at maximum 2.5% of AUM or ₹1,25,000 fixed fee per family per year.',
          ],
          formulas: [
            {
              name: 'Net Worth Equation',
              formula: 'Net Worth = Total Assets - Total Liabilities',
              workedExample: 'Assets (House ₹1Cr + Investments ₹50L) = ₹1.5Cr. Liabilities (Home Loan ₹40L) = ₹40L. Net Worth = ₹1.10 Crores.',
            },
          ],
          practicalScenario: 'A client with ₹2 Lakhs monthly income has EMIs of ₹1.3 Lakhs (65% debt service ratio). An advisor must first recommend debt restructuring and prepayment before allocating funds into volatile equity markets.',
          commonMistakes: ['Recommending equity investments before securing an emergency fund and health insurance.'],
        },
        instructorScript: 'In NISM X-A, the core principle is fiduciary duty. As a Registered Investment Adviser (RIA), you work exclusively for the client, not the product manufacturer...',
        slides: [
          {
            slideNumber: 1,
            title: 'The 6-Step Financial Planning Process',
            bulletPoints: [
              'Step 1: Establishing and defining the client-adviser relationship',
              'Step 2: Gathering client data, goals, and risk preferences',
              'Step 3: Analyzing and evaluating financial status and solvency',
              'Step 4: Developing and presenting recommendations',
              'Step 5: Implementing recommendations',
              'Step 6: Monitoring and reviewing the financial plan annually',
            ],
            narration: 'Advisers must maintain written records of risk evaluations for 5 years.',
          },
        ],
        practiceQuestions: [
          {
            id: 'Q-XA-1-1',
            question: 'Under SEBI (Investment Advisers) Regulations, what is the maximum advisory fee that can be charged under the AUM-based fee model per client family per annum?',
            options: ['1.5% of AUM', '2.0% of AUM', '2.5% of AUM', '5.0% of AUM'],
            correctIndex: 2,
            explanation: 'Under SEBI RIA regulations, the maximum annual fee for the AUM-based model is 2.5% of AUM per family.',
            examTip: 'Fee cap: 2.5% of AUM or ₹1.25 Lakhs fixed per family per annum.',
          },
        ],
      },
    ],
  },
];

export const NISM_XA_COURSE: Course = {
  id: 'nism-x-a',
  code: 'NISM X-A',
  title: 'NISM Series X-A',
  subtitle: 'Investment Adviser (Level 1) Certification Examination',
  category: 'nism',
  certification: 'NISM X-A (SEBI RIA Mandated)',
  chaptersCount: 1,
  totalTopics: 1,
  totalModules: 1,
  durationHours: 6.0,
  isPopular: true,
  published: true,
  bannerColor: 'from-slate-950 via-indigo-950 to-slate-900',
  illustrationType: 'piechart',
  description: 'First-level regulatory certification for Registered Investment Advisers (RIAs) covering financial planning, investor profiling, asset allocation, investment products, and SEBI RIA regulations.',
  chapters: NISM_XA_CHAPTERS,
};

// ==========================================
// NISM X-B: Investment Adviser Level 2
// ==========================================
export const NISM_XB_CHAPTERS: SyllabusChapter[] = [
  {
    id: 'xb-ch-01',
    chapterNumber: 1,
    title: 'Advanced Risk Management, Tax Planning & Estate Planning',
    weightagePercent: 18,
    targetDurationMinutes: 55,
    learningObjectives: [
      'Analyze estate planning vehicles: Wills, Private Family Trusts (Revocable vs Irrevocable)',
      'Calculate Capital Gains tax liabilities with updated indexation changes',
      'Structure retirement drawdown strategies (Systematic Withdrawal Plans & Annuities)',
    ],
    topics: [
      {
        id: 'XB-CH01-T01',
        chapterId: 'xb-ch-01',
        courseCode: 'NISM X-B',
        topicCode: 'T1.1',
        title: 'Estate Planning, Private Trusts & Tax Optimization Strategies',
        durationMinutes: 30,
        learningObjectives: ['Differentiate Revocable vs Irrevocable Trusts', 'Apply updated Capital Gains rules'],
        explanation: {
          what: 'Level 2 advisory focuses on advanced financial architecture: estate preservation, inter-generational wealth transfer via private trusts, complex tax optimization, and post-retirement wealth management.',
          why: 'High-Net-Worth Individuals (HNIs) require sophisticated structures to protect family wealth from commercial claims, family disputes, and tax leakage.',
          how: 'Advisers design Private Discretionary Trusts where assets are held by trustees for designated beneficiaries with clear distribution covenants.',
          definitions: [
            { term: 'Private Discretionary Trust', definition: 'A trust where trustees have discretion over the timing and proportion of distributions to beneficiaries, shielding assets from individual creditor claims.' },
            { term: 'Probate', definition: 'The official certification of a Will granted by a court of competent jurisdiction.' },
          ],
          rulesAndRegulations: [
            'There is currently zero estate duty or inheritance tax in India.',
            'Assets received under a valid Will or by way of inheritance are exempt from income tax in the hands of the recipient.',
          ],
          practicalScenario: 'An aging entrepreneur wants to ensure his special-needs daughter is financially protected for life without interference from extended relatives. An advisor structures an Irrevocable Private Family Trust with institutional co-trustees.',
          commonMistakes: ['Thinking a Will avoids probate automatically; probate is mandatory for Wills executed in presidential towns (Mumbai, Kolkata, Chennai).'],
        },
        instructorScript: 'Welcome to Level 2 Advisory. Here we transition from basic retail budgeting to institutional estate structures, trusts, and case-study numericals...',
        slides: [
          {
            slideNumber: 1,
            title: 'Estate Planning Structures',
            bulletPoints: [
              'Will: Takes effect only after death; revocable during lifetime',
              'Private Family Trust: Takes effect immediately; bankruptcy protection',
              'Power of Attorney: Ceases immediately upon death of principal',
            ],
            narration: 'Proper trust structuring ensures smooth generational wealth handover.',
          },
        ],
        practiceQuestions: [
          {
            id: 'Q-XB-1-1',
            question: 'Under Indian tax laws, what is the tax liability on assets and cash inherited by legal heirs under a valid Will?',
            options: ['Taxed at 12.5% LTCG', 'Taxed at Maximum Marginal Rate (30%)', '100% Exempt from income tax', 'Taxed under gift tax provisions'],
            correctIndex: 2,
            explanation: 'Under Section 56 of the Income Tax Act, assets received under a Will or by way of inheritance are completely exempt from income tax in the hands of the recipient.',
            examTip: 'Inheritance and gifts under a Will = 100% Tax Exempt.',
          },
        ],
      },
    ],
  },
];

export const NISM_XB_COURSE: Course = {
  id: 'nism-x-b',
  code: 'NISM X-B',
  title: 'NISM Series X-B',
  subtitle: 'Investment Adviser (Level 2) Certification Examination',
  category: 'nism',
  certification: 'NISM X-B (SEBI RIA Mandated)',
  chaptersCount: 1,
  totalTopics: 1,
  totalModules: 1,
  durationHours: 6.0,
  isPopular: true,
  published: true,
  bannerColor: 'from-slate-950 via-purple-950 to-slate-900',
  illustrationType: 'piechart',
  description: 'Advanced Level 2 examination for Investment Advisers focusing on case studies, estate planning, private family trusts, comprehensive tax planning, and high-net-worth portfolio management.',
  chapters: NISM_XB_CHAPTERS,
};

// ==========================================
// NISM XV: Research Analyst
// ==========================================
export const NISM_XV_CHAPTERS: SyllabusChapter[] = [
  {
    id: 'xv-ch-01',
    chapterNumber: 1,
    title: 'Macroeconomic Analysis & Regulatory Framework for Research Analysts',
    weightagePercent: 12,
    targetDurationMinutes: 55,
    learningObjectives: [
      'Understand GDP, CPI/WPI Inflation, Fiscal Deficit, and Current Account Deficit (CAD)',
      'Detail the SEBI (Research Analysts) Regulations, 2014 code of conduct',
      'Manage conflicts of interest and personal trading restrictions',
    ],
    topics: [
      {
        id: 'XV-CH01-T01',
        chapterId: 'xv-ch-01',
        courseCode: 'NISM XV',
        topicCode: 'T1.1',
        title: 'SEBI (Research Analysts) Regulations, 2014 & Conflict Management',
        durationMinutes: 30,
        learningObjectives: [
          'Enforce personal trading restrictions (30-day blackout period)',
          'Identify mandatory disclosures required in research reports',
        ],
        explanation: {
          what: 'SEBI (Research Analysts) Regulations, 2014 govern individuals and entities that prepare and publish research reports, offering recommendations or price targets on listed securities.',
          why: 'To prevent front-running, biased research driven by investment banking relationships, and market manipulation.',
          how: 'Research Analysts (RAs) must maintain Chinese walls separating research from merchant banking. Analysts cannot trade against their recommendations within 30 days of report publication.',
          definitions: [
            { term: 'Chinese Wall', definition: 'Physical and operational barrier between research department and investment banking/trading desks.' },
            { term: 'Blackout Period', definition: 'Mandatory 30-day window following publication where the analyst cannot trade in the subject company shares.' },
          ],
          rulesAndRegulations: [
            'RA must disclose financial interests in the subject company held by analyst or relatives.',
            'RA must disclose if they received investment banking compensation in preceding 12 months.',
          ],
          practicalScenario: 'An analyst cannot publish a Strong Buy on a stock and secretly sell their personal shares the following morning.',
          commonMistakes: ['Believing research reports can omit compensation disclosures if under 1% shares.'],
        },
        instructorScript: 'The integrity of capital markets depends entirely on unbiased research...',
        slides: [
          {
            slideNumber: 1,
            title: 'SEBI RA Code of Conduct & Mandatory Disclosures',
            bulletPoints: [
              'Chinese Wall separation between research and deal-making teams',
              '30-day personal trading blackout and 5-day pre-publication trading freeze',
              'Disclosures: 1% or more shareholding, compensation, past business ties',
            ],
            narration: 'Disclosure of conflict of interest is mandatory at the time of report publication.',
          },
        ],
        practiceQuestions: [
          {
            id: 'Q-XV-1-1',
            question: 'Under SEBI (Research Analysts) Regulations, 2014, an analyst cannot trade contrary to their recommendation within how many days of publishing the report?',
            options: ['7 days', '15 days', '30 days', '90 days'],
            correctIndex: 2,
            explanation: 'SEBI mandates a 30-day blackout period following report publication during which the analyst cannot execute personal trades contrary to their published opinion.',
            examTip: '30-day trading freeze following report release.',
          },
        ],
      },
    ],
  },
];

export const NISM_XV_COURSE: Course = {
  id: 'nism-xv',
  code: 'NISM XV',
  title: 'NISM Series XV',
  subtitle: 'Research Analyst Certification Examination',
  category: 'nism',
  certification: 'NISM XV (SEBI Mandated)',
  chaptersCount: 1,
  totalTopics: 1,
  totalModules: 1,
  durationHours: 8.0,
  isPopular: true,
  published: true,
  bannerColor: 'from-slate-950 via-sky-950 to-slate-900',
  illustrationType: 'magnifier',
  description: 'Comprehensive curriculum on fundamental equity research, valuation models (DCF, Relative Valuation, EV/EBITDA), macroeconomic analysis, and SEBI (Research Analysts) Regulations.',
  chapters: NISM_XV_CHAPTERS,
};

// ==========================================
// NISM XXI: Portfolio Managers & AIF
// ==========================================
export const NISM_XXI_CHAPTERS: SyllabusChapter[] = [
  {
    id: 'xxi-ch-01',
    chapterNumber: 1,
    title: 'SEBI Portfolio Managers Regulations & Alternative Investment Funds (AIF)',
    weightagePercent: 20,
    targetDurationMinutes: 60,
    learningObjectives: [
      'Master SEBI (Portfolio Managers) Regulations 2020: Minimum ₹50 Lakh ticket size',
      'Classify AIF Category I, II, and III under SEBI AIF Regulations 2012',
      'Explain Section 115UB tax pass-through status and distribution waterfalls',
    ],
    topics: [
      {
        id: 'XXI-CH01-T01',
        chapterId: 'xxi-ch-01',
        courseCode: 'NISM XXI',
        topicCode: 'T1.1',
        title: 'PMS Minimum Ticket Sizing, AIF Categorization & Waterfall Economics',
        durationMinutes: 32,
        learningObjectives: ['Differentiate PMS Discretionary vs Non-Discretionary', 'Apply Section 115UB pass-through rules'],
        explanation: {
          what: 'Portfolio Management Services (PMS) cater to HNIs with minimum investment of ₹50 Lakhs. Alternative Investment Funds (AIFs) pool private capital with minimum ticket size of ₹1 Crore. Category I and II AIFs enjoy complete statutory tax pass-through under Section 115UB.',
          why: 'PMS and AIFs provide bespoke investment strategies, direct equity ownership, and unconstrained mandates not permissible under retail mutual fund rules.',
          how: 'PMS performance is reported strictly using Time-Weighted Rate of Return (TWRR). AIF distributions follow a strict waterfall: 100% Return of Capital -> Preferred Return (Hurdle Rate) -> GP Catch-Up -> Carried Interest split (80:20).',
          definitions: [
            { term: 'Minimum PMS Ticket', definition: '₹50 Lakhs per client mandated by SEBI Regulations 2020.' },
            { term: 'Minimum AIF Ticket', definition: '₹1 Crore per investor (₹25 Lakhs for employees/directors).' },
            { term: 'Section 115UB Pass-Through', definition: 'Tax provision where Cat I and II AIF income is tax-exempt at fund level and taxed directly in investor hands.' },
          ],
          rulesAndRegulations: [
            'PMS managers cannot promise or guarantee returns to clients.',
            'Discretionary PMS managers are strictly prohibited from borrowing or leveraging client portfolios.',
            'Only Category III AIFs are permitted to employ leverage for investment returns.',
          ],
          formulas: [
            {
              name: 'Carried Interest Formula',
              formula: 'Carried Interest = 20% * (Total Net Profit - Hurdle Return)',
              workedExample: 'AIF generates ₹100 Cr profit above ₹40 Cr hurdle. GP Carried Interest = 20% * 60 Cr = ₹12 Crores.',
            },
          ],
          practicalScenario: 'An HNI client with ₹2 Crores liquid capital wants a concentrated 15-stock high-conviction portfolio. Since retail mutual funds have 10% stock caps, the advisor places them in a Discretionary PMS with a ₹50 Lakh+ mandate.',
          commonMistakes: ['Thinking Category II AIFs can use derivative leverage; only Category III AIFs can borrow or leverage.'],
        },
        instructorScript: 'Welcome to NISM XXI Portfolio Managers course. This is the apex certification for wealth managers handling HNI, UHNI, and family office mandates...',
        slides: [
          {
            slideNumber: 1,
            title: 'PMS & AIF Regulatory Comparison',
            bulletPoints: [
              'PMS Minimum Ticket: ₹50 Lakhs | AIF Minimum Ticket: ₹1 Crore',
              'Performance Reporting: Mandatorily Time-Weighted Rate of Return (TWRR)',
              'Taxation: PMS taxed directly in client demat; Cat I & II AIFs have Sec 115UB pass-through',
            ],
            narration: 'TWRR eliminates cash flow timing distortions from performance measurement.',
          },
        ],
        practiceQuestions: [
          {
            id: 'Q-XXI-1-1',
            question: 'What is the statutory minimum investment amount required from an investor to subscribe to a Portfolio Management Service (PMS) in India?',
            options: ['₹10 Lakhs', '₹25 Lakhs', '₹50 Lakhs', '₹1 Crore'],
            correctIndex: 2,
            explanation: 'Under SEBI (Portfolio Managers) Regulations 2020, the statutory minimum investment threshold per client is ₹50 Lakhs.',
            examTip: 'PMS = ₹50 Lakhs; AIF = ₹1 Crore.',
          },
        ],
      },
    ],
  },
];

export const NISM_XXI_COURSE: Course = {
  id: 'nism-xxi',
  code: 'NISM XXI',
  title: 'NISM Series XXI',
  subtitle: 'Portfolio Managers & Alternative Investment Funds Certification',
  category: 'nism',
  certification: 'NISM XXI (SEBI Mandated for PMS Managers)',
  chaptersCount: 1,
  totalTopics: 1,
  totalModules: 1,
  durationHours: 8.0,
  isPopular: true,
  published: true,
  bannerColor: 'from-slate-950 via-emerald-950 to-slate-900',
  illustrationType: 'barchart',
  description: 'The premier certification for portfolio managers, PMS relationship leads, and AIF professionals covering PMS regulations, TWRR attribution, AIF categorization, waterfall economics, and Section 115UB tax pass-through.',
  chapters: NISM_XXI_CHAPTERS,
};

export const ALL_NISM_COURSES: Course[] = [
  NISM_VB_COURSE,
  NISM_VIII_COURSE,
  NISM_XA_COURSE,
  NISM_XB_COURSE,
  NISM_XV_COURSE,
  NISM_XXI_COURSE,
];
