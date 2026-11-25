// Default course access per team (course ids from seed/catalog.mjs). These are STARTING defaults, applied once
// on a fresh database; after that administrators change them under Admin Portal -> Team access, and re-seeding
// never overwrites those edits.
// Process-document courses every team can open (applied once, separately, so existing databases pick them up).
export const PROCESS_COURSES = ['process-mf-support', 'process-equity-support'];

export const COMMON = ['fi-academy', 'product-school', 'compliance', 'markets-basics'];

export const TEAM_ACCESS = {
  'MF Onboarding': ['nism-5a', 'nism-5b', 'zoho-crm', 'tata-tele', 'customer-support'],
  'MF Digital': ['nism-5a', 'nism-5b', 'nism-5d', 'zoho-crm', 'tata-tele', 'call-excellence', 'objection-handling'],
  'MF Silver': ['nism-5a', 'nism-5b', 'zoho-crm', 'tata-tele', 'call-excellence', 'objection-handling'],
  'MF Gold': ['nism-5a', 'nism-5d', 'nism-10a', 'zoho-crm', 'tata-tele', 'call-excellence', 'objection-handling'],
  'MF Platinum': ['nism-5a', 'nism-5d', 'nism-10a', 'nism-10b', 'nism-21a', 'zoho-crm', 'tata-tele', 'call-excellence', 'objection-handling'],
  'Equity Onboarding': ['nism-7', 'nism-8', 'nism-12', 'zoho-crm', 'tata-tele', 'customer-support'],
  'Equity Regular': ['nism-7', 'nism-8', 'nism-12', 'nism-13', 'nism-15', 'nism-16', 'zoho-crm', 'tata-tele', 'call-excellence', 'objection-handling'],
  'Customer Support': ['nism-5b', 'customer-support', 'call-excellence', 'zoho-crm', 'tata-tele'],
};
