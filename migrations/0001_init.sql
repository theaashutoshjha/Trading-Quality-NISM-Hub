-- FundsIndia Learning Hub schema (Cloudflare D1 / SQLite)

CREATE TABLE users (
  id            TEXT PRIMARY KEY,
  email         TEXT NOT NULL UNIQUE COLLATE NOCASE,
  name          TEXT NOT NULL,
  emp_id        TEXT,
  department    TEXT,
  role          TEXT NOT NULL DEFAULT 'learner' CHECK (role IN ('learner','trainer','admin')),
  status        TEXT NOT NULL DEFAULT 'active'  CHECK (status IN ('active','pending','suspended')),
  pw_hash       TEXT NOT NULL,
  must_change   INTEGER NOT NULL DEFAULT 0,
  totp_secret   TEXT,
  totp_enabled  INTEGER NOT NULL DEFAULT 0,
  created_at    TEXT NOT NULL DEFAULT (datetime('now')),
  last_login    TEXT
);

CREATE TABLE sessions (
  token_hash  TEXT PRIMARY KEY,
  user_id     TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  kind        TEXT NOT NULL CHECK (kind IN ('learner','admin')),
  created_at  TEXT NOT NULL DEFAULT (datetime('now')),
  expires_at  TEXT NOT NULL,
  ip          TEXT,
  ua          TEXT
);
CREATE INDEX idx_sessions_user ON sessions(user_id);

CREATE TABLE login_attempts (
  key          TEXT PRIMARY KEY,
  fails        INTEGER NOT NULL DEFAULT 0,
  locked_until TEXT,
  updated_at   TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE courses (
  id          TEXT PRIMARY KEY,
  code        TEXT NOT NULL,
  title       TEXT NOT NULL,
  subtitle    TEXT,
  category    TEXT NOT NULL,
  description TEXT,
  level       TEXT,
  hours       REAL DEFAULT 0,
  playlists   TEXT NOT NULL DEFAULT '[]',   -- JSON: [{id,title,channel,lang,note}]
  links       TEXT NOT NULL DEFAULT '[]',   -- JSON: [{title,url}]
  published   INTEGER NOT NULL DEFAULT 1,
  popular     INTEGER NOT NULL DEFAULT 0,
  sort        INTEGER NOT NULL DEFAULT 0,
  updated_at  TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE modules (
  id        TEXT PRIMARY KEY,
  course_id TEXT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  title     TEXT NOT NULL,
  weight    REAL,
  sort      INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_modules_course ON modules(course_id);

CREATE TABLE lessons (
  id         TEXT PRIMARY KEY,
  course_id  TEXT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  module_id  TEXT REFERENCES modules(id) ON DELETE SET NULL,
  title      TEXT NOT NULL,
  kind       TEXT NOT NULL DEFAULT 'note' CHECK (kind IN ('note','video','link')),
  video_id   TEXT,            -- YouTube video id (kind=video)
  url        TEXT,            -- external link (kind=link)
  body       TEXT,            -- markdown
  minutes    INTEGER DEFAULT 0,
  published  INTEGER NOT NULL DEFAULT 1,
  sort       INTEGER NOT NULL DEFAULT 0,
  updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX idx_lessons_course ON lessons(course_id, sort);

CREATE TABLE quizzes (
  id         TEXT PRIMARY KEY,
  course_id  TEXT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  module_id  TEXT REFERENCES modules(id) ON DELETE SET NULL,
  title      TEXT NOT NULL,
  minutes    INTEGER NOT NULL DEFAULT 30,
  pass_pct   INTEGER NOT NULL DEFAULT 60,
  negative   REAL NOT NULL DEFAULT 0,       -- marks deducted per wrong answer (0.25 = 25%)
  is_exam    INTEGER NOT NULL DEFAULT 0,    -- final assessment (issues certificate)
  published  INTEGER NOT NULL DEFAULT 1,
  sort       INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_quizzes_course ON quizzes(course_id);

CREATE TABLE questions (
  id          TEXT PRIMARY KEY,
  quiz_id     TEXT NOT NULL REFERENCES quizzes(id) ON DELETE CASCADE,
  question    TEXT NOT NULL,
  options     TEXT NOT NULL,                -- JSON array of strings
  answer      INTEGER NOT NULL,
  explanation TEXT,
  sort        INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_questions_quiz ON questions(quiz_id);

CREATE TABLE progress (
  user_id      TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  lesson_id    TEXT NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  course_id    TEXT NOT NULL,
  completed_at TEXT NOT NULL DEFAULT (datetime('now')),
  PRIMARY KEY (user_id, lesson_id)
);
CREATE INDEX idx_progress_course ON progress(user_id, course_id);

CREATE TABLE attempts (
  id         TEXT PRIMARY KEY,
  user_id    TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  quiz_id    TEXT NOT NULL REFERENCES quizzes(id) ON DELETE CASCADE,
  course_id  TEXT NOT NULL,
  correct    INTEGER NOT NULL,
  wrong      INTEGER NOT NULL,
  total      INTEGER NOT NULL,
  score      REAL NOT NULL,
  pct        REAL NOT NULL,
  passed     INTEGER NOT NULL,
  seconds    INTEGER,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);
CREATE INDEX idx_attempts_user ON attempts(user_id, created_at);

CREATE TABLE certificates (
  id         TEXT PRIMARY KEY,              -- public verification code
  user_id    TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  course_id  TEXT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  quiz_id    TEXT NOT NULL,
  pct        REAL NOT NULL,
  issued_at  TEXT NOT NULL DEFAULT (datetime('now')),
  revoked    INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE news (
  id           TEXT PRIMARY KEY,
  title        TEXT NOT NULL,
  body         TEXT,
  category     TEXT NOT NULL DEFAULT 'Update',
  url          TEXT,
  pinned       INTEGER NOT NULL DEFAULT 0,
  published    INTEGER NOT NULL DEFAULT 1,
  published_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE audit_log (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  actor      TEXT,
  action     TEXT NOT NULL,
  detail     TEXT,
  ip         TEXT,
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE settings (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
INSERT INTO settings (key, value) VALUES ('allow_signup', '0'), ('signup_domain', 'fundsindia.com');
