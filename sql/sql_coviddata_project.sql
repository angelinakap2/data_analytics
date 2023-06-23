Select *
From PortfolioProject1..CovidDeaths
order by 3, 4

Select *
From PortfolioProject1..CovidVaccinations
order by 3, 4

-- Select Data that we are going to be using
Select Location, date, total_cases, new_cases, total_deaths, population_density
from PortfolioProject1..CovidDeaths
order by 1, 2

-- Looking at Total Cases vs Total Deaths
-- shows likelihood of dying if you contract covid in the US
Select Location, date, total_cases, total_deaths, (CAST(total_deaths AS float)/CAST(total_cases AS float))*100 as DeathPercentage
from PortfolioProject1..CovidDeaths
Where Location like '%states%'
order by 1, 2


-- Looking at the Total Cases vs Population Density
Select Location, date, population_density, total_cases, (CAST(total_cases AS float)/CAST(population_density AS float))*100 as CasesPerPop
from PortfolioProject1..CovidDeaths
Where Location like '%states%'
order by 1, 2


-- Looking at countries with highest Infection Rate compared to Population Density
Select Location, population_density, MAX(total_cases) as HighestInfectionCount, (MAX(CAST(total_cases AS float))/CAST(population_density AS float))*100 as
	PercentPopulationInfected
from PortfolioProject1..CovidDeaths
Group By Location, population_density
order by PercentPopulationInfected desc


-- Showing Countries with Highest Deatch Count per Population Density

Select Location, MAX(CAST(total_deaths AS Integer)) as TotalDeathCount
from PortfolioProject1..CovidDeaths
where continent is not null /* so columns show correctly */
Group By Location
order by TotalDeathCount desc


-- LET'S BREAK THINGS DOWN BY CONTINENT

Select continent, MAX(CAST(total_deaths AS Integer)) as TotalDeathCount
from PortfolioProject1..CovidDeaths
where continent is not null
Group By continent
order by TotalDeathCount desc


-- Showing continents with the highest death count per population density

Select continent, MAX(CAST(total_deaths AS Integer)) as TotalDeathCount
from PortfolioProject1..CovidDeaths
where continent is not null
Group By continent
order by TotalDeathCount desc



-- GLOBAL NUMBERS

SET ARITHABORT OFF
SET ANSI_WARNINGS OFF
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as bigint)) as total_deaths, 
SUM(cast(new_deaths as bigint))/SUM(new_cases)*100 as DeathPercentage
from PortfolioProject1..CovidDeaths
-- Where Location like '%states%'
where continent is not null
-- Group by date
order by 1, 2



-- Looking at Total Population vs. Vaccinations

-- USE CTE
With PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as 
(
Select dea.continent, dea.location, dea.date, dea.population_density, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date)
as RollingPeopleVaccinated -- adds new vaccination to total vaccinations
From PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- order by 2, 3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac





-- TEMP TABLE
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)


Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population_density, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date)
as RollingPeopleVaccinated -- adds new vaccination to total vaccinations
From PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
-- order by 2, 3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated



-- Creating view to store data for later visualizations

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population_density, vac.new_vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location Order by dea.location, dea.date)
as RollingPeopleVaccinated -- adds new vaccination to total vaccinations
From PortfolioProject1..CovidDeaths dea
Join PortfolioProject1..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
--order by 2, 3


Select *
From PercentPopulationVaccinated
