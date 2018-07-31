### SELECT basics
# 1
  SELECT population FROM world
    WHERE name = 'Germany'
# 2
  SELECT name, population FROM world
    WHERE name IN ( 'Sweden', 'Norway','Denmark');
# 3
  SELECT name, area FROM world
    WHERE area BETWEEN 200000 AND 250000 
    
    
### SELECT name
  # how did this get skipped? 
  
  
### SELECT from WORLD Tutorial
# 1
  SELECT name, continent, population FROM world
# 2
  SELECT name FROM world
    WHERE population > 200000000
# 3
  SELECT name, gdp / population FROM world
    WHERE population > 200000000
# 4
  SELECT name, population / 1000000 FROM world
    WHERE continent IN ('South America')
# 5
  SELECT name, population FROM world
    WHERE name IN ( 'France', 'Germany', 'Italy' )
# 6
  SELECT name FROM world
    WHERE name LIKE '%United%'
# 7
  SELECT name, population, area FROM world
    WHERE area > 3000000 OR population > 250000000
# 8
  SELECT name, population, area FROM world
    WHERE area > 3000000 XOR population > 250000000
# 9
  SELECT name, 
      ROUND(population/1000000,2), 
      ROUND(GDP / 1000000000,2) FROM world
    WHERE continent IN ('South America')
# 10
  SELECT name , 
      ROUND(GDP / population , -3) FROM world
    WHERE GDP > 1000000000000
# 11
  SELECT name, capital FROM world
    WHERE LENGTH(name) = LENGTH(capital)
# 12
  SELECT name, capital FROM world
    WHERE name != capital  AND LEFT(name,1) = LEFT(capital ,1)
# 13  
  SELECT name FROM world
    WHERE name NOT LIKE '% %'
      AND name LIKE '%a%'
      AND name LIKE '%e%'
      AND name LIKE '%i%'
      AND name LIKE '%o%'
      AND name LIKE '%u%'
  
### SELECT from Nobel Tutorial
# 1
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950
 
# 1
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950
# 2
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
# 3
SELECT yr ,subject
  FROM nobel
 WHERE winner =  'Albert Einstein'
# 4
SELECT winner
  FROM nobel
 WHERE yr >= 2000
   AND subject = 'Peace'
# 5
SELECT *
  FROM nobel
 WHERE yr BETWEEN 1980 AND 1989 
   AND subject = 'Literature'
# 6
SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')
# 7
SELECT winner FROM nobel
 WHERE winner LIKE 'John%'
# 8
SELECT * FROM nobel
 WHERE yr = 1980 AND subject = 'Physics'
  OR yr = 1984 AND subject = 'Chemistry'
# 9
SELECT * FROM nobel
 WHERE yr = 1980
  AND subject NOT IN ('Chemistry' , 'Medicine')
# 10
SELECT * FROM nobel
 WHERE subject = 'Medicine' AND yr < 1910
  OR subject = 'Literature' AND yr >= 2004
# 11
SELECT * FROM nobel
 WHERE winner = 'PETER GRÜNBERG'
# 12
SELECT * FROM nobel
 WHERE winner = 'EUGENE O''NEILL'
# 13
SELECT winner, yr, subject FROM nobel
 WHERE winner LIKE 'sir %'
  ORDER BY yr  DESC
# 14
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry') , subject , winner
 
 
### SELECT within SELECT Tutorial

# 1
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')
# 2
SELECT name FROM world
  WHERE continent = 'Europe' 
    AND gdp/population >
      (SELECT gdp/population  FROM world
       WHERE name='United Kingdom')
# 3
SELECT name , continent FROM world
  WHERE continent IN
      (SELECT continent FROM world
       WHERE name IN ('Argentina' , 'Australia'))
 ORDER BY name
# 4
SELECT name , population FROM world
  WHERE population >
      (SELECT population FROM world
       WHERE name = 'Canada')
  AND population <
      (SELECT population FROM world
       WHERE name = 'Poland')
# 5
SELECT name , ROUND (100 * population / (SELECT population FROM world
                                          WHERE name = 'Germany'))
               || '%'
 FROM world
  WHERE continent = 'Europe'
# 6
SELECT name 
  FROM world
 WHERE gdp > ALL(SELECT gdp
                   FROM world
                  WHERE gdp>0
                   AND continent = 'Europe' )
# 7
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area >0)
# 8
SELECT continent, name FROM world x
  WHERE name =
    (SELECT name FROM world y
        WHERE y.continent=x.continent
          ORDER BY name LIMIT 1)
# 9
SELECT name, continent, population FROM world x
  WHERE 25000000 >
    ALL(SELECT population FROM world y
        WHERE y.continent=x.continent
          AND  population > 0)
# 10
SELECT name, continent FROM world x
  WHERE population / 3 >=
    ALL(SELECT population FROM world y
        WHERE y.continent=x.continent
          AND  population > 0
          AND name NOT IN (SELECT name FROM world x
                            WHERE population >=
                              ALL(SELECT population FROM world y
                                  WHERE y.continent=x.continent
                                    AND  population > 0)
) )


### SUM and COUNT

# 1
 SELECT SUM(population)
  FROM world
# 2
SELECT DISTINCT continent
 FROM world
# 3
SELECT SUM(gdp)
 FROM world
  WHERE continent = 'Africa'
# 4
SELECT COUNT(name)
 FROM world
  WHERE  area > 1000000
# 5
SELECT SUM(population )
 FROM world
  WHERE  name IN ('Estonia', 'Latvia', 'Lithuania')
# 6
SELECT continent , COUNT(name)
 FROM world
  GROUP BY continent
# 7
SELECT continent , COUNT(name)
 FROM world
  WHERE population > 10000000
  GROUP BY continent
# 8
SELECT continent
 FROM world
  GROUP BY continent
   HAVING SUM(population) > 100000000
   
   
### The JOIN operation

# 1
SELECT matchid , player FROM goal 
  WHERE teamid = 'GER'
# 2
SELECT id,stadium,team1,team2
  FROM game
   WHERE id = 1012
# 3
SELECT player, teamid, stadium , mdate
  FROM game JOIN goal ON (id=matchid)
    WHERE teamid = 'GER'
# 4
SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
    WHERE player LIKE 'Mario%'
# 5
SELECT player, teamid,coach, gtime
  FROM goal JOIN eteam ON teamid=id
 WHERE gtime<=10
# 6
SELECT mdate  ,teamname
  FROM game 
   JOIN eteam ON (team1=eteam.id)
 WHERE coach =  'Fernando Santos'
# 7
SELECT player
  FROM game 
   JOIN goal ON (game.id=matchid)
    WHERE stadium = 'National Stadium, Warsaw'
# 8
SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE ((team1='GER' OR team2='GER') 
      AND teamid != 'GER')
# 9
SELECT teamname, COUNT(gtime) Goals
  FROM eteam JOIN goal ON id=teamid
   GROUP BY (teamname)
    ORDER BY teamname
# 10
SELECT stadium , COUNT(gtime) Goals
  FROM game 
   JOIN goal ON (game.id=matchid)
    GROUP BY stadium
# 11
SELECT matchid , mdate,  COUNT(gtime) Goals
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
 GROUP BY matchid , mdate
# 12
SELECT matchid, mdate, COUNT(gtime) Goals
  FROM game JOIN goal ON matchid = id 
    WHERE ((team1='GER' OR team2='GER') 
      AND teamid = 'GER')
 GROUP BY matchid, mdate
# 13
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid=team1 THEN 1 ELSE 0 END) score1 ,
  team2,
  SUM(CASE WHEN teamid=team2 THEN 1 ELSE 0 END) score2
  FROM game LEFT JOIN goal ON matchid = id
  GROUP BY mdate, team1, team2
    ORDER BY  mdate, matchid
    
    
### More JOIN operations

# 1
SELECT id, title
 FROM movie
 WHERE yr=1962
# 2
SELECT yr
 FROM movie
 WHERE title = 'Citizen Kane'
# 3
SELECT id , title , yr
 FROM movie
 WHERE title LIKE '%Star Trek%'
   ORDER BY yr
# 4
SELECT id
 FROM actor
   WHERE name = 'Glenn Close'
# 5
SELECT id
 FROM movie
   WHERE title = 'Casablanca'
# 6
SELECT name FROM casting
JOIN actor ON actorid = actor.id
WHERE movieid = (
   SELECT id
    FROM movie
      WHERE title = 'Casablanca')
# 7
SELECT name FROM casting
JOIN actor ON actorid = actor.id
WHERE movieid = (
   SELECT id
    FROM movie
      WHERE title = 'Alien')
# 8
SELECT title
    FROM casting
JOIN movie ON movieid = movie.id
  WHERE actorid = (
   SELECT id
    FROM actor
      WHERE name= 'Harrison Ford')
# 9
SELECT title
    FROM casting
JOIN movie ON movieid = movie.id
  WHERE actorid = (
   SELECT id
    FROM actor
      WHERE name= 'Harrison Ford')
    AND ord != 1
# 10
Select  title , name
  FROM movie
   JOIN casting ON movie.id = movieid
   JOIN actor ON actor.id = actorid
  WHERE ord = 1
  AND yr = 1962
# 11
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)
# 12
SELECT DISTINCT title,  (SELECT name FROM actor
                    WHERE actor.id=lead.actorid) Lead
 FROM casting
  JOIN movie ON movieid = movie.id
  JOIN casting AS lead ON casting.movieid = lead.movieid
WHERE casting.actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews')
  AND lead.ord = 1
# 13
 SELECT name FROM actor
 WHERE id IN (SELECT actorid FROM casting
                WHERE ord = 1
                GROUP BY actorid
                   HAVING COUNT(actorid) >= 30)
# 14
SELECT title, COUNT(actorid) FROM casting
 JOIN movie ON movieid = movie.id
   WHERE yr = 1978
     GROUP BY title
      ORDER BY COUNT(actorid) DESC , title
# 15
SELECT DISTINCT name FROM casting
 JOIN actor ON actor.id = actorid
  WHERE movieid IN (
    SELECT movieid FROM casting
      WHERE actorid = (
       SELECT id
        FROM actor
          WHERE name= 'Art Garfunkel'))
   AND name != 'Art Garfunkel'



###  Using Null

# 1
SELECT name FROM teacher
 WHERE dept IS NULL
# 2
SELECT teacher.name, dept.name
 FROM teacher INNER JOIN dept
           ON (teacher.dept=dept.id)
# 3
SELECT teacher.name, dept.name
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
# 4
SELECT teacher.name, dept.name
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)
# 5
SELECT teacher.name , COALESCE(mobile , '07986 444 2266')  FROM teacher
# 6
SELECT teacher.name, COALESCE(dept.name , 'None')
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
# 7
SELECT COUNT(teacher.name) , COUNT(mobile )  FROM teacher
# 8
SELECT dept.name , COUNT (teacher.name)
 FROM teacher RIGHT JOIN dept
           ON (teacher.dept=dept.id)
  GROUP BY (dept.name)
# 9
SELECT teacher.name , CASE WHEN dept = 1 OR dept = 2 THEN 'Sci'
                ELSE 'Art' END AS cat
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)
# 10
SELECT teacher.name , CASE WHEN dept = 1 OR dept = 2 THEN 'Sci'
                           WHEN dept = 3 THEN 'Art'
                           ELSE 'None' END AS cat
 FROM teacher LEFT JOIN dept
           ON (teacher.dept=dept.id)



###  NSS Tutorial

# 1
SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science'
# 2
SELECT institution , subject
  FROM nss
  WHERE question='Q15'
    AND score >= 100
# 3
SELECT institution,score
  FROM nss
 WHERE question='Q15'
   AND subject='(8) Computer Science'
   AND score < 50
# 4
SELECT subject , SUM(response)
  FROM nss
  WHERE question='Q22'
  GROUP BY subject
    HAVING subject='(8) Computer Science'
        OR subject='(H) Creative Arts and Design'
# 5
SELECT subject , SUM(A_STRONGLY_AGREE*response/100)
  FROM nss
  WHERE question='Q22'
  GROUP BY subject
    HAVING subject='(8) Computer Science'
        OR subject='(H) Creative Arts and Design'
# 6
SELECT subject , ROUND(SUM(A_STRONGLY_AGREE*response) / SUM(response) )
  FROM nss
  WHERE question='Q22'
  GROUP BY subject
    HAVING subject='(8) Computer Science'
        OR subject='(H) Creative Arts and Design'
# 7
SELECT institution , ROUND(SUM(score*response) / SUM(response))
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
 GROUP BY institution
# 8
SELECT institution , SUM(sample) , SUM(CASE WHEN subject = '(8) Computer Science' THEN sample END) AS comp
  FROM nss
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
   # AND subject = '(8) Computer Science'
   GROUP BY institution


### Self join

# 1

# 2

# 3

# 4

# 5

# 6

# 7

# 8

# 9

# 10

