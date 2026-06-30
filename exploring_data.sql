-- EXPLORATORY DATA ANALYSIS

-- exploring table
select*
from meoww2;

-- exploring maximmum total laid off and max percentage laid off
SELECT max(total_laid_off), MAX(percentage_laid_off)
from meoww2;

-- exploring the percentage laid off when it is 100%
select*
from meoww2
where percentage_laid_off = 1 
order by total_laid_off desc;


select*
from meoww2
where percentage_laid_off = 1 
order by funds_raised_millions desc;


-- minimum date and max date
select min(`date`), max(`date`)
from meoww2 ;


-- checking sum of tatal laid off with respect to country
select sum(total_laid_off),company
from meoww2
group by company
order by sum(total_laid_off) desc;

-- checking sum of total laid off on the basis of date
select sum(total_laid_off),`date`
from meoww2
group by `date`
order by sum(total_laid_off) desc;

-- checking sum of total laid off on the basis of industry
select sum(total_laid_off),industry
from meoww2
group by industry
order by 1 desc ;

-- checking sum of total laid off on the basis of country
select sum(total_laid_off),country
from meoww2
group by country
order by 1 desc ;

-- checking sum of total laid off on the basis of year
select sum(total_laid_off),YEAR(`date`)
from meoww2
group by YEAR(`date`)
order by YEAR(`date`) desc;

-- checking sum of total laid off on the basis of stage
select sum(total_laid_off), stage
from meoww2
group by stage
order by 2 desc;

-- checking sum of total laid off on the basis of month
SELECT SUBSTRING(`date`, 1,7) as `MONTH` , SUM(total_laid_off)
FROM meoww2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `MONTH`;

-- ROLLING TOTAL 
WITH ROLLING_TOTAL AS 
(
SELECT SUBSTRING(`date`, 1,7) as `MONTH` , SUM(total_laid_off) AS TOTAL_OFF
FROM meoww2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 asc
)
SELECT `MONTH` , TOTAL_OFF , SUM(total_off) OVER(ORDER BY `MONTH`) AS Rolling_TOTAL
FROM ROLLING_TOTAL ;

-- checking sum of total laid off on the basis of company
SELECT company , sum(total_laid_off)
from meoww2
group by company
order by 2 desc
;


SELECT company ,year(`date`), sum(total_laid_off)
from meoww2
group by company , year(`date`)
order by company desc ;

SELECT company ,year(`date`), sum(total_laid_off)
from meoww2
group by company , year(`date`)
order by 3 desc ;

with company_years (company, `year` , total_laid_off) as
(
SELECT company ,year(`date`), sum(total_laid_off)
from meoww2
group by company , year(`date`)
order by 3 desc 
), company_ranking as
(select *,
dense_rank() over(partition by `year` order by total_laid_off desc) as rank_
from company_years 
where `year` is not null
)
select *
from company_ranking 
where rank_ <= 5 ;




