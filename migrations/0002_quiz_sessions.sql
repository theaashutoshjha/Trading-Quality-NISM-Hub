-- Server-side record of which questions a learner was served (prevents tampering with grading)
CREATE TABLE quiz_sessions (
  id           TEXT PRIMARY KEY,
  user_id      TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  quiz_id      TEXT NOT NULL REFERENCES quizzes(id) ON DELETE CASCADE,
  question_ids TEXT NOT NULL,
  started_at   TEXT NOT NULL DEFAULT (datetime('now')),
  submitted    INTEGER NOT NULL DEFAULT 0
);
CREATE INDEX idx_quiz_sessions_user ON quiz_sessions(user_id);
