-- Track login count per user so the new-user guide is shown only for the first 3 logins.
ALTER TABLE users ADD COLUMN login_count INTEGER NOT NULL DEFAULT 0;
