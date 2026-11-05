-- Learning paths (ordered, step-by-step), per-user video resume points, creator credit for videos.
ALTER TABLE lessons ADD COLUMN author TEXT;

CREATE TABLE paths (
  id          TEXT PRIMARY KEY,
  title       TEXT NOT NULL,
  description TEXT,
  level       TEXT,
  icon        TEXT,
  published   INTEGER NOT NULL DEFAULT 1,
  sort        INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE path_items (
  path_id   TEXT NOT NULL REFERENCES paths(id) ON DELETE CASCADE,
  lesson_id TEXT NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  sort      INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (path_id, lesson_id)
);
CREATE INDEX idx_path_items ON path_items(path_id, sort);

CREATE TABLE video_progress (
  user_id    TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  lesson_id  TEXT NOT NULL REFERENCES lessons(id) ON DELETE CASCADE,
  seconds    INTEGER NOT NULL DEFAULT 0,
  duration   INTEGER NOT NULL DEFAULT 0,
  updated_at TEXT NOT NULL DEFAULT (datetime('now')),
  PRIMARY KEY (user_id, lesson_id)
);
CREATE INDEX idx_video_progress_user ON video_progress(user_id, updated_at);
