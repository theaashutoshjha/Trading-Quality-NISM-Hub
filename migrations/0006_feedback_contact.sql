-- Learner feedback (bottom of every page) & contact form submissions, plus updated team-wise access.
CREATE TABLE IF NOT EXISTS feedback (
  id         TEXT PRIMARY KEY,
  kind       TEXT NOT NULL CHECK (kind IN ('feedback','contact')),
  user_id    TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  user_name  TEXT NOT NULL,
  user_email TEXT NOT NULL,
  user_team  TEXT,
  page       TEXT,
  rating     INTEGER,
  subject    TEXT,
  message    TEXT NOT NULL,
  status     TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new','reviewed')),
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX IF NOT EXISTS idx_feedback_created ON feedback(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_feedback_kind ON feedback(kind, status);

-- Align team_access to strict team-wise needs:
-- Sales teams (MF *, Equity *) do NOT get customer-support or process-*-support.
-- Customer Support does NOT get sales courses (product-school, objection-handling, call-excellence).
DELETE FROM team_access WHERE team IN (
  'MF Onboarding','MF Digital','MF Silver','MF Gold','MF Platinum',
  'Equity Onboarding','Equity Regular','Customer Support'
);

-- MF Onboarding
INSERT OR IGNORE INTO team_access (team, course_id)
SELECT 'MF Onboarding', id FROM courses WHERE id IN (
  'fi-academy','compliance','markets-basics','product-school','objection-handling','call-excellence',
  'nism-5a','nism-5b','zoho-crm','tata-tele'
);
-- MF Digital
INSERT OR IGNORE INTO team_access (team, course_id)
SELECT 'MF Digital', id FROM courses WHERE id IN (
  'fi-academy','compliance','markets-basics','product-school','objection-handling','call-excellence',
  'nism-5a','nism-5b','nism-5d','zoho-crm','tata-tele'
);
-- MF Silver
INSERT OR IGNORE INTO team_access (team, course_id)
SELECT 'MF Silver', id FROM courses WHERE id IN (
  'fi-academy','compliance','markets-basics','product-school','objection-handling','call-excellence',
  'nism-5a','nism-5b','zoho-crm','tata-tele'
);
-- MF Gold
INSERT OR IGNORE INTO team_access (team, course_id)
SELECT 'MF Gold', id FROM courses WHERE id IN (
  'fi-academy','compliance','markets-basics','product-school','objection-handling','call-excellence',
  'nism-5a','nism-5d','nism-10a','zoho-crm','tata-tele'
);
-- MF Platinum
INSERT OR IGNORE INTO team_access (team, course_id)
SELECT 'MF Platinum', id FROM courses WHERE id IN (
  'fi-academy','compliance','markets-basics','product-school','objection-handling','call-excellence',
  'nism-5a','nism-5d','nism-10a','nism-10b','nism-21a','zoho-crm','tata-tele'
);
-- Equity Onboarding
INSERT OR IGNORE INTO team_access (team, course_id)
SELECT 'Equity Onboarding', id FROM courses WHERE id IN (
  'fi-academy','compliance','markets-basics','objection-handling','call-excellence',
  'nism-7','nism-8','nism-12','zoho-crm','tata-tele'
);
-- Equity Regular
INSERT OR IGNORE INTO team_access (team, course_id)
SELECT 'Equity Regular', id FROM courses WHERE id IN (
  'fi-academy','compliance','markets-basics','objection-handling','call-excellence',
  'nism-7','nism-8','nism-12','nism-13','nism-15','nism-16','zoho-crm','tata-tele'
);
-- Customer Support (no sales courses)
INSERT OR IGNORE INTO team_access (team, course_id)
SELECT 'Customer Support', id FROM courses WHERE id IN (
  'fi-academy','compliance','markets-basics','nism-5b','customer-support',
  'process-mf-support','process-equity-support','zoho-crm','tata-tele'
);
