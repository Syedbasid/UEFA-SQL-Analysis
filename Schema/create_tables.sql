-- Goals table
CREATE TABLE goals (
    goal_id TEXT,
    match_id TEXT,
    pid TEXT,
    duration INT,
    assist TEXT,
    goal_desc TEXT
);

-- Matches table
CREATE TABLE matches (
    match_id TEXT,
    season TEXT,
    date DATE,
    home_team TEXT,
    away_team TEXT,
    stadium TEXT,
    home_team_score INT,
    away_team_score INT,
    penalty_shoot_out INT,
    attendance INT
);

-- Players table
CREATE TABLE players (
    player_id TEXT,
    first_name TEXT,
    last_name TEXT,
    nationality TEXT,
    dob DATE,
    team TEXT,
    jersey_number FLOAT,
    position TEXT,
    height FLOAT,
    weight FLOAT,
    foot TEXT
);
-- Teams table
CREATE TABLE teams (
    team_name TEXT,
    country TEXT,
    home_stadium TEXT
);

-- Stadiums table
CREATE TABLE stadiums (
    name TEXT,
    city TEXT,
    country TEXT,
    capacity INT
);



COPY goals
FROM 'C:\Program Files\PostgreSQL\Data\Dataset\goals.csv'
DELIMITER ','
CSV HEADER;

COPY matches
FROM 'C:\Program Files\PostgreSQL\Data\Dataset\Matches.csv'
DELIMITER ','
CSV HEADER;

COPY players
FROM 'C:\Program Files\PostgreSQL\Data\Dataset\Players.csv'
DELIMITER ','
CSV HEADER;

COPY teams
FROM 'C:\Program Files\PostgreSQL\Data\Dataset\Teams.csv'
DELIMITER ','
CSV HEADER;

COPY stadiums
FROM 'C:\Program Files\PostgreSQL\Data\Dataset\Stadiums.csv'
DELIMITER ','
CSV HEADER;














