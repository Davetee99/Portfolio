SELECT * 
FROM covid_deaths;


SELECT *
FROM covid_vaccinations;

--Case and death counts
SELECT LOCATION, date, total_cases, new_cases, total_deaths, population 
FROM covid_deaths
WHERE (LOCATION = 'World' AND date = '2023-01-30')
	OR (LOCATION = 'United States' AND date = '2023-01-30')
	OR (LOCATION = 'Canada' AND date = '2023-01-30')
	OR (LOCATION = 'Mexico' AND date = '2023-01-30')
ORDER BY 3 DESC;


 --Looking at Total Cases vs Total Death percentage


SELECT LOCATION, date, population , total_cases,total_deaths,
	ROUND((total_deaths::numeric/total_cases::numeric)*100, 2) AS death_percent
FROM covid_deaths
WHERE (LOCATION = 'World' AND date = '2023-01-30')
	OR (LOCATION = 'United States' AND date = '2023-01-30')
	OR (LOCATION = 'Canada' AND date = '2023-01-30')
	OR (LOCATION = 'Mexico' AND date = '2023-01-30')
ORDER BY 3 DESC;

-- infection percent vs death percent
SELECT LOCATION, date AS as_of, population, total_cases, total_deaths, total_cases/population::float*100 AS infected_percentage, ROUND((total_deaths::numeric/total_cases::numeric)*100, 2) AS death_percentage
FROM covid_deaths
WHERE  (LOCATION = 'World' AND date = '2023-01-30')
	OR (LOCATION = 'United States' AND date = '2023-01-30')
	OR (LOCATION = 'Canada' AND date = '2023-01-30')
	OR (LOCATION = 'Mexico' AND date = '2023-01-30')
ORDER BY 3 DESC;


--fully vaccinated *Mexico does not have accurate records
SELECT LOCATION, date AS as_of, people_fully_vaccinated
FROM covid_vaccinations cv 
WHERE  (LOCATION = 'World' AND date = '2023-01-30')
	OR (LOCATION = 'United States' AND date = '2023-01-30')
	OR (LOCATION = 'Canada' AND date = '2023-01-30')
	OR (LOCATION = 'Mexico' AND date = '2023-01-30')
ORDER BY 3 DESC;

-- Joined tables for full view of data
SELECT cd.LOCATION, cd.date AS as_of, cd.population, cd.total_cases, cd.total_deaths, 
    ROUND((cd.total_cases::numeric/cd.population::numeric*100),2) AS infected_percentage, 
    ROUND((cd.total_deaths::numeric/cd.total_cases::numeric)*100, 2) AS death_percentage,
    cv.people_fully_vaccinated
FROM covid_deaths cd
JOIN covid_vaccinations cv
ON cd.date = cv.date AND cd.LOCATION = cv.LOCATION
WHERE  (cd.LOCATION = 'United States' AND cd.date = '2023-01-30')
	OR (cd.LOCATION = 'Canada' AND cd.date = '2023-01-30')
	OR (cd.LOCATION = 'Mexico' AND cd.date = '2023-01-30')
ORDER BY 3 DESC;

-- Joined tables for full view of data(World included)
SELECT cd.LOCATION, cd.date AS as_of, cd.population, cd.total_cases, cd.total_deaths, 
    ROUND((cd.total_cases::numeric/cd.population::numeric*100),2) AS infected_percentage, 
    ROUND((cd.total_deaths::numeric/cd.total_cases::numeric)*100, 2) AS death_percentage,
    cv.people_fully_vaccinated
FROM covid_deaths cd
JOIN covid_vaccinations cv
ON cd.date = cv.date AND cd.LOCATION = cv.LOCATION
WHERE  (cd.LOCATION = 'World' AND cd.date = '2023-01-30')
	OR (cd.LOCATION = 'United States' AND cd.date = '2023-01-30')
	OR (cd.LOCATION = 'Canada' AND cd.date = '2023-01-30')
	OR (cd.LOCATION = 'Mexico' AND cd.date = '2023-01-30')
ORDER BY 3 DESC;



