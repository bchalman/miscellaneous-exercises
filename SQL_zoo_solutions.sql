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
  