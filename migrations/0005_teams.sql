-- Team-based access. Each learner belongs to one team; the team decides which courses are visible.
-- "User ID" for sign-in is users.emp_id (the e-mail address keeps working as an alternative).
ALTER TABLE users ADD COLUMN team TEXT;
CREATE UNIQUE INDEX idx_users_empid ON users(emp_id COLLATE NOCASE) WHERE emp_id IS NOT NULL AND emp_id <> '';

CREATE TABLE team_access (
  team      TEXT NOT NULL,
  course_id TEXT NOT NULL REFERENCES courses(id) ON DELETE CASCADE,
  PRIMARY KEY (team, course_id)
);
CREATE INDEX idx_team_access_team ON team_access(team);
