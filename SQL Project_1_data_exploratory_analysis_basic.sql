-- Exploratory Data Analysis Basic


# Maximum layoffs
# Total Layoffs company wise
# Total Layoffs Industry wise
# Total Layoffs country wise
# Total Layoffs month wise
# Total Layoffs stage wise
# Top 5 companies with max layoffs
# Top 5 industries with max layoffs


SELECT *
FROM layoffs_staging2;

# Maximum layoffs
SELECT max(total_laid_off), max(percentage_laid_off)
FROM layoffs_staging2;

# Total Layoffs company wise
SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

# Total Layoffs Industry wise
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

# Total Layoffs Country wise
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

# Total Layoffs Stage wise
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage 
ORDER BY 2 DESC;

# Total Layoffs Month wise
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `date` ASC;

# Rolling total
WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY `date` ASC
)
SELECT `MONTH`, total_off,
SUM(total_off) OVER (ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

# Top 5 companies with max layoffs
WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
),

Company_Year_Ranking AS 
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM Company_Year
)
SELECT *
FROM Company_Year_Ranking
WHERE ranking <= 5;

# Top 5 industries with max layoffs
SELECT * 
FROM layoffs_staging2;

WITH industry_layoffs (industry, years, total_laid_off) AS
(
SELECT industry, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry, YEAR(`date`)
),

industry_laid_offs_ranking AS
(
SELECT *,
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS industry_rank 
FROM industry_layoffs
)
SELECT * 
FROM industry_laid_offs_ranking
WHERE industry_rank <= 5;








