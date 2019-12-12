-- 1. show the matchid and player name for all goals scored by Germany. 

SELECT matchid, player 
FROM goal 
WHERE teamid = 'GER'

-- 2. Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
FROM game 
WHERE id = 1012

-- 3. show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate
FROM game 
JOIN goal ON (id=matchid and teamid = 'ger')

-- 4. how the team1, team2 and player for every goal scored by a player called Mario

select team1, team2, player 
FROM game 
JOIN goal 
ON (id = matchid and player like 'mario%')

-- 5. Show player, teamid, coach, gtime for all goals scored in the first 10 minutes

SELECT player, teamid, coach, gtime 
from goal 
join eteam on (teamid=id and gtime<=10)

-- 6. List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

select mdate, teamname 
from game 
join eteam on (team1 = eteam.id and eteam.coach = 'Fernando Santos')

-- 7. List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

select player 
from goal 
join game on (id = matchid and stadium = 'National Stadium, Warsaw')

-- 8. show the name of all players who scored a goal against Germany.

SELECT distinct(player)
FROM game 
JOIN goal ON matchid = id 
WHERE ((team1='GER' or team2='GER') and teamid <> 'GER')

-- 9. Show teamname and the total number of goals scored.

SELECT teamname, count(player)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname

-- 10. Show the stadium and the number of goals scored in each stadium.

select stadium, count(player) 
from game join goal on id = matchid
group by stadium

-- 11. For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid, mdate, COUNT(player) AS goals
FROM game
JOIN goal ON (matchid=id AND (team1 = 'POL' OR team2 = 'POL'))
GROUP BY matchid, mdate

-- 12. For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(teamid) AS goals
FROM game
JOIN goal ON (matchid=id AND (teamid = 'GER'))
GROUP BY matchid, mdate

-- 13. List every match with the goals scored by each team
-- If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. 
-- You could SUM this column to get a count of the goals scored by team1. 
-- Sort your result by mdate, matchid, team1 and team2.

SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 FROM
    game LEFT JOIN goal ON (id = matchid)
    GROUP BY mdate,team1,team2
    ORDER BY mdate, matchid, team1, team2