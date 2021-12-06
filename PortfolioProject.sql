use PortfolioProject
select * from CovidDeaths
--there are two wxisting tables, coviddeaths and covidvaccinations. each of them contain both different and similar data(like countries and population)
--lets use sql queries to explore data
select * from CovidVaccinations
--lets see which country has most covid cases
select location, sum(new_cases) as TotalCases from CovidDeaths where continent is not null group by location order by totalcases desc 
-- as we now know, india has most total cases.
-- now lets see which country has most total deaths
select location,sum(new_deaths) as TotalDeaths from coviddeaths
where continent is not null group by location order by totaldeaths desc
--as we can see, brazil has most deaths.
--now lets see which country has highest death/population ratio

select location, population, sum(new_deaths) as TotalDeaths, (sum(new_deaths)/population)*100 as DeathPercentage from CovidDeaths 
where continent is not null group by population,location order by 4 desc
-- as we can see, bulgaria has highest death percentage, as high as 0.41%
--now lets see which one has lowest death percentage
select location, population, sum(new_deaths) as TotalDeaths, (sum(new_deaths)/population)*100 as DeathPercentage from CovidDeaths 
where continent is not null  group by population,location order by 4 
--as we can see, burundi has lowest deathpercentage - 0.0003%
--now, lets see the average of new cases every day 
--first, lets create new table which will show us date and new cases that day from all around the world
select distinct date, sum(new_cases) as NewCasesPerDay into NewCases from coviddeaths group by date
select * from NewCases order by date
--now, lets count average of NewCasesPerDat
select avg(newcasesperday) from newcases
--As we can see, there are on average 675636 new cases per day
--now, suppose we want to know on average how many new cases was between 01.06.2020 and 01.09.2020
select avg(newcasesperday) as AvgNewCases from newcases where date between '2020-06-01' and '2020-09-01'
-- as we can see, between 2020-06-01 and 2020-09-01 there where on average 286310 new cases per day
--suppose we want to create list of Green countries which will be top 10% of least total cases we will name this table GreenCountries
 select top 25 percent location, population, sum(new_cases) as TotalCases into GreenCountries from coviddeaths
 where coviddeaths.continent is not null group by location,population order by TotalCases asc
 select * from GreenCountries
 --so, now we have list of 27 countries which have the least total cases.