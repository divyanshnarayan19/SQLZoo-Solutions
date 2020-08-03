# The JOIN operation

-- 1. The first example shows the goal scored by a player with the last name 'Bender'. 
-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'
SELECT 
    matchid, player
FROM
    goal
WHERE
    teamid = 'Ger';
    
-- 2. Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
-- Show id, stadium, team1, team2 for just game 1012    
SELECT 
    game.id, game.stadium, game.team1, game.team2
FROM
    goal INNER JOIN game  ON goal.matchid = game.id
WHERE
    goal.matchid = 1012 AND goal.player = 'Lars Bender';
        
-- 3. Modify the query to show the player, teamid, stadium and mdate for every German goal.
SELECT 
    goal.player, goal.teamid, game.stadium, game.mdate
FROM
    goal JOIN game ON (goal.matchid = game.id)
WHERE
    goal.teamid = 'GER';
    
-- 4.Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'.
SELECT 
    game.team1, game.team2, goal.player
FROM 
	goal JOIN game ON (goal.matchid = game.id)
WHERE
    goal.player LIKE 'Mario%';        
    
-- 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
SELECT 
    goal.player, goal.teamid, eteam.coach, goal.gtime
FROM
    goal JOIN eteam ON (teamid = id)
WHERE
    gtime <= 10;

-- 6. List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
SELECT 
    game.mdate, eteam.teamname
FROM
    game JOIN eteam ON (team1 = eteam.id)
WHERE
    eteam.coach = 'Fernando Santos';    
    
-- 7.List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' 
SELECT 
    goal.player
FROM
    goal JOIN game ON (matchid = id)
WHERE
    game.stadium = 'National Stadium, Warsaw';
    
-- 8. Show the name of all players who scored a goal against Germany.
SELECT DISTINCT player
FROM game
JOIN goal ON goal.matchid = game.id
WHERE (team1 = 'GER' OR team2 = 'GER')
AND teamid <> 'GER';

-- 9. Show teamname and the total number of goals scored.
SELECT teamname, COUNT(teamid)
FROM eteam JOIN goal ON id = teamid
GROUP BY teamname;

-- 10. Show the stadium and the number of goals scored in each stadium.
SELECT 
    stadium, COUNT(matchid)
FROM
    game JOIN goal ON (id = matchid)
GROUP BY stadium;

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.
SELECT 
    matchid, MAX(mdate), COUNT(player) goals_scored
FROM
    game JOIN goal ON goal.matchid = game.id
WHERE
    (team1 = 'POL' OR team2 = 'POL')
GROUP BY goal.matchid;

-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'.
SELECT 
    matchid, MAX(mdate), COUNT(player) goals_scored
FROM
    game JOIN goal ON goal.matchid = game.id
WHERE
    teamid = 'GER'
GROUP BY goal.matchid;

-- 13. List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
SELECT game.mdate, game.team1, 
SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) AS score1,
game.team2,
SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) AS score2

FROM game LEFT JOIN goal ON matchid = id
GROUP BY game.id,game.mdate, game.team1, game.team2 
ORDER BY mdate,matchid,team1,team2;



