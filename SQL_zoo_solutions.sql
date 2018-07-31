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
###

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

# 11

# 12

# 13

# 14
