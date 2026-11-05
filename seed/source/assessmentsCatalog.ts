import { Assessment, AssessmentQuestion } from '../../types';

// ==========================================
// CORE QUESTION POOLS FOR UNLIMITED GENERATION
// ==========================================

export const NISM_VA_QUESTIONS: AssessmentQuestion[] = [
  {
    id: 'va-q1',
    question: 'Under SEBI Mutual Fund Regulations 1996, in what legal form is a Mutual Fund required to be established in India?',
    options: [
      'As a Public Limited Company under the Companies Act',
      'As a Trust under the Indian Trusts Act, 1882',
      'As a Limited Liability Partnership (LLP)',
      'As a statutory board of the Reserve Bank of India',
    ],
    correctAnswer: 1,
    explanation: 'Mutual funds in India are constitutionally organized as Trusts under the Indian Trusts Act, 1882. The Sponsor creates the Trust, the Trustees hold the assets for unit-holders, and the AMC manages investments.',
    topicCode: 'VA-CH01',
  },
  {
    id: 'va-q2',
    question: 'What is the applicable SEBI cut-off timing for application and realization of funds in Liquid and Overnight funds to receive historical or same-day NAV?',
    options: [
      '3:00 PM application with same-day clearing',
      '1:30 PM application with funds realized in AMC account before 1:30 PM',
      '2:00 PM application irrespective of fund realization',
      '11:00 AM application without fund transfer proof',
    ],
    correctAnswer: 1,
    explanation: 'For Liquid and Overnight Funds, the cut-off timing is 1:30 PM, subject to the rule that funds must be available in the AMC bank account before 1:30 PM to receive that day\'s historical or closing NAV.',
    topicCode: 'VA-CH02',
  },
  {
    id: 'va-q3',
    question: 'How is the Net Asset Value (NAV) of a mutual fund scheme mathematically calculated per unit?',
    options: [
      'Total Assets / Total Number of Units',
      '(Market Value of Investments + Receivables + Accrued Income - Liabilities - Accrued Expenses) / Number of Outstanding Units',
      '(Market Value of Equity - Total Debt) / Face Value of Scheme',
      '(Gross Inflows - Redemptions) / Number of Investors',
    ],
    correctAnswer: 1,
    explanation: 'NAV per unit = (Market or Fair Value of Scheme Investments + Receivables + Other Assets + Accrued Income - Liabilities - Accrued Expenses) / Number of Outstanding Units.',
    topicCode: 'VA-CH03',
  },
  {
    id: 'va-q4',
    question: 'What is the minimum percentage of scheme corpus that an Equity Linked Savings Scheme (ELSS) must invest in equity and equity-related instruments as per SEBI categorization?',
    options: ['50%', '65%', '80%', '90%'],
    correctAnswer: 2,
    explanation: 'Under SEBI\'s scheme categorization circular, an ELSS scheme must invest at least 80% of its total assets in equities and equity-related securities, with a mandatory 3-year statutory lock-in period.',
    topicCode: 'VA-CH04',
  },
  {
    id: 'va-q5',
    question: 'Which body is responsible for issuing AMFI Registration Numbers (ARN) and enforcing the Code of Conduct for mutual fund distributors in India?',
    options: [
      'Securities and Exchange Board of India (SEBI)',
      'Association of Mutual Funds in India (AMFI)',
      'Reserve Bank of India (RBI)',
      'Insurance Regulatory and Development Authority (IRDAI)',
    ],
    correctAnswer: 1,
    explanation: 'AMFI (Association of Mutual Funds in India) registers distributors, issues the ARN card, and monitors distributor compliance with the mutual fund Code of Conduct.',
    topicCode: 'VA-CH05',
  },
  {
    id: 'va-q6',
    question: 'What is the maximum base Total Expense Ratio (TER) permissible for an open-ended equity-oriented scheme for the first ₹500 Crores of daily net assets under SEBI slabs?',
    options: ['2.50%', '2.25%', '2.00%', '1.75%'],
    correctAnswer: 1,
    explanation: 'Under SEBI regulations, the maximum base TER for the first ₹500 Crores of daily net assets in an open-ended equity scheme is 2.25%. Slabs decrease as AUM increases.',
    topicCode: 'VA-CH06',
  },
  {
    id: 'va-q7',
    question: 'Under the Finance Act, what is the Long-Term Capital Gains (LTCG) tax rate on equity mutual funds held for over 12 months, for gains exceeding ₹1.25 Lakhs per financial year?',
    options: [
      '10% with indexation benefits',
      '12.5% without indexation benefits',
      '15% without indexation benefits',
      '20% with indexation benefits',
    ],
    correctAnswer: 1,
    explanation: 'Under the revised tax provisions, LTCG on listed equity and equity mutual funds held for more than 12 months is taxed at 12.5% on capital gains exceeding ₹1.25 Lakhs in a financial year without indexation.',
    topicCode: 'VA-CH07',
  },
  {
    id: 'va-q8',
    question: 'What is the minimum lock-in period applicable to an Equity Linked Savings Scheme (ELSS) investment from the date of allotment?',
    options: ['1 Year', '3 Years', '5 Years', 'Until age 60'],
    correctAnswer: 1,
    explanation: 'ELSS has a statutory lock-in of exactly 3 years from each investment date (for SIP, each individual installment has its own 3-year lock-in).',
    topicCode: 'VA-CH08',
  },
  {
    id: 'va-q9',
    question: 'Which of the following bodies holds the securities of a mutual fund scheme in safe custody, completely independent of the AMC?',
    options: ['Sponsor Company', 'Custodian', 'Registrar and Transfer Agent (RTA)', 'Auditor'],
    correctAnswer: 1,
    explanation: 'The Custodian is a SEBI-registered independent entity that holds fund securities in custody and settles transactions, ensuring complete segregation from AMC management.',
    topicCode: 'VA-CH09',
  },
  {
    id: 'va-q10',
    question: 'When a fund manager out-performs the benchmark return after adjusting for beta risk, what is the excess return termed as?',
    options: ['Treynor Ratio', 'Jensen\'s Alpha', 'Tracking Error', 'Standard Deviation'],
    correctAnswer: 1,
    explanation: 'Jensen\'s Alpha measures the abnormal return of an investment over the theoretical expected return predicted by the Capital Asset Pricing Model (CAPM).',
    topicCode: 'VA-CH10',
  },
];

export const NISM_VB_QUESTIONS: AssessmentQuestion[] = [
  {
    id: 'vb-q1',
    question: 'What is the primary difference between investing in bank fixed deposits and investing in mutual funds?',
    options: [
      'Bank FDs offer guaranteed interest but mutual fund returns depend on market performance of underlying securities',
      'Mutual funds guarantee higher returns than fixed deposits at all times',
      'Bank FDs have mandatory 3-year lock-in periods',
      'Mutual funds are only open to institutional investors',
    ],
    correctAnswer: 0,
    explanation: 'Bank fixed deposits provide contracted interest rates backed by DICGC insurance up to ₹5 Lakhs, whereas mutual fund returns fluctuate with market prices of underlying portfolio securities.',
  },
  {
    id: 'vb-q2',
    question: 'Using the Rule of 72, approximately how many years will it take for an investment to double at a compounding annual return of 8%?',
    options: ['6 years', '9 years', '12 years', '15 years'],
    correctAnswer: 1,
    explanation: '72 / 8 = 9 years.',
  },
  {
    id: 'vb-q3',
    question: 'What does a Systematic Investment Plan (SIP) enable an investor to do?',
    options: [
      'Borrow money from the AMC to buy shares on margin',
      'Invest a fixed sum of money at regular intervals into a mutual fund scheme',
      'Withdraw money without paying taxes',
      'Lock in guaranteed daily returns',
    ],
    correctAnswer: 1,
    explanation: 'A SIP allows an investor to invest a predetermined fixed amount at regular frequencies (monthly, quarterly), inculcating disciplined investing and benefiting from Rupee Cost Averaging.',
  },
  {
    id: 'vb-q4',
    question: 'Which document must an investor complete to satisfy SEBI Anti-Money Laundering (AML) regulations before investing?',
    options: ['PAN allotment form', 'Know Your Customer (KYC) documentation', 'Income tax return Form 16', 'Bank loan sanction letter'],
    correctAnswer: 1,
    explanation: 'KYC (Know Your Customer) compliance is mandatory for all capital market investments under SEBI regulations and PMLA rules.',
  },
  {
    id: 'vb-q5',
    question: 'What happens to the unit allocation when an investor continues an equity SIP during a severe market downturn?',
    options: [
      'They get fewer units because NAV is lower',
      'They get MORE units for the same fixed investment because NAV has dropped',
      'The SIP is automatically paused by SEBI',
      'All previous units are converted to cash',
    ],
    correctAnswer: 1,
    explanation: 'This is Rupee Cost Averaging: When market falls and NAV is low, a fixed monthly SIP allocation purchases a higher quantity of mutual fund units.',
  },
];

export const NISM_VIII_QUESTIONS: AssessmentQuestion[] = [
  {
    id: 'viii-q1',
    question: 'According to the Cost-of-Carry model for pricing index futures, what does the fair futures price equal?',
    options: [
      'Spot Price - Carry Costs + Dividends',
      'Spot Price + Cost of Financing - Dividend Yield',
      'Strike Price + Option Premium - Margin Interest',
      'Spot Price / Risk-Free Interest Rate',
    ],
    correctAnswer: 1,
    explanation: 'Fair Futures Price = Spot Price + Cost of Carry - Inflows (Dividends) = S * [1 + r*(t/365)] - D.',
  },
  {
    id: 'viii-q2',
    question: 'Which option Greek measures the rate of change of Delta with respect to a change in the price of the underlying asset?',
    options: ['Theta', 'Vega', 'Gamma', 'Rho'],
    correctAnswer: 2,
    explanation: 'Gamma represents the first derivative of Delta with respect to the underlying spot price. It measures the curvature or convexity of the option price.',
  },
  {
    id: 'viii-q3',
    question: 'What is the maximum potential loss for an investor who buys an Out-of-the-Money (OTM) European Call option?',
    options: [
      'Unlimited down to zero',
      'Limited strictly to the initial premium paid',
      'The strike price minus spot price',
      'The SPAN margin deposited with clearing member',
    ],
    correctAnswer: 1,
    explanation: 'For a call option buyer, downside risk is strictly limited to the premium paid to enter the contract, while upside gain is theoretically unlimited.',
  },
  {
    id: 'viii-q4',
    question: 'In Indian exchange-traded derivatives, which real-time margining system is mandated by SEBI for calculating portfolio risk?',
    options: [
      'Value at Risk (VaR) single-stock static margin',
      'Standard Portfolio Analysis of Risk (SPAN) margin',
      'Simple Cash Margin 10%',
      'Mark-to-Market overnight margin only',
    ],
    correctAnswer: 1,
    explanation: 'SPAN (Standard Portfolio Analysis of Risk) margin evaluates overall portfolio risk across multiple price and volatility scan scenarios on a real-time intraday basis.',
  },
  {
    id: 'viii-q5',
    question: 'When an equity market moves into "Backwardation", what is the relationship between futures price and spot price?',
    options: [
      'Futures price trades at a discount below spot price',
      'Futures price trades at a significant premium above spot price',
      'Futures price and spot price are exactly equal at all times',
      'Option premiums become zero',
    ],
    correctAnswer: 0,
    explanation: 'Backwardation occurs when the futures contract trades at a lower price than the spot price, often due to high expected dividend payouts or strong bearish sentiment.',
  },
  {
    id: 'viii-q6',
    question: 'Which options strategy involves buying an At-the-Money (ATM) call and an At-the-Money (ATM) put with the same strike price and expiration date?',
    options: ['Bull Call Spread', 'Long Straddle', 'Iron Condor', 'Covered Call'],
    correctAnswer: 1,
    explanation: 'A Long Straddle consists of buying a call and a put at the same strike and expiration, profiting from large price movements in either direction (high volatility).',
  },
];

export const NISM_XA_QUESTIONS: AssessmentQuestion[] = [
  {
    id: 'xa-q1',
    question: 'Under SEBI (Investment Advisers) Regulations, what is the maximum advisory fee that can be charged under the AUM-based fee model per client family per annum?',
    options: ['1.5% of AUM', '2.0% of AUM', '2.5% of AUM', '5.0% of AUM'],
    correctAnswer: 2,
    explanation: 'Under SEBI RIA regulations, the maximum annual fee for the AUM-based model is 2.5% of AUM per family, or ₹1,25,000 under the fixed fee model.',
  },
  {
    id: 'xa-q2',
    question: 'What is the standard recommended emergency fund size for a salaried individual with stable employment?',
    options: ['1 month of discretionary expenses', '3 to 6 months of mandatory household fixed expenses', '2 years of total salary', '10% of equity portfolio'],
    correctAnswer: 1,
    explanation: 'Financial planning standards dictate an emergency liquidity buffer of 3 to 6 months of mandatory household fixed expenses (rent, EMIs, utilities, groceries) in liquid instruments.',
  },
  {
    id: 'xa-q3',
    question: 'Under Capital Asset Pricing Model (CAPM), what does Beta (β) measure?',
    options: [
      'The company-specific unsystematic risk',
      'The sensitivity of an asset’s returns relative to the overall market portfolio (systematic risk)',
      'The dividend payout ratio',
      'The total debt-to-equity ratio',
    ],
    correctAnswer: 1,
    explanation: 'Beta measures systematic risk: the sensitivity of a stock or portfolio\'s returns relative to movements in the broad market index.',
  },
  {
    id: 'xa-q4',
    question: 'Which ratio measures an individual\'s total debt servicing obligations as a percentage of their net monthly take-home income?',
    options: ['Solvency Ratio', 'Debt-to-Income / Debt Servicing Ratio', 'Liquidity Ratio', 'Savings Ratio'],
    correctAnswer: 1,
    explanation: 'The Debt-to-Income (DTI) or Debt Servicing Ratio divides total monthly debt payments by gross/net monthly income; ideally it should not exceed 40-45%.',
  },
  {
    id: 'xa-q5',
    question: 'Can a SEBI Registered Investment Adviser (RIA) receive distribution commissions from mutual fund AMCs for products recommended to their advisory clients?',
    options: [
      'Yes, up to 1% trail commission is allowed',
      'No, SEBI RIA regulations strictly prohibit receiving commissions or fees from product manufacturers for advisory clients',
      'Yes, provided it is disclosed in writing',
      'Only for direct equity stocks',
    ],
    correctAnswer: 1,
    explanation: 'SEBI strictly mandates client-level segregation: An RIA cannot receive any distribution commission or fee from AMCs/issuers for products recommended to an advisory client.',
  },
];

export const NISM_XB_QUESTIONS: AssessmentQuestion[] = [
  {
    id: 'xb-q1',
    question: 'Under Indian tax laws, what is the tax liability on cash or assets inherited by legal heirs under a valid Will?',
    options: ['Taxed at 12.5% LTCG', 'Taxed at Maximum Marginal Rate (30%)', '100% Exempt from income tax', 'Subject to mandatory probate stamp duty of 15%'],
    correctAnswer: 2,
    explanation: 'Under Section 56 of the Income Tax Act, assets or cash received under a valid Will or by way of inheritance are completely exempt from income tax in India.',
  },
  {
    id: 'xb-q2',
    question: 'What is the primary advantage of establishing an Irrevocable Private Family Trust for estate planning?',
    options: [
      'It avoids capital gains taxes forever',
      'It provides asset protection against future commercial bankruptcy or creditor claims on beneficiaries',
      'It eliminates the need for PAN cards',
      'It guarantees 15% returns on trust assets',
    ],
    correctAnswer: 1,
    explanation: 'In an Irrevocable Trust, the settlor permanently relinquishes control over assets, transferring them to the trust which shields them from personal creditor attachment or marital divorce claims.',
  },
  {
    id: 'xb-q3',
    question: 'How is Modified Duration (MD) mathematically calculated from Macaulay Duration?',
    options: [
      'MD = Macaulay Duration * (1 + YTM)',
      'MD = Macaulay Duration / (1 + YTM / m)',
      'MD = Macaulay Duration - Coupon Rate',
      'MD = Macaulay Duration / Face Value',
    ],
    correctAnswer: 1,
    explanation: 'Modified Duration = Macaulay Duration / (1 + y/m), where y is yield to maturity and m is coupon frequency per year. It measures the percentage price volatility of a bond per 1% yield change.',
  },
  {
    id: 'xb-q4',
    question: 'What is the minimum net worth requirement mandated by SEBI for a corporate entity seeking registration as an Investment Adviser (RIA)?',
    options: ['₹10 Lakhs', '₹25 Lakhs', '₹50 Lakhs', '₹1 Crore'],
    correctAnswer: 2,
    explanation: 'Under SEBI RIA regulations, body corporate investment advisers must maintain a minimum net worth of ₹50 Lakhs at all times (individual RIAs require ₹5 Lakhs).',
  },
  {
    id: 'xb-q5',
    question: 'In retirement planning, what does the "Safe Withdrawal Rate" (SWR) concept represent?',
    options: [
      'The maximum loan an investor can take against their pension',
      'The percentage of the initial retirement portfolio that can be withdrawn annually (adjusted for inflation) with minimal probability of outliving the money',
      'The minimum dividend yield of an equity fund',
      'The tax-free limit on gratuity',
    ],
    correctAnswer: 1,
    explanation: 'The Safe Withdrawal Rate (popularized by the Trinity Study, typically ~4%) is the annual percentage a retiree can withdraw without depleting their retirement corpus over a 30-year horizon.',
  },
];

export const NISM_XV_QUESTIONS: AssessmentQuestion[] = [
  {
    id: 'xv-q1',
    question: 'Under SEBI (Research Analysts) Regulations 2014, what is the mandatory holding restriction on research analysts regarding securities they recommend?',
    options: [
      'They cannot trade in that security for 30 days before and 5 days after issuing the research report',
      'They cannot trade contrary to their recommendation for 30 days after publishing the research report',
      'They can trade anytime provided they notify their compliance officer within 48 hours',
      'There are no restrictions on personal trading',
    ],
    correctAnswer: 1,
    explanation: 'SEBI mandates a 30-day blackout period following report publication during which the analyst cannot execute personal trades contrary to their published recommendation.',
  },
  {
    id: 'xv-q2',
    question: 'In Discounted Cash Flow (DCF) valuation, Free Cash Flow to Firm (FCFF) should be discounted at which rate of return?',
    options: [
      'Cost of Equity (Ke) calculated using CAPM',
      'Weighted Average Cost of Capital (WACC)',
      'Pre-tax Cost of Debt (Kd)',
      'Risk-Free Rate of Government Securities',
    ],
    correctAnswer: 1,
    explanation: 'Because FCFF represents cash flows available to both equity and debt providers, it must be discounted using the Weighted Average Cost of Capital (WACC).',
  },
  {
    id: 'xv-q3',
    question: 'What is the formula for calculating Enterprise Value (EV)?',
    options: [
      'Market Capitalization + Total Debt - Cash and Cash Equivalents',
      'Total Assets - Total Liabilities',
      'EBITDA * Price to Earnings Ratio',
      'Net Profit * Shareholder Equity',
    ],
    correctAnswer: 0,
    explanation: 'Enterprise Value = Market Capitalization + Total Debt + Minority Interest + Preferred Shares - Total Cash and Cash Equivalents.',
  },
  {
    id: 'xv-q4',
    question: 'Which financial ratio best measures a company\'s ability to service its debt obligations from operational earnings before depreciation and amortization?',
    options: [
      'Current Ratio',
      'Interest Coverage Ratio (EBITDA / Interest Expense)',
      'Price to Book Value (P/B)',
      'Asset Turnover Ratio',
    ],
    correctAnswer: 1,
    explanation: 'The Interest Coverage Ratio (EBITDA / Interest) measures how many times the company can pay its current interest obligations with its operating earnings.',
  },
  {
    id: 'xv-q5',
    question: 'What does the Beneish M-Score calculate in forensic accounting analysis?',
    options: [
      'Default probability within 12 months',
      'The likelihood that a company is manipulating its financial earnings',
      'Optimal capital structure leverage',
      'Terminal growth rate in perpetual DCF',
    ],
    correctAnswer: 1,
    explanation: 'The Beneish M-Score uses 8 financial ratios to identify whether a company has manipulated or falsified its reported accounting earnings.',
  },
];

export const NISM_XXI_QUESTIONS: AssessmentQuestion[] = [
  {
    id: 'xxi-q1',
    question: 'What is the minimum statutory ticket size mandated by SEBI for an individual investor to open a Portfolio Management Services (PMS) account in India?',
    options: ['₹10 Lakhs', '₹25 Lakhs', '₹50 Lakhs', '₹1 Crore'],
    correctAnswer: 2,
    explanation: 'SEBI revised the minimum investment threshold for PMS clients to ₹50 Lakhs to ensure that only qualified high-net-worth investors participate in PMS offerings.',
  },
  {
    id: 'xxi-q2',
    question: 'In PMS performance fee calculations, what is the significance of the "High-Water Mark" principle?',
    options: [
      'It guarantees a minimum annual return to the investor',
      'The Portfolio Manager cannot charge a performance incentive fee unless previous portfolio losses have been fully recouped',
      'It caps the maximum fee a manager can earn in bull markets',
      'It requires client funds to be held in offshore escrow accounts',
    ],
    correctAnswer: 1,
    explanation: 'The High-Water Mark ensures that the manager is only rewarded on new net profits; if the portfolio declines, the manager receives zero performance incentive until NAV exceeds the previous peak.',
  },
  {
    id: 'xxi-q3',
    question: 'Under Section 115UB of the Income Tax Act, which categories of Alternative Investment Funds (AIF) are granted statutory tax pass-through status?',
    options: [
      'Category III AIFs only',
      'Category I and Category II AIFs',
      'All AIF categories including Category III',
      'None; all AIFs are taxed at maximum marginal rate',
    ],
    correctAnswer: 1,
    explanation: 'Under Section 115UB of the Income Tax Act, Category I and Category II AIFs have complete tax pass-through status (taxed in investor hands). Category III AIFs are taxed at fund level.',
  },
  {
    id: 'xxi-q4',
    question: 'Under SEBI rules, can a Discretionary Portfolio Manager borrow funds or leverage the client\'s portfolio to enhance equity returns?',
    options: [
      'Yes, up to 2x leverage is permitted',
      'Yes, provided the client signs a risk disclosure',
      'No, SEBI PMS Regulations strictly prohibit portfolio managers from borrowing on behalf of the client',
      'Only for buying index futures contracts',
    ],
    correctAnswer: 2,
    explanation: 'Under SEBI (Portfolio Managers) Regulations, portfolio managers are strictly forbidden from leveraging the portfolio or borrowing funds on behalf of clients.',
  },
  {
    id: 'xxi-q5',
    question: 'Which performance attribution metric evaluates the excess return generated by active security selection vs benchmark sector allocation?',
    options: [
      'Brinson-Fachler Attribution Model',
      'Sharpe Ratio single index',
      'Treynor Measure beta coefficient',
      'Modigliani-Modigliani (M2) risk-adjusted score',
    ],
    correctAnswer: 0,
    explanation: 'The Brinson-Fachler framework separates excess portfolio returns into asset allocation effect, selection effect (stock-picking alpha), and interaction effect.',
  },
];

// ==========================================
// UNLIMITED RANDOMIZED MOCK EXAM GENERATOR
// ==========================================

export function generateDynamicMockExam(
  courseCode: string,
  targetQuestionCount: number = 10
): Assessment {
  let pool: AssessmentQuestion[] = [];
  let duration = 120;
  let passPercent = 50;
  let negMarking = 0;
  let title = `${courseCode} Dynamic Mock Examination`;

  switch (courseCode) {
    case 'NISM V-A':
      pool = NISM_VA_QUESTIONS;
      duration = 120;
      passPercent = 50;
      negMarking = 0;
      title = 'NISM Series V-A: Mutual Fund Distributors Unlimited Mock Exam';
      break;
    case 'NISM V-B':
      pool = NISM_VB_QUESTIONS;
      duration = 120;
      passPercent = 50;
      negMarking = 0;
      title = 'NISM Series V-B: Mutual Fund Foundation Unlimited Mock Exam';
      break;
    case 'NISM VIII':
      pool = NISM_VIII_QUESTIONS;
      duration = 120;
      passPercent = 60;
      negMarking = 25;
      title = 'NISM Series VIII: Equity Derivatives Unlimited Mock Exam';
      break;
    case 'NISM X-A':
      pool = NISM_XA_QUESTIONS;
      duration = 120;
      passPercent = 60;
      negMarking = 25;
      title = 'NISM Series X-A: Investment Adviser (Level 1) Unlimited Mock Exam';
      break;
    case 'NISM X-B':
      pool = NISM_XB_QUESTIONS;
      duration = 120;
      passPercent = 60;
      negMarking = 25;
      title = 'NISM Series X-B: Investment Adviser (Level 2) Unlimited Mock Exam';
      break;
    case 'NISM XV':
      pool = NISM_XV_QUESTIONS;
      duration = 120;
      passPercent = 60;
      negMarking = 25;
      title = 'NISM Series XV: Research Analyst Unlimited Mock Exam';
      break;
    case 'NISM XXI':
      pool = NISM_XXI_QUESTIONS;
      duration = 120;
      passPercent = 60;
      negMarking = 25;
      title = 'NISM Series XXI: Portfolio Managers & AIF Unlimited Mock Exam';
      break;
    default:
      pool = NISM_VA_QUESTIONS;
      break;
  }

  // Shuffle pool to generate a fresh randomized exam attempt every single time
  const shuffled = [...pool].sort(() => 0.5 - Math.random());
  const selectedQuestions = shuffled.slice(0, Math.min(targetQuestionCount, shuffled.length));

  return {
    id: `dynamic-${courseCode.toLowerCase().replace(/[^a-z0-9]/g, '-')}-${Date.now()}`,
    courseCode,
    title,
    description: `Dynamic, unlimited mock test dynamically generated from FundsIndia's accredited ${courseCode} item bank. Features real-time countdown, negative marking calculations, and automated certificate generation upon passing.`,
    category: 'nism',
    durationMinutes: duration,
    totalQuestions: selectedQuestions.length,
    passPercentage: passPercent,
    negativeMarkingPercent: negMarking,
    questions: selectedQuestions,
    published: true,
  };
}

// Published Static Catalogs for standard UI listing
export const ASSESSMENTS_CATALOG: Assessment[] = [
  {
    id: 'assess-nism-va-mock',
    courseCode: 'NISM V-A',
    title: 'NISM Series V-A: Mutual Fund Distributors Comprehensive Mock Examination',
    description: 'Realistic exam simulation mirroring the National Institute of Securities Markets (NISM) Series V-A certification. Tests legal structure, NAV computation, cut-off timings, code of conduct, and investor suitability.',
    category: 'nism',
    durationMinutes: 120,
    totalQuestions: NISM_VA_QUESTIONS.length,
    passPercentage: 50,
    negativeMarkingPercent: 0,
    published: true,
    questions: NISM_VA_QUESTIONS,
  },
  {
    id: 'assess-nism-vb-mock',
    courseCode: 'NISM V-B',
    title: 'NISM Series V-B: Mutual Fund Foundation Certification Assessment',
    description: 'Foundation exam covering basic financial planning, compounding concepts, mutual fund structures, risk profiling, and investor KYC compliance.',
    category: 'nism',
    durationMinutes: 120,
    totalQuestions: NISM_VB_QUESTIONS.length,
    passPercentage: 50,
    negativeMarkingPercent: 0,
    published: true,
    questions: NISM_VB_QUESTIONS,
  },
  {
    id: 'assess-nism-viii-mock',
    courseCode: 'NISM VIII',
    title: 'NISM Series VIII: Equity Derivatives Certification Assessment',
    description: 'Comprehensive test of derivatives pricing, Black-Scholes Greeks, index futures hedging, option payoffs, and regulatory margins.',
    category: 'nism',
    durationMinutes: 120,
    totalQuestions: NISM_VIII_QUESTIONS.length,
    passPercentage: 60,
    negativeMarkingPercent: 25,
    published: true,
    questions: NISM_VIII_QUESTIONS,
  },
  {
    id: 'assess-nism-xa-mock',
    courseCode: 'NISM X-A',
    title: 'NISM Series X-A: Investment Adviser (Level 1) Assessment',
    description: 'Level 1 RIA certification testing personal financial planning, client risk profiling, asset allocation, investment products, and SEBI RIA regulations.',
    category: 'nism',
    durationMinutes: 120,
    totalQuestions: NISM_XA_QUESTIONS.length,
    passPercentage: 60,
    negativeMarkingPercent: 25,
    published: true,
    questions: NISM_XA_QUESTIONS,
  },
  {
    id: 'assess-nism-xb-mock',
    courseCode: 'NISM X-B',
    title: 'NISM Series X-B: Investment Adviser (Level 2) Assessment',
    description: 'Level 2 case-study exam on private family trusts, estate planning, complex tax optimization, and high-net-worth portfolio management.',
    category: 'nism',
    durationMinutes: 120,
    totalQuestions: NISM_XB_QUESTIONS.length,
    passPercentage: 60,
    negativeMarkingPercent: 25,
    published: true,
    questions: NISM_XB_QUESTIONS,
  },
  {
    id: 'assess-nism-xv-mock',
    courseCode: 'NISM XV',
    title: 'NISM Series XV: Research Analyst Certification Assessment',
    description: 'Valuation methodologies, DCF modeling, financial statement forensic analysis, SEBI Research Analyst Regulations 2014, and ethics.',
    category: 'nism',
    durationMinutes: 120,
    totalQuestions: NISM_XV_QUESTIONS.length,
    passPercentage: 60,
    negativeMarkingPercent: 25,
    published: true,
    questions: NISM_XV_QUESTIONS,
  },
  {
    id: 'assess-nism-xxi-mock',
    courseCode: 'NISM XXI',
    title: 'NISM Series XXI: Portfolio Managers & Alternative Investment Funds (AIF) Assessment',
    description: 'SEBI PMS Regulations, discretionary vs non-discretionary mandates, high-net-worth client profiling, watermarks, and hurdle rates.',
    category: 'nism',
    durationMinutes: 120,
    totalQuestions: NISM_XXI_QUESTIONS.length,
    passPercentage: 60,
    negativeMarkingPercent: 25,
    published: true,
    questions: NISM_XXI_QUESTIONS,
  },
];
