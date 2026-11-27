-- System settings (certificate branding, maintenance/announcement banner, scheduled NISM email config)
CREATE TABLE IF NOT EXISTS system_settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);

INSERT OR IGNORE INTO system_settings (key, value) VALUES
  ('cert_branding', '{"title":"CERTIFICATE OF COMPLETION","subtitle":"Internal Training & Competency Assessment","signatoryName":"Rajesh Chakravarthi Rao","signatoryTitle":"Head of Training & Quality","disclaimer":"Internal training certificate issued by the FundsIndia Learning Hub. It is not an NISM/SEBI certification.","accentColor":"#1d6ff2"}'),
  ('banner', '{"active":false,"level":"info","message":"","expiresAt":""}'),
  ('nism_schedule', '{"enabled":true,"recipient":"qaudits@fundsindia.com","thresholdDays":30,"frequency":"weekly","lastSentAt":"","webhookUrl":""}');

-- "What Changed" Regulatory & Product Change Log
CREATE TABLE IF NOT EXISTS regulatory_changes (
  id TEXT PRIMARY KEY,
  category TEXT NOT NULL,
  title TEXT NOT NULL,
  effective_date TEXT NOT NULL,
  old_rule TEXT NOT NULL,
  new_rule TEXT NOT NULL,
  impact TEXT,
  published INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

INSERT OR IGNORE INTO regulatory_changes (id, category, title, effective_date, old_rule, new_rule, impact, published) VALUES
  ('rc-tax-eq-2024', 'Taxation', 'Equity Mutual Fund & Listed Equity Capital Gains', '2024-07-23', 'STCG (<=12 months) taxed at 15%; LTCG (>12 months) taxed at 10% above ₹1,00,000 exemption per FY.', 'STCG (<=12 months) taxed at 20%; LTCG (>12 months) taxed at 12.5% above ₹1,25,000 exemption per FY.', 'Update all client tax illustrations and redemption projections to use 20% STCG and 12.5% LTCG.', 1),
  ('rc-sebi-sif-2025', 'Product', 'SEBI Specialised Investment Fund (SIF) Framework', '2025-04-01', 'Only Mutual Funds (no minimum) and PMS (₹50 Lakh minimum) existed for retail/HNI investors.', 'New SIF asset class bridges MF and PMS with a minimum investment of ₹10 Lakh per PAN across strategies.', 'Eligible HNI clients seeking long-short or tactical strategies below ₹50L can now consider SIFs.', 1),
  ('rc-debt-mf-tax', 'Taxation', 'Debt Mutual Fund Taxation (<35% Domestic Equity)', '2023-04-01', 'Debt MFs held >36 months qualified for 20% LTCG with indexation benefits.', 'Gains from specified debt MFs (<35% equity) are taxed at the investor slab rate regardless of holding period.', 'Highlight post-tax yield comparison vs. arbitrage/equity-savings funds for 30% tax bracket clients.', 1),
  ('rc-nism-21a', 'Compliance', 'NISM Series XXI-A (PMS Distributors) Requirement', '2024-06-01', 'Only NISM V-A was required for general Mutual Fund distribution.', 'Advisors distributing PMS products must hold a valid NISM Series XXI-A certification in addition to V-A.', 'Verify NISM XXI-A validity in the Compliance Hub before pitching PMS.', 1);
