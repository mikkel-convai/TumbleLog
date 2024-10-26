-- Drop tables if they exist to ensure a clean setup
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS users;

-- Create the users table
CREATE TABLE users (
    id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    role VARCHAR CHECK (role IN ('coach', 'athlete')) NOT NULL
);

-- Create the sessions table
CREATE TABLE sessions (
    id VARCHAR PRIMARY KEY,
    athlete_id VARCHAR NOT NULL,
    athlete_name VARCHAR NOT NULL DEFAULT 'Grisha',
    date TIMESTAMP NOT NULL,
    FOREIGN KEY (athleteId) REFERENCES users (id) ON DELETE CASCADE
);

-- Create the skills table
CREATE TABLE skills (
    id VARCHAR PRIMARY KEY,
    session_id VARCHAR NOT NULL,
    name VARCHAR NOT NULL,
    symbol VARCHAR NOT NULL,
    difficulty REAL NOT NULL,
    equipment_reps JSONB NOT NULL,
    FOREIGN KEY (sessionId) REFERENCES sessions (id) ON DELETE CASCADE
);

-- Indexing for faster lookups
CREATE INDEX idx_sessions_athlete_id ON sessions (athlete_id);
CREATE INDEX idx_skills_session_id ON skills (session_id);

-- Sample data insertion

-- Insert sample user (athlete)
INSERT INTO users (id, name, role)
VALUES 
('athlete123', 'Grisha', 'athlete');

-- Insert a sample session linked to an athlete
INSERT INTO sessions (id, athleteId, athleteName, date)
VALUES 
('d860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'athlete123', 'Grisha', '2024-10-26 19:58:07');

-- Insert sample skills linked to the session
INSERT INTO skills (id, sessionId, name, symbol, difficulty, equipmentReps)
VALUES
('ea3cca3e-3130-4815-96eb-d171b0f21a4e', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Whipback', '^', 0.2, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('e4de8208-f3a9-4497-a308-e72a16f88179', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Double back somersault tuck', '--o', 2.0, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('32c5b308-ad60-439f-8b19-3834d3777773', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Double back somersault pike', '--<', 2.2, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('ffa7047f-8c94-4324-a905-add2d0f12172', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Double back somersault open', '--O', 2.2, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('d64b9e39-5c03-4f6b-af84-fb914edff616', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Double back somersault straight', '--/', 2.4, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('c641a171-5b89-471e-907b-01fd36a90b5b', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Full tuck', '2.', 0.9, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('efca3cb5-6761-44d6-85c3-fdba067d5cea', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Full-in tuck', '2-o', 2.4, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('905c4e98-6f95-4b3f-a7cf-3d1017745b6c', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Full-in pike', '2-<', 2.6, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('c5864a54-b62c-4978-8477-674844f43a93', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Full-in straight', '2-/', 2.8, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('11d6b549-f2e8-4c7f-afa7-77c33708f90d', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Full Full tuck', '2 2 o', 3.2, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('acd4d050-386c-41a1-b415-bd9a73130cb6', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Full Full straight', '2 2 /', 3.6, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('4d8a54c4-a290-4489-bf0f-91c417759a13', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'DB tuck whip', '--o ^', 2.2, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('37bfb031-a6ec-4d45-924b-b87861f4d315', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'DB pike whip', '--< ^', 2.4, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('700206d5-6c90-467e-8398-408c3500fb59', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'DB straight whip', '--/ ^', 2.6, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('d53940a0-f5b7-41bc-9ab2-c9cd19b262dc', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', 'Full in straight whip', '2-/ ^', 3.0, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('1734bc62-db32-4101-acc4-12af82a901a1', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', '5 skills', '5 skills', 5.0, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}'),
('740ac88a-a6f3-45f4-8c8b-8902b37d70be', 'd860df19-6a7b-4aea-9b81-2e1a2b301bb6', '8 skills', '8 skills', 8.0, '{"rodFloor": 0, "airRodFloor": 0, "airFloor": 0, "dmt": 0, "trampoline": 0}');
