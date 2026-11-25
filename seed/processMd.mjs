// Turns seed/data/processDocs.mjs into the Markdown lessons of the "Process documents" courses.
import { MF_MODULES, SUPPORT_ADDRESS, SUPPORT_EMAIL } from './data/processDocs.mjs';

const section = (title, body) => (body && String(body).trim() ? `\n## ${title}\n${body}\n` : '');
const bullets = (a, f = (x) => `- ${x}`) => (a && a.length ? a.map(f).join('\n') : '');
const addressBlock = () => '> ' + SUPPORT_ADDRESS.split('\n').join('  \n> ');

function sendLine(p) {
  if (p.sendTo === 'email') return `Email clear scanned copies to **${SUPPORT_EMAIL}**.`;
  if (p.sendTo === 'address') return `Send the documents by post / courier to:\n\n${addressBlock()}`;
  if (p.sendTo === 'both') return `Email the scanned letter and documents to **${SUPPORT_EMAIL}**. Where originals or physical forms are required, send them to:\n\n${addressBlock()}`;
  return 'Nothing needs to be sent - the investor completes this online.';
}

export function processMd(p, moduleTitle) {
  let md = `# ${p.title}\n\n*${moduleTitle} · MF customer support*\n\n**When it applies:** ${p.summary}\n`;
  md += section('Documents required', bullets(p.docs, (d) => `- [ ] ${d}`));
  md += section('Steps', p.steps.map((s, i) => `${i + 1}. ${s}`).join('\n'));
  md += section('Turnaround time', p.tat);
  md += section('Where to send', sendLine(p));
  md += section('Notes for the agent', bullets(p.notes));
  md += section(
    'Customer reply template (copy & paste)',
    '```text\n' + p.template.trim() + '\n```\n\n*Fill the [square-bracket] fields before sending. Forms marked "attached" are sent with the reply.*',
  );
  return md.trim();
}

export function checklistMd() {
  let md = '# Document checklist - all processes\n\nWhat the customer must provide for each process. Open the process lesson for the steps and the reply template.\n';
  for (const m of MF_MODULES) {
    md += `\n## ${m.title}\n`;
    for (const p of m.processes) md += `\n### ${p.title}\n*Turnaround: ${p.tat}*\n\n${bullets(p.docs)}\n`;
  }
  return md.trim();
}

export const processOverviewMd = () =>
  `# How to use process documents

This section holds every customer-support process in one place. For each process you will find:

1. **Documents required** - a checklist to share with the investor
2. **Steps** - the exact pathway on the portal / app
3. **Turnaround time** and **where to send** the documents
4. **Notes for the agent** - conditions, exceptions and fund-house specifics
5. **Customer reply template** - use the 📋 Copy button, then fill the [bracketed] fields

Processes are grouped by topic: ${MF_MODULES.map((m) => m.title).join(' · ')}.

> Source: the FundsIndia customer-support templates document. Turnaround times are fund-house / operations estimates - confirm with Operations if a case is urgent.`;

export const EQUITY_PLACEHOLDER_MD = `# Equity customer support

**Process documents for equity (broking) customer support will appear here.**

The customer-support templates document supplied so far covers mutual-fund processes only (see **MF customer support**). Equity templates - the documents required, steps, turnaround times and reply text for each equity process - are added here by the Training & Quality team through the Admin Portal (Courses & videos > Equity customer support).

Until then, use the MF customer support section for shared processes such as KYC and Re-KYC, and address and contact updates.`;
