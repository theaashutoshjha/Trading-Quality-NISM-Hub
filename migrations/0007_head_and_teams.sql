-- Add 'head' role to users, dynamic teams table, and head portal session kind.
PRAGMA foreign_keys=OFF;

CREATE TABLE users_new (
  id            TEXT PRIMARY KEY,
  email         TEXT NOT NULL UNIQUE COLLATE NOCASE,
  name          TEXT NOT NULL,
  emp_id        TEXT,
  department    TEXT,
  team          TEXT,
  role          TEXT NOT NULL DEFAULT 'learner' CHECK (role IN ('learner','head','trainer','admin')),
  status        TEXT NOT NULL DEFAULT 'active'  CHECK (status IN ('active','pending','suspended')),
  pw_hash       TEXT NOT NULL,
  must_change   INTEGER NOT NULL DEFAULT 0,
  totp_secret   TEXT,
  totp_enabled  INTEGER NOT NULL DEFAULT 0,
  created_at    TEXT NOT NULL DEFAULT (datetime('now')),
  last_login    TEXT
);
INSERT INTO users_new (id,email,name,emp_id,department,team,role,status,pw_hash,must_change,totp_secret,totp_enabled,created_at,last_login)
SELECT id,email,name,emp_id,department,team,role,status,pw_hash,must_change,totp_secret,totp_enabled,created_at,last_login FROM users;
DROP TABLE users;
ALTER TABLE users_new RENAME TO users;
CREATE UNIQUE INDEX idx_users_empid ON users(emp_id COLLATE NOCASE) WHERE emp_id IS NOT NULL AND emp_id <> '';

CREATE TABLE sessions_new (
  token_hash  TEXT PRIMARY KEY,
  user_id     TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  kind        TEXT NOT NULL CHECK (kind IN ('learner','head','admin')),
  created_at  TEXT NOT NULL DEFAULT (datetime('now')),
  expires_at  TEXT NOT NULL,
  ip          TEXT,
  ua          TEXT
);
INSERT INTO sessions_new (token_hash,user_id,kind,created_at,expires_at,ip,ua)
SELECT token_hash,user_id,kind,created_at,expires_at,ip,ua FROM sessions;
DROP TABLE sessions;
ALTER TABLE sessions_new RENAME TO sessions;
CREATE INDEX idx_sessions_user ON sessions(user_id);

PRAGMA foreign_keys=ON;

CREATE TABLE IF NOT EXISTS teams (
  name        TEXT PRIMARY KEY,
  description TEXT,
  full_access INTEGER NOT NULL DEFAULT 0,
  created_by  TEXT,
  created_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

INSERT OR IGNORE INTO teams (name, description, full_access) VALUES
  ('MF Onboarding', 'Mutual Fund onboarding & sales', 0),
  ('MF Digital', 'Mutual Fund digital sales', 0),
  ('MF Silver', 'Mutual Fund Silver advisory & sales', 0),
  ('MF Gold', 'Mutual Fund Gold advisory & sales', 0),
  ('MF Platinum', 'Mutual Fund Platinum / HNI advisory & sales', 0),
  ('Equity Onboarding', 'Equity broking onboarding & sales', 0),
  ('Equity Regular', 'Equity broking sales & research', 0),
  ('Customer Support', 'MF & Equity customer service & operations', 0),
  ('Training & Quality', 'Training & Quality (full access)', 1);
