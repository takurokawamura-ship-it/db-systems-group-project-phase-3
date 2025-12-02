/* Phase 3 group project DDL */

-- ORGANIZATION(organization_name, date_founded, headquarters)
CREATE TABLE organization (
  organization_name VARCHAR(45) NOT NULL,
  date_founded DATE NULL,
  headquarters VARCHAR(45) NULL,
  PRIMARY KEY (organization_name));

-- TEAM(team_name, home_stadium)
CREATE TABLE team(
    team_name VARCHAR(45) NOT NULL,
    home_stadium VARCHAR(45) NOT NULL,
    PRIMARY KEY(team_name),
);

-- RECORD(team_name, yr, record)
CREATE TABLE record(
    team_name VARCHAR(45) NOT NULL,
    yr YEAR(4),
    record VARCHAR(45),
    PRIMARY KEY(team_name, yr)
);

-- PLAYER(player_id, player_name, ssn, position, cntrct, jersey_number, bio, team_name)
CREATE TABLE player(
    player_id INT NOT NULL,
    player_name VARCHAR(45),
    ssn CHAR(9),
    position VARCHAR(45),
    cntrct INT,
    jersey_number DECIMAL,
    bio VARCHAR(45),
    team_name VARCHAR(45),
    PRIMARY KEY(player_id),
    FOREIGN KEY (team_name) REFERENCES team(team_name)
);

-- LEAGUE(league_name, date_founded)
CREATE TABLE league(
    league_name VARCHAR(45) NOT NULL,
    date_founded DATE,
    PRIMARY KEY(league_name)
);

-- DIVISION(division_name, date_founded)
CREATE TABLE division(
    division_name VARCHAR(45) NOT NULL,
    date_founded DATE,
    PRIMARY KEY(division_name)
);

-- STATISTICS(player_id, season, team_name, wins, era, whip, strikeouts, batting_avg, homeruns, stolen_base, ops, hits, fielding_pct, errors, defensive_runs_saved)
CREATE TABLE statistics(
    player_id INT NOT NULL,
    season YEAR(4) NOT NULL,
    team_name VARCHAR(45),
    wins INT,
    era DECIMAL,
    whip DECIMAL,
    strikeouts INT,
    batting_avg DECIMAL,
    homeruns INT,
    stolen_base INT,
    ops DECIMAL,
    hits INT,
    fielding_pct DECIMAL,
    errors INT,
    defensive_runs_saved INT,
    PRIMARY KEY(player_id, season, team_name),
    FOREIGN KEY (player_id) REFERENCES player(player_id),
    FOREIGN KEY (team_name) REFERENCES team(team_name),
    FOREIGN KEY (season) REFERENCES record(yr)
);

-- AGENT(ssn, player_id, agent_name, salary, agency)
CREATE TABLE agent(
    ssn CHAR(9) NOT NULL,
    player_id INT NOT NULL,
    agent_name VARCHAR(45),
    salary DECIMAL,
    agency VARCHAR(45),
    PRIMARY KEY(ssn),
    FOREIGN KEY (player_id) REFERENCES player(player_id)
);

-- INJURY(player_id, type_of_injury, date_of_injury, return_date)
CREATE TABLE INJURY(
    player_id INT NOT NULL,
    type_of_injury VARCHAR(255),
    date_of_injury DATE,
    return_date DATE
);

-- INJURY_TYPE(type_of_injury, treatment, affected_body_part)
CREATE TABLE INJURY_TYPE(
    type_of_injury VARCHAR(255) NOT NULL,
    treatment VARCHAR(255),
    affected_body_part VARCHAR(255)
);

-- COACHES(coach_id, name, team_name, salary, dob, team, role, hire_date, end_date)
CREATE TABLE COACHES( 
    coach_id INT NOT NULL,
    name VARCHAR(255),
    team_name VARCHAR(255),
    salary DECIMAL(10, 2),
    dob DATE,
    role VARCHAR(255),
    hire_date DATE,
    end_date DATE
);

-- GAME(game_id, location, game_type, home_team, away_team, score_home, score_away, year_played)
CREATE TABLE GAME(
    game_id INT NOT NULL,
    location VARCHAR(255),
    game_type VARCHAR(255),
    home_team VARCHAR(255),
    away_team VARCHAR(255),
    score_home INT,
    score_away INT,
    year_played INT
);

-- UMPIRE_PARTICIPATION(game_id, home_base, first_base, second_base, third_base)
CREATE TABLE UMPIRE_PARTICIPATION(
    game_id INT NOT NULL,
    home_base VARCHAR(255),
    first_base VARCHAR(255),
    second_base VARCHAR(255),
    third_base VARCHAR(255)
);

-- SPECTATOR(fan_club_id, game_id, name, ticket_id)
CREATE TABLE SPECTATOR(
    fan_club_id INT NOT NULL,
    game_id INT NOT NULL,
    name VARCHAR(255),
    ticket_id INT
);

-- TICKET(ticket_id, game_id, seat)
CREATE TABLE TICKET(
    ticket_id INT NOT NULL,
    game_id INT NOT NULL,
    seat VARCHAR(50)
);

-- SPONSOR(club_name, sponsor_name, contract)
CREATE TABLE SPONSOR(
    club_name VARCHAR(255) NOT NULL,
    sponsor_name VARCHAR(255) NOT NULL,
    contract VARCHAR(255)
);

-- UMPIRE(ssn, name, games_participated_count)
CREATE TABLE UMPIRE(
    ssn CHAR(9) NOT NULL,
    name VARCHAR(255),
    games_participated_count INT
);

-- SPORTS_CLUB_COMPANY(club_name, address, ballpark, home_location)
CREATE TABLE SPORTS_CLUB_COMPANY( 
    club_name VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    ballpark VARCHAR(255),
    home_location VARCHAR(255)
);

/* alter each tables schema */
ALTER TABLE INJURY
  ADD PRIMARY KEY (player_id, date_of_injury, type_of_injury);
ALTER TABLE INJURY
  ADD CONSTRAINT fk_injury_player_player_id
    FOREIGN KEY (player_id) REFERENCES PLAYER(player_id)
      ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE INJURY_TYPE
    ADD PRIMARY KEY (type_of_injury);

ALTER TABLE COACHES
    ADD PRIMARY KEY (coach_id);
ALTER TABLE COACHES
  ADD CONSTRAINT fk_coaches_team_team_name
    FOREIGN KEY (team_name) REFERENCES TEAM(team_name)
      ON UPDATE RESTRICT ON DELETE SET NULL;

ALTER TABLE GAME
  ADD PRIMARY KEY (game_id);
ALTER TABLE GAME
  ADD CONSTRAINT fk_game_team_home_team
    FOREIGN KEY (home_team) REFERENCES TEAM(team_name)
      ON UPDATE RESTRICT ON DELETE CASCADE;
ALTER TABLE GAME
  ADD CONSTRAINT fk_game_team_away_team
    FOREIGN KEY (away_team) REFERENCES TEAM(team_name)
      ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE UMPIRE_PARTICIPATION
  ADD PRIMARY KEY (game_id);

ALTER TABLE SPECTATOR
  ADD PRIMARY KEY (fan_club_id);

ALTER TABLE SPECTATOR
  ADD CONSTRAINT fk_spectator_game_game_id
    FOREIGN KEY (game_id) REFERENCES GAME(game_id)
      ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE TICKET
  ADD PRIMARY KEY (ticket_id);

ALTER TABLE TICKET
  ADD CONSTRAINT fk_ticket_game_game_id
    FOREIGN KEY (game_id) REFERENCES GAME(game_id)
      ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE SPONSOR
  ADD PRIMARY KEY (club_name, sponsor_name);
ALTER TABLE SPONSOR
  ADD CONSTRAINT fk_sponsor_sports_club_company_club_name
    FOREIGN KEY (club_name) REFERENCES SPORTS_CLUB_COMPANY(club_name)
      ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE UMPIRE
  ADD PRIMARY KEY (ssn);

ALTER TABLE SPORTS_CLUB_COMPANY
  ADD PRIMARY KEY (club_name);
