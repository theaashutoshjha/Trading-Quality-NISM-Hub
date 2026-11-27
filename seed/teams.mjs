// Default course access per team (course ids from seed/catalog.mjs). These are STARTING defaults, applied once
// on a fresh database; after that administrators change them under Admin Portal -> Team access, and re-seeding
// never overwrites those edits.
// Process-document courses are for Customer Support (and Training & Quality).
export const PROCESS_COURSES = [];

export const COMMON = ['fi-academy', 'compliance', 'markets-basics'];

export const TEAM_ACCESS = {
  'MF Onboarding': ['product-school', 'objection-handling', 'call-excellence', 'nism-5a', 'nism-5b', 'zoho-crm', 'tata-tele'],
  'MF Digital': ['product-school', 'objection-handling', 'call-excellence', 'nism-5a', 'nism-5b', 'nism-5d', 'zoho-crm', 'tata-tele'],
  'MF Silver': ['product-school', 'objection-handling', 'call-excellence', 'nism-5a', 'nism-5b', 'zoho-crm', 'tata-tele'],
  'MF Gold': ['product-school', 'objection-handling', 'call-excellence', 'nism-5a', 'nism-5d', 'nism-10a', 'zoho-crm', 'tata-tele'],
  'MF Platinum': ['product-school', 'objection-handling', 'call-excellence', 'nism-5a', 'nism-5d', 'nism-10a', 'nism-10b', 'nism-21a', 'zoho-crm', 'tata-tele'],
  'Equity Onboarding': ['objection-handling', 'call-excellence', 'nism-7', 'nism-8', 'nism-12', 'zoho-crm', 'tata-tele'],
  'Equity Regular': ['objection-handling', 'call-excellence', 'nism-7', 'nism-8', 'nism-12', 'nism-13', 'nism-15', 'nism-16', 'zoho-crm', 'tata-tele'],
  'Customer Support': ['nism-5b', 'customer-support', 'process-mf-support', 'process-equity-support', 'zoho-crm', 'tata-tele'],
};
