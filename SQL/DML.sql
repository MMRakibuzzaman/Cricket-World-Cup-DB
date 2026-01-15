USE WorldCup2023
GO

SET IDENTITY_INSERT Countries ON
GO

INSERT INTO Countries (CountryID, CountryName, ISOCode) VALUES
(1, 'India', 'IND'),
(2, 'Australia', 'AUS'),
(3, 'England', 'ENG'),
(4, 'Pakistan', 'PAK'),
(5, 'South Africa', 'RSA'),
(6, 'New Zealand', 'NZL'),
(7, 'Bangladesh', 'BAN'),
(8, 'Sri Lanka', 'SRI'),
(9, 'Afghanistan', 'AFG'),
(10, 'Netherlands', 'NED')
GO

SET IDENTITY_INSERT Countries OFF
GO

INSERT INTO Teams (TeamID, CountryID, TeamName) VALUES
(1, 1, 'India'),
(2, 2, 'Australia'),
(3, 3, 'England'),
(4, 4, 'Pakistan'),
(5, 5, 'South Africa'),
(6, 6, 'New Zealand'),
(7, 7, 'Bangladesh'),
(8, 8, 'Sri Lanka'),
(9, 9, 'Afghanistan'),
(10, 10, 'Netherlands')
GO

INSERT INTO Venues (VenueID, VenueName, City, CountryID) VALUES
(1, 'Narendra Modi Stadium', 'Ahmedabad', 1),
(2, 'M. Chinnaswamy Stadium', 'Bengaluru', 1),
(3, 'Wankhede Stadium', 'Mumbai', 1),
(4, 'Eden Gardens', 'Kolkata', 1),
(5, 'Arun Jaitley Stadium', 'Delhi', 1),
(6, 'MA Chidambaram Stadium', 'Chennai', 1),
(7, 'Himachal Pradesh Cricket Association Stadium', 'Dharamshala', 1),
(8, 'Bharat Ratna Shri Atal Bihari Vajpayee Ekana Cricket Stadium', 'Lucknow', 1),
(9, 'Maharashtra Cricket Association Stadium', 'Pune', 1),
(10, 'Rajiv Gandhi International Cricket Stadium', 'Hyderabad', 1)
GO

INSERT INTO Umpires (UmpireID, UmpireName, CountryID) VALUES
(1, 'Richard Illingworth', 3),
(2, 'Rod Tucker', 2),
(3, 'Kumar Dharmasena', 8),
(4, 'Nitin Menon', 1),
(5, 'Jeff Crowe', 6),
(6, 'Marais Erasmus', 5),
(7, 'Paul Reiffel', 2),
(8, 'Chris Gaffaney', 6),
(9, 'Joel Wilson', 3),
(10, 'Michael Gough', 3),
(11, 'Adrian Holdstock', 5),
(12, 'Andy Pycroft', 5)
GO

INSERT INTO Players (PlayerID, TeamID, PlayerName) VALUES
(1, 1, 'Rohit Sharma'),
(2, 1, 'Virat Kohli'),
(3, 1, 'Jasprit Bumrah'),
(4, 1, 'KL Rahul'),
(5, 1, 'Mohammed Shami'),
(6, 2, 'Pat Cummins'),
(7, 2, 'David Warner'),
(8, 2, 'Travis Head'),
(9, 2, 'Adam Zampa'),
(10, 2, 'Glenn Maxwell'),
(11, 3, 'Jos Buttler'),
(12, 3, 'Ben Stokes'),
(13, 3, 'Mark Wood'),
(14, 4, 'Babar Azam'),
(15, 4, 'Shaheen Afridi'),
(16, 5, 'Quinton de Kock'),
(17, 5, 'Kagiso Rabada'),
(18, 6, 'Kane Williamson'),
(19, 6, 'Trent Boult'),
(20, 9, 'Rashid Khan'),
(21, 9, 'Ibrahim Zadran'),
(22, 10, 'Scott Edwards'),
(23, 10, 'Bas de Leede'),
(24, 7, 'Shakib Al Hasan'),     
(25, 8, 'Kusal Mendis'),        
(26, 9, 'Hashmatullah Shahidi')
GO

INSERT INTO Matches (MatchID, MatchDate, VenueID, Team1ID, Team2ID, Stage, WinnerTeamID) VALUES
(1, '2023-11-04', 2, 6, 4, 'Group', 6),
(2, '2023-11-12', 4, 3, 4, 'Group', 3),
(3, '2023-11-15', 3, 1, 6, 'Semi-Final', 1),
(4, '2023-11-16', 4, 2, 5, 'Semi-Final', 2),
(5, '2023-11-19', 1, 1, 2, 'Final', 2)
GO

INSERT INTO MatchOfficials (MatchOfficialID, MatchID, OnFieldUmpire1ID, OnFieldUmpire2ID, ThirdUmpireID, MatchRefereeID) VALUES
(1, 1, 8, 4, 1, 5),
(2, 2, 10, 9, 7, 5),
(3, 3, 1, 3, 2, 5),
(4, 4, 6, 7, 9, 12),
(5, 5, 1, 2, 3, 5)
GO

INSERT INTO MatchResults (MatchResultID, MatchID, ResultType, WinMargin, WinMarginType, ManOfTheMatchPlayerID) VALUES
(1, 1, 'Normal', 21, 'Runs', 18),
(2, 2, 'Normal', 93, 'Runs', 12),
(3, 3, 'Normal', 70, 'Runs', 5),
(4, 4, 'Normal', 3, 'Wickets', 8),
(5, 5, 'Normal', 6, 'Wickets', 8)
GO

INSERT INTO Innings (InningsID, MatchID, InningsNumber, BattingTeamID, BowlingTeamID, RunsScored, WicketsLost, OversFaced) VALUES
(1, 3, 1, 1, 6, 397, 4, 50.0),
(2, 3, 2, 6, 1, 327, 10, 48.5)
INSERT INTO Innings (InningsID, MatchID, InningsNumber, BattingTeamID, BowlingTeamID, RunsScored, WicketsLost, OversFaced) VALUES
(3, 4, 1, 5, 2, 212, 10, 49.4),
(4, 4, 2, 2, 5, 215, 7, 47.2) 
INSERT INTO Innings (InningsID, MatchID, InningsNumber, BattingTeamID, BowlingTeamID, RunsScored, WicketsLost, OversFaced) VALUES
(5, 5, 1, 1, 2, 240, 10, 50.0),
(6, 5, 2, 2, 1, 241, 4, 43.0)
GO

-- Fix: Disable trigger to prevent double-counting runs during initial load
DISABLE TRIGGER Tr_InsertBattingScorecard ON BattingScorecard
GO

INSERT INTO BattingScorecard (InningsID, PlayerID, Runs, BallsFaced) VALUES
(1, 2, 117, 113),
(1, 1, 47, 29),  
(1, 4, 39, 20),  
(2, 18, 14, 11), 
(2, 19, 10, 5),  
(3, 16, 60, 50), 
(4, 8, 62, 48),  
(4, 7, 15, 18),  
(5, 2, 54, 63),  
(5, 1, 47, 31),  
(5, 4, 66, 107), 
(6, 8, 137, 120),
(6, 7, 7, 15),   
(6, 10, 2, 11);  
GO

-- Fix: Re-enable trigger for future operations
ENABLE TRIGGER Tr_InsertBattingScorecard ON BattingScorecard
GO

INSERT INTO BowlingScorecard (BowlingID, InningsID, PlayerID, Overs, RunsConceded, Wickets) VALUES
(1, 2, 5, 9.5, 57, 7), 
(2, 2, 3, 10.0, 63, 1),
(3, 3, 6, 10.0, 50, 3),
(4, 4, 17, 9.2, 49, 2),
(5, 5, 6, 10.0, 34, 2),
(6, 5, 9, 10.0, 44, 1),
(7, 6, 3, 9.0, 43, 2), 
(8, 6, 5, 10.0, 60, 1)
GO

INSERT INTO PointsTable (PointsID, TeamID, MatchesPlayed, Wins, Losses, NoResults, Points, NetRunRate) VALUES
(1, 1, 9, 9, 0, 0, 18, 2.57),
(2, 2, 9, 7, 2, 0, 14, 0.84),
(3, 5, 9, 7, 2, 0, 14, 1.26),
(4, 6, 9, 5, 4, 0, 10, 0.74)
GO

INSERT INTO PlayerAwards (AwardID, AwardName, PlayerID) VALUES
(1, 'Player of the Tournament', 2),
(2, 'Player of the Final Match', 8)
GO

INSERT INTO TeamAwards (AwardID, AwardName, TeamID) VALUES
(1, 'Tournament Winner', 2)
GO

-- Update
UPDATE Teams SET CaptainID = 1 WHERE TeamID = 1
UPDATE Teams SET CaptainID = 6 WHERE TeamID = 2
UPDATE Teams SET CaptainID = 11 WHERE TeamID = 3
UPDATE Teams SET CaptainID = 14 WHERE TeamID = 4
UPDATE Teams SET CaptainID = 16 WHERE TeamID = 5
UPDATE Teams SET CaptainID = 18 WHERE TeamID = 6
UPDATE Teams SET CaptainID = 24 WHERE TeamID = 7
UPDATE Teams SET CaptainID = 25 WHERE TeamID = 8
UPDATE Teams SET CaptainID = 26 WHERE TeamID = 9
UPDATE Teams SET CaptainID = 22 WHERE TeamID = 10
GO


-- Views
SELECT * FROM Vw_MatchDetailsView
GO

-- INNER JOIN
SELECT M.MatchDate, V.VenueName, T.TeamName Winner
FROM Matches M
INNER JOIN Venues V ON M.VenueID = V.VenueID
INNER JOIN Teams T ON M.WinnerTeamID = T.TeamID
GO

-- OUTER JOIN
SELECT P.PlayerName, T.TeamName
FROM Players P
LEFT OUTER JOIN Teams T ON P.TeamID = T.TeamID
GO

-- CROSS JOIN
SELECT P.PlayerName, V.VenueName
FROM Players P
CROSS JOIN Venues V
GO

-- Implicit Join
SELECT M.MatchDate, T.TeamName Winner
FROM Matches M, Teams T
WHERE M.WinnerTeamID = T.TeamID
GO

-- TOP Clause with TIES
SELECT TOP 2 WITH TIES P.PlayerName, BS.BallsFaced
FROM BattingScorecard BS
JOIN Players P ON BS.PlayerID = P.PlayerID
ORDER BY BS.BallsFaced DESC
GO

-- DISTINCT
SELECT DISTINCT V.VenueName
FROM Matches M
JOIN Venues V ON M.VenueID = V.VenueID
GO

-- Comparison Operators
SELECT MatchID, RunsScored
FROM Innings
WHERE BattingTeamID = 1 AND RunsScored > 250
GO

-- Logical Operators
SELECT TeamName, MatchesPlayed, Points
FROM PointsTable PT
JOIN Teams T ON PT.TeamID = T.TeamID
WHERE PT.MatchesPlayed = 9 OR PT.Points = 14
GO

-- BETWEEN Operator
SELECT MatchDate, MatchID
FROM Matches
WHERE MatchDate BETWEEN '2023-11-01' AND '2023-11-30'
GO

-- LIKE, IN, NOT IN Operators
SELECT PlayerName, TeamName
FROM Players
JOIN Teams ON Players.TeamID = Teams.TeamID
WHERE PlayerName LIKE 'T%'
OR TeamName IN ('India', 'Australia', 'England')
GO

-- IS NULL Clause
SELECT P.PlayerName
FROM Players AS P
LEFT JOIN Teams AS T ON P.PlayerID = T.CaptainID
WHERE T.CaptainID IS NULL
GO

-- OFFSET FETCH
SELECT PlayerName
FROM Players
ORDER BY PlayerID
OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY
GO

-- UNION
SELECT PlayerName AS Name FROM Players
UNION
SELECT VenueName AS Name FROM Venues
GO

-- ORDER BY
SELECT PlayerName
FROM Players
ORDER BY PlayerID DESC
GO

-- WHERE
SELECT *
FROM Matches
WHERE WinnerTeamID = (SELECT TeamID FROM Teams WHERE TeamName = 'Australia')
GO

-- GROUP BY and HAVING
SELECT
TeamName, MatchesPlayed, SUM(Wins) TotalWins
FROM PointsTable PT
JOIN Teams T ON PT.TeamID = T.TeamID
GROUP BY TeamName, MatchesPlayed
HAVING MatchesPlayed > 8
GO

-- ROLLUP
SELECT T.TeamName, COUNT(P.PlayerID) AS NumberOfPlayers
FROM Players P
JOIN Teams T ON P.TeamID = T.TeamID
GROUP BY ROLLUP(T.TeamName)
GO

-- CUBE
SELECT M.Stage,
T.TeamName, COUNT(M.MatchID) AS MatchesPlayed
FROM Matches M
JOIN Teams T ON M.Team1ID = T.TeamID
GROUP BY CUBE(M.Stage, T.TeamName)
GO

-- GROUPING SETS
SELECT T.TeamName, C.CountryName, COUNT(P.PlayerID) AS NumberOfPlayers
FROM Players AS P
JOIN Teams T ON P.TeamID = T.TeamID
JOIN Countries C ON T.CountryID = C.CountryID
GROUP BY GROUPING SETS (T.TeamName,C.CountryName)
GO

-- Sub-queries (Inner)
SELECT PlayerName
FROM Players
WHERE PlayerID IN (SELECT ManOfTheMatchPlayerID FROM MatchResults)
GO

-- Sub-queries (Correlated)
SELECT TeamName
FROM Teams AS T
WHERE EXISTS 
(
    SELECT 1
    FROM MatchResults M
    JOIN Players P ON M.ManOfTheMatchPlayerID = P.PlayerID
    WHERE P.TeamID = T.TeamID
)
GO

-- EXISTS
SELECT MatchID, MatchDate
FROM Matches AS M
WHERE EXISTS (SELECT 1 FROM MatchResults AS MR WHERE MR.MatchID = M.MatchID)
GO

-- COALESCE and ISNULL
SELECT T.TeamName, P.PlayerName, ISNULL(SUM(BS.Runs), 0) AS TotalRuns, COALESCE(P.PlayerName, 'Team Total') AS GroupingLabel
FROM Teams AS T
LEFT JOIN Players P ON T.TeamID = P.TeamID
LEFT JOIN BattingScorecard BS ON P.PlayerID = BS.PlayerID
GROUP BY GROUPING SETS ((T.TeamName, P.PlayerName), (T.TeamName))
ORDER BY T.TeamName, P.PlayerName
GO

-- GROUPING Function
SELECT
    CASE 
    WHEN GROUPING(T.TeamName) = 1 THEN 'Grand Total' 
    ELSE T.TeamName END AS Team,
    COUNT(P.PlayerID) AS NumberOfPlayers
FROM Players P
JOIN Teams T ON P.TeamID = T.TeamID
GROUP BY ROLLUP (T.TeamName)
GO

-- Ranking Functions (ROW_NUMBER, RANK, DENSE_RANK, NTILE)
SELECT P.PlayerName, BS.Runs,
    ROW_NUMBER() OVER(ORDER BY BS.Runs DESC) AS RowNumber,
    RANK() OVER(ORDER BY BS.Runs DESC) AS Rank,
    DENSE_RANK() OVER(ORDER BY BS.Runs DESC) AS DenseRank,
    NTILE(4) OVER(ORDER BY BS.Runs DESC) AS Quartile
FROM BattingScorecard AS BS
JOIN  Players AS P ON BS.PlayerID = P.PlayerID
GO

-- IF...ELSE and PRINT
DECLARE @MatchWinnerID INT
SELECT @MatchWinnerID = WinnerTeamID 
FROM Matches 
WHERE MatchID = 5

IF @MatchWinnerID = (SELECT TeamID FROM Teams WHERE TeamName = 'Australia')
BEGIN
    PRINT 'Australia won Match 5.'
END
ELSE
BEGIN
    PRINT 'Australia did not win Match 5.'
END
GO