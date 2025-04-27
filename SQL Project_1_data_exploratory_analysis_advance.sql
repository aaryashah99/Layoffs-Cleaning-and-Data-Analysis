-- Exploratory Analysis Advance


# Companies with the highest percentage of layoffs
# Monthly Trend of Layoffs for the Top 5 Industries
# Companies with Layoffs Across Multiple Locations
# Industries with the Most Frequent Layoffs
# Countries with the Highest Percentage of Layoffs
# Layoffs Based on Funding Raised
# Most Affected Company in Each Industry
# Layoff Trends Before and After Funding Rounds
# Industries Where 100% Layoffs Happened Most
# Peak Layoff Month for Each Year


# Companies with the highest percentage of layoffs
SELECT company, MAX(percentage_laid_off) AS max_percentage_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY max_percentage_laid_off DESC
LIMIT 10;

# Monthly Trend of Layoffs for the Top 5 Industries
WITH top_industries AS 
(
SELECT industry, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC
LIMIT 5
)
SELECT SUBSTRING(`date`, 1, 7) AS `MONTH`, industry, SUM(total_laid_off) AS layoffs
FROM layoffs_staging2
WHERE industry IN (SELECT industry FROM top_industries)
GROUP BY `MONTH`, industry
ORDER BY `MONTH` ASC, layoffs DESC;

# Companies with Layoffs Across Multiple Locations
SELECT company, COUNT(DISTINCT location) AS num_locations
FROM layoffs_staging2
GROUP BY company
HAVING num_locations > 1
ORDER BY num_locations DESC;

# Industries with the Most Frequent Layoffs
SELECT industry, COUNT(*) AS layoff_events
FROM layoffs_staging2
GROUP BY industry
ORDER BY layoff_events DESC
LIMIT 10;

# Countries with the Highest Percentage of Layoffs
SELECT country, AVG(percentage_laid_off) AS avg_percentage_laid_off
FROM layoffs_staging2
GROUP BY country
ORDER BY avg_percentage_laid_off DESC
LIMIT 10;

# Layoffs Based on Funding Raised
SELECT 
    CASE 
        WHEN funds_raised_millions < 50 THEN 'Less than 50M'
        WHEN funds_raised_millions BETWEEN 50 AND 200 THEN '50M - 200M'
        WHEN funds_raised_millions BETWEEN 200 AND 500 THEN '200M - 500M'
        ELSE 'More than 500M'
    END AS funding_bracket,
    SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY funding_bracket
ORDER BY total_layoffs DESC;

# Most Affected Company in Each Industry
WITH industry_max AS (
    SELECT industry, company, SUM(total_laid_off) AS total_layoffs,
           RANK() OVER (PARTITION BY industry ORDER BY SUM(total_laid_off) DESC) AS ranks
    FROM layoffs_staging2
    GROUP BY industry, company
)
SELECT industry, company, total_layoffs
FROM industry_max
WHERE ranks = 1;

# Layoff Trends Before and After Funding Rounds
SELECT stage, COUNT(*) AS layoff_events, SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_layoffs DESC;

# Industries Where 100% Layoffs Happened Most
SELECT industry, COUNT(*) AS num_companies_shut_down
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY industry
ORDER BY num_companies_shut_down DESC;

# Peak Layoff Month for Each Year
WITH monthly_layoffs AS (
    SELECT YEAR(`date`) AS layoff_year, MONTH(`date`) AS layoff_month, SUM(total_laid_off) AS total_layoffs
    FROM layoffs_staging2
    GROUP BY layoff_year, layoff_month
),
ranked_months AS (
    SELECT *, RANK() OVER (PARTITION BY layoff_year ORDER BY total_layoffs DESC) AS ranks
    FROM monthly_layoffs
)
SELECT layoff_year, layoff_month, total_layoffs
FROM ranked_months
WHERE ranks = 1;