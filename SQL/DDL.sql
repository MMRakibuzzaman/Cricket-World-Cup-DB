Create Database WorldCup2023 on
(
	Name='World_Cup_2023_Data',
	Filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\World_Cup_2023_Data.mdf',
	Size=50mb,
	Maxsize=100mb,
	Filegrowth=5%
)
Log On
(
	Name='World_Cup_2023_Log',
	Filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\World_Cup_2023_Log.ldf',
	Size=5mb,
	Maxsize=50mb,
	Filegrowth=1mb
)
go
Use WorldCup2023
go

CREATE TABLE Countries 
(
    CountryID INT IDENTITY (1,1) PRIMARY KEY,
    CountryName NVARCHAR(100) NOT NULL UNIQUE,
    ISOCode CHAR(3) NULL
)
GO

CREATE TABLE Teams 
(
    TeamID INT PRIMARY KEY,
    CountryID INT NOT NULL REFERENCES Countries(CountryID),
    TeamName NVARCHAR(100) NOT NULL,
    CaptainID INT NULL
)
GO

CREATE TABLE Players 
(
    PlayerID INT PRIMARY KEY,
    TeamID INT NOT NULL REFERENCES Teams(TeamID),
    PlayerName NVARCHAR(100) NOT NULL
)
GO

CREATE TABLE Venues 
(
    VenueID INT PRIMARY KEY,
    VenueName NVARCHAR(150) NOT NULL,
    City NVARCHAR(100) NOT NULL,
    CountryID INT NOT NULL REFERENCES Countries(CountryID)
)
GO

CREATE TABLE Umpires 
(
    UmpireID INT PRIMARY KEY,
    UmpireName NVARCHAR(100) NOT NULL,
    CountryID INT NOT NULL REFERENCES Countries(CountryID)
)
GO

CREATE TABLE MatchOfficials 
(
    MatchOfficialID INT PRIMARY KEY,
    MatchID INT NOT NULL,
    OnFieldUmpire1ID INT NULL REFERENCES Umpires(UmpireID),
    OnFieldUmpire2ID INT NULL REFERENCES Umpires(UmpireID),
    ThirdUmpireID INT NULL REFERENCES Umpires(UmpireID),
    MatchRefereeID INT NULL REFERENCES Umpires(UmpireID)
)
GO

CREATE TABLE Matches 
(
    MatchID INT PRIMARY KEY,
    MatchDate DATE NOT NULL,
    VenueID INT NOT NULL REFERENCES Venues(VenueID),
    Team1ID INT NOT NULL REFERENCES Teams(TeamID),
    Team2ID INT NOT NULL REFERENCES Teams(TeamID),
    Stage NVARCHAR(50) CHECK (Stage IN ('Group', 'Semi-Final', 'Final')),
    WinnerTeamID INT NULL REFERENCES Teams(TeamID)
)
GO

CREATE TABLE MatchResults 
(
    MatchResultID INT PRIMARY KEY,
    MatchID INT NOT NULL REFERENCES Matches(MatchID),
    ResultType NVARCHAR(50) CHECK (ResultType IN ('Normal', 'Super Over', 'No Result', 'Abandoned')),
    WinMargin INT NULL,
    WinMarginType NVARCHAR(50) CHECK (WinMarginType IN ('Runs', 'Wickets', NULL)),
    ManOfTheMatchPlayerID INT NULL REFERENCES Players(PlayerID)
)
GO

CREATE TABLE Innings 
(
    InningsID INT PRIMARY KEY,
    MatchID INT NOT NULL REFERENCES Matches(MatchID),
    InningsNumber INT NOT NULL,
    BattingTeamID INT NOT NULL REFERENCES Teams(TeamID),
    BowlingTeamID INT NOT NULL REFERENCES Teams(TeamID),
    RunsScored INT DEFAULT 0,
    WicketsLost INT DEFAULT 0,
    OversFaced DECIMAL(4,1) DEFAULT 0
)
GO

CREATE TABLE BattingScorecard 
(
    InningsID INT NOT NULL REFERENCES Innings(InningsID),
    PlayerID INT NOT NULL REFERENCES Players(PlayerID),
    Runs INT DEFAULT 0,
    BallsFaced INT DEFAULT 0,
    PRIMARY KEY (InningsID, PlayerID)
)
GO

CREATE TABLE BowlingScorecard 
(
    BowlingID INT PRIMARY KEY,
    InningsID INT NOT NULL REFERENCES Innings(InningsID),
    PlayerID INT NOT NULL REFERENCES Players(PlayerID),
    Overs DECIMAL(4,1) DEFAULT 0,
    RunsConceded INT DEFAULT 0,
    Wickets INT DEFAULT 0
)
GO

CREATE TABLE PointsTable 
(
    PointsID INT PRIMARY KEY,
    TeamID INT NOT NULL REFERENCES Teams(TeamID),
    MatchesPlayed INT DEFAULT 0,
    Wins INT DEFAULT 0,
    Losses INT DEFAULT 0,
    NoResults INT DEFAULT 0,
    Points INT DEFAULT 0,
    NetRunRate DECIMAL(5,2) NULL
)
GO

CREATE TABLE PlayerAwards 
(
    AwardID INT PRIMARY KEY,
    AwardName NVARCHAR(100) NOT NULL,
    PlayerID INT NOT NULL REFERENCES Players(PlayerID)
)
GO

CREATE TABLE TeamAwards 
(
    AwardID INT PRIMARY KEY,
    AwardName NVARCHAR(100) NOT NULL,
    TeamID INT NOT NULL REFERENCES Teams(TeamID)
)
GO

-- Alter
ALTER TABLE Teams
ADD FOREIGN KEY (CaptainID) REFERENCES Players(PlayerID)
GO

--View
CREATE VIEW Vw_MatchDetailsView
WITH SCHEMABINDING, ENCRYPTION
AS
SELECT
    M.MatchDate,
    V.VenueName,
    T1.TeamName AS Team1,
    T2.TeamName AS Team2,
    TW.TeamName AS Winner
FROM dbo.Matches M
INNER JOIN dbo.Venues V ON M.VenueID = V.VenueID
INNER JOIN dbo.Teams T1 ON M.Team1ID = T1.TeamID
INNER JOIN dbo.Teams T2 ON M.Team2ID = T2.TeamID
INNER JOIN dbo.Teams TW ON M.WinnerTeamID = TW.TeamID
GO

-- Stored Procedures
CREATE PROC Sp_GetMatchWinner
    @MatchID INT
AS
BEGIN
    SELECT T.TeamName
    FROM Matches M
    INNER JOIN Teams T ON M.WinnerTeamID = T.TeamID
    WHERE M.MatchID = @MatchID
END
GO

CREATE PROC Sp_GetPlayerBattingScorecard
    @PlayerID INT,
    @InningsID INT
AS
BEGIN
    SELECT P.PlayerName, B.Runs, B.BallsFaced
    FROM BattingScorecard B
    INNER JOIN Players P ON B.PlayerID = P.PlayerID
    WHERE B.PlayerID = @PlayerID AND B.InningsID = @InningsID
END
GO

-- User-Defined Functions (UDFs)
-- Scalar Function
CREATE FUNCTION Fn_GetTeamName (@TeamID INT)
RETURNS NVARCHAR(100)
AS
BEGIN
    DECLARE @TeamName NVARCHAR(100)
    SELECT @TeamName = TeamName FROM Teams WHERE TeamID = @TeamID;
    RETURN @TeamName
END
GO

-- Simple Table-Valued Function
CREATE FUNCTION Fn_GetTeamPlayers (@TeamID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT PlayerName
    FROM Players
    WHERE TeamID = @TeamID
)
GO

-- Multi-Statement Table-Valued Function
CREATE FUNCTION Fn_GetFullBattingScorecard 
    (@InningsID INT)
RETURNS @Scorecard TABLE 
(
    PlayerName NVARCHAR(100),
    Runs INT,
    BallsFaced INT
)
AS
BEGIN
    INSERT INTO @Scorecard (PlayerName, Runs, BallsFaced)
    SELECT P.PlayerName, BS.Runs, BS.BallsFaced
    FROM BattingScorecard AS BS
    INNER JOIN Players AS P ON BS.PlayerID = P.PlayerID
    WHERE BS.InningsID = @InningsID
    RETURN
END
GO

-- Triggers
-- FOR/AFTER Trigger
CREATE TRIGGER Tr_InsertBattingScorecard ON BattingScorecard
FOR INSERT
AS
BEGIN
    UPDATE I
    SET I.RunsScored = I.RunsScored + (SELECT SUM(Runs) FROM inserted WHERE InningsID = I.InningsID)
    FROM Innings I
    INNER JOIN inserted Ins ON I.InningsID = Ins.InningsID

    UPDATE I
    SET I.WicketsLost = I.WicketsLost + 1
    FROM Innings I
    INNER JOIN inserted Ins ON I.InningsID = Ins.InningsID
END
GO

-- INSTEAD OF Trigger
CREATE TRIGGER Tr_InsteadOfDeleteVenue ON Venues
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Matches WHERE VenueID IN (SELECT VenueID FROM deleted))
    BEGIN
        RAISERROR ('Cannot delete a venue that is linked to a match.', 16, 1)
    END
    ELSE
    BEGIN
        DELETE FROM Venues WHERE VenueID IN (SELECT VenueID FROM deleted)
    END
END
GO
