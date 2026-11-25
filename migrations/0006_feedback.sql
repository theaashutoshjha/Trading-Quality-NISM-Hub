-- Learner feedback on content ("Was this helpful?") and messages sent through Contact us.
-- Both are read in the admin portal. A snapshot of the learner's name / e-mail / team is kept so the record
-- stays readable even if the account is later deleted.
CREATE TABLE feedback (
  id           TEXT PRIMARY KEY,
  kind         TEXT NOT NULL CHECK (kind IN ('content','contact')),
  user_id      TEXT REFERENCES users(id) ON DELETE SET NULL,
  user_name    TEXT NOT NULL,
  user_email   TEXT NOT NULL,
  team         TEXT,
  target       TEXT,                 -- content feedback: lesson id, or 'course:<id>'
  course_id    TEXT,
  lesson_id    TEXT,
  target_title TEXT,                 -- title of the lesson / course at the time
  category     TEXT,                 -- contact: issue | content | access | suggestion | other
  rating       INTEGER,              -- content feedback: 1-5
  subject      TEXT,
  message      TEXT NOT NULL DEFAULT '',
  status       TEXT NOT NULL DEFAULT 'new' CHECK (status IN ('new','read','resolved')),
  admin_note   TEXT,
  created_at   TEXT NOT NULL DEFAULT (datetime('now')),
  updated_at   TEXT NOT NULL DEFAULT (datetime('now'))
);
-- one feedback per learner per lesson / course (sending again updates it)
CREATE UNIQUE INDEX idx_feedback_content ON feedback(user_id, target) WHERE kind = 'content' AND user_id IS NOT NULL;
CREATE INDEX idx_feedback_status ON feedback(status, created_at);
CREATE INDEX idx_feedback_user ON feedback(user_id, created_at);
