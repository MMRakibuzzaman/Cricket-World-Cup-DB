# Cricket Tournament Management System (CTMS)

## 📌 Project Overview
[cite_start]The **Cricket Tournament Management System (CTMS)** is a relational database project designed to manage data for the **ICC ODI World Cup 2023**[cite: 1, 4]. [cite_start]It tracks teams, players, matches, venues, and detailed scorecards (batting and bowling) with high precision[cite: 2].

[cite_start]The goal of this project is to model complex tournament data into a functional SQL Server database to analyze team strategies and player performances[cite: 6].

## ⚙️ Tech Stack
* **Database Engine:** Microsoft SQL Server 2022
* **Language:** T-SQL (DDL & DML)
* **Concepts Used:** Normalization, Constraints, Joins, Sub-queries, Triggers.

## 📂 Database Schema
[cite_start]The database consists of **14 normalized tables** [cite: 13] handling various aspects of cricket:
* **Core Entities:** `Teams`, `Players`, `Countries`, `Venues`, `Umpires`.
* **Match Logic:** `Matches`, `MatchOfficials`, `MatchResults`, `PointsTable`.
* **Scoring System:** `Innings`, `BattingScorecard`, `BowlingScorecard`.

## 🚀 Key Features (SQL Objects)
This project goes beyond basic tables by implementing advanced SQL objects found in `DDL.sql`:

### 1. Views
* `Vw_MatchDetailsView`: A complex join view that displays match dates, venues, and team names in a readable format.

### 2. Stored Procedures
* `Sp_GetMatchWinner`: Retrieves the winner of a specific match.
* `Sp_GetPlayerBattingScorecard`: Fetches run details for a specific player in an innings.

### 3. Functions (UDFs)
* `Fn_GetTeamPlayers`: A table-valued function returning all players for a specific team.
* `Fn_GetFullBattingScorecard`: A multi-statement function generating a full scorecard table.

### 4. Triggers
* `Tr_InsertBattingScorecard`: **Automation.** When a player's score is added, this trigger automatically updates the total `RunsScored` and `WicketsLost` in the main `Innings` table.
* `Tr_InsteadOfDeleteVenue`: **Safety.** Prevents the accidental deletion of Venues that are already linked to a Match.

## 📊 Data Analysis
[cite_start]The `DML.sql` script populates the database with real-world 2023 World Cup data [cite: 21] and includes queries for:
* **Complex Analysis:** Using `GROUP BY`, `ROLLUP`, and `CUBE` for match statistics.
* **Ranking:** Using `DENSE_RANK()` and `ROW_NUMBER()` to rank players by runs.
* **Logical Operations:** Filtering matches using `EXISTS`, `COALESCE`, and implicit joins.

## 🛠️ How to Run
1.  Open **SSMS** (SQL Server Management Studio).
2.  Open `SQL/DDL.sql` and execute it to build the schema.
3.  Open `SQL/DML.sql` and execute it to load the data.
4.  Check the views and functions provided in the scripts.