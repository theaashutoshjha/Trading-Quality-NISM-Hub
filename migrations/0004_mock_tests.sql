-- Mock tests: fixed full-length papers (every question is served, in random order).
ALTER TABLE quizzes ADD COLUMN mock INTEGER NOT NULL DEFAULT 0;
