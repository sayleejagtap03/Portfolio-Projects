SELECT * FROM PortfolioP1..CovidDeaths$
ORDER BY 3,4

--SELECT * FROM PortfolioP1..CovidVaccinations$
--ORDER BY 3,4

SELECT location, date, total_cases, new_cases, total_deaths, population
 FROM PortfolioP1..CovidDeaths$
 ORDER BY 1,2
 
 --LOOKING AT TOTAL CASES AND DEATHS
 SELECT location, date, total_cases,total_deaths
 FROM PortfolioP1..CovidDeaths$
 SELECT total_deaths FROM PortfolioP1..CovidDeaths$

 SELECT total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage 
 FROM PortfolioP1..CovidDeaths$
 WHERE location like '%states%'
 ORDER BY 1,2
 --shows the likelihood of dying if you contract covid in your country

 --Looking at total cases vs the population
 --shows what percentage got covid

 SELECT location, date, population, total_cases, (total_cases/population)*100 as CasesPercentage 
 FROM PortfolioP1..CovidDeaths$
 --WHERE location like '%states%'
 ORDER BY 1,2

 --looking at countries with highest infection rate
 SELECT location, population, MAX(total_cases) as HighestInfectionCount, Max((total_cases/population))*100 as PercentagePopulationInfected 
 FROM PortfolioP1..CovidDeaths$
 GROUP BY location, population
 ORDER BY PercentagePopulationInfected desc

 --showing country's with highesh death count per population

 SELECT location, MAX(cast(total_deaths as int)) as HighestDeathCount, Max((total_deaths/population))*100 as PercentPopulationDeath 
 FROM PortfolioP1..CovidDeaths$
 GROUP BY location, population
 ORDER BY PercentPopulationDeath desc

 SELECT location, MAX(total_deaths) as HighestDeathCount
 FROM PortfolioP1..CovidDeaths$
 GROUP BY location, population

 --LETS BREAK DOWN THINGS BY CONTINENT
 
 SELECT location, MAX(cast(Total_deaths as int)) as TotalDeathCount
 FROM PortfolioP1..CovidDeaths$
 WHERE continent is null
 GROUP BY location
ORDER BY TotalDeathCount DESC

SELECT continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
 FROM PortfolioP1..CovidDeaths$
 WHERE continent is not null
 GROUP BY continent
ORDER BY TotalDeathCount DESC

--showing continents with the highest deathcount PER population

SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount, MAX(total_deaths/population)*100 as DeathPopulationPercent
FROM PortfolioP1..CovidDeaths$
WHERE continent is not null
GROUP BY continent
ORDER BY DeathPopulationPercent DESC

--GLOBAL NUMBERS
SELECT SUM(new_cases) as total_cases, 
SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage -- total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioP1..CovidDeaths$
WHERE continent is not null
--GROUP BY date
ORDER BY 1,2


SELECT * FROM PortfolioP1..CovidDeaths$ dea
JOIN PortfolioP1..CovidVaccinations$  vac
ON dea.location = vac.location and  dea.date = vac.date


SELECT dea.location, dea.continent, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date)
FROM PortfolioP1..CovidDeaths$ dea
JOIN PortfolioP1..CovidVaccinations$  vac
ON dea.location = vac.location and  dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 1,2,3







