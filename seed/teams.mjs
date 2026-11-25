// Default course access per team (course ids from seed/catalog.mjs). These are STARTING defaults, applied once per
// TEAM_ACCESS_VERSION; afterwards administrators change them under Admin Portal -> Team access.
// Training & Quality is not listed: that team always has access to every course.
//
// Intent of each team:
//   Customer Support    - resolve customer issues; NO sales content
//   MF / Equity Onboarding - onboard new clients and get the first investment
//   MF Digital/Silver/Gold/Platinum, Equity Regular - develop onboarded clients, review portfolios, bring additional investment
export const TEAM_ACCESS_VERSION = 2;

// Process-document courses every team can open.
export const PROCESS_COURSES = ['process-mf-support', 'process-equity-support'];

export const COMMON = ['fi-academy', 'compliance', 'markets-basics'];

const SALES = ['call-excellence', 'objection-handling'];
const TOOLS = ['zoho-crm', 'tata-tele'];

export const TEAM_ACCESS = {
  'MF Onboarding': ['product-school', 'nism-5a', 'nism-5b', ...TOOLS, ...SALES],
  'Equity Onboarding': ['nism-7', 'nism-12', ...TOOLS, ...SALES],
  'MF Digital': ['product-school', 'nism-5a', 'nism-5b', 'nism-5d', ...TOOLS, ...SALES],
  'MF Silver': ['product-school', 'nism-5a', 'nism-5b', ...TOOLS, ...SALES],
  'MF Gold': ['product-school', 'nism-5a', 'nism-5d', 'nism-10a', ...TOOLS, ...SALES],
  'MF Platinum': ['product-school', 'nism-5a', 'nism-5d', 'nism-10a', 'nism-10b', 'nism-21a', ...TOOLS, ...SALES],
  'Equity Regular': ['nism-7', 'nism-8', 'nism-12', 'nism-13', 'nism-15', 'nism-16', ...TOOLS, ...SALES],
  // Support work only: service workflows, call handling and the CRM / dialer. Product pitches and objection handling are sales content.
  'Customer Support': ['nism-5b', 'customer-support', 'call-excellence', ...TOOLS],
};
