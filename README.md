Layoffs Data Analysis and Cleaning

This project focuses on cleaning and analyzing layoffs data (from the layoffs2024 table). It covers the stages of data preprocessing (including data cleaning and standardization) and explores insights from the data using basic and advanced exploratory data analysis (EDA) techniques.

Part 1: Data Cleaning
In this phase, the following steps were performed on the layoffs2024 data:
Removing Duplicates: Identified and removed duplicate records based on multiple features such as company, location, industry, total_laid_off, etc.
Standardizing Data: Fixed inconsistencies in the data, including removing leading/trailing spaces in company names and converting date columns from text format to proper date format.
Handling Null and Blank Values: Cleaned rows with missing values in critical columns (total_laid_off, percentage_laid_off) by deleting them.
Dropping Unnecessary Columns: Removed columns that were redundant or not useful for analysis.
The cleaned data is stored in a staging table (layoffs_staging2) for further analysis.

Part 2: Basic Exploratory Data Analysis (EDA)
Basic EDA was conducted to understand the distribution of layoffs data, with the following analyses:
Total Layoffs by Company, Industry, Country, Stage, and Month: Grouped data to identify the total number of layoffs across different dimensions.
Top 5 Companies and Industries with Maximum Layoffs: Identified the companies and industries with the highest total layoffs.
Maximum Layoffs: Found the maximum number of layoffs and percentage of layoffs across companies and industries.
Rolling Total of Layoffs: Calculated a rolling total of layoffs by month for trend analysis.

Part 3: Advanced Exploratory Data Analysis (EDA)
Advanced analyses were carried out to uncover deeper insights, including:
Companies with the Highest Percentage of Layoffs: Analyzed companies with the highest percentage of layoffs.
Monthly Trend of Layoffs for the Top 5 Industries: Identified trends in layoffs over time for industries with the highest layoffs.
Companies with Layoffs Across Multiple Locations: Analyzed companies that had layoffs in more than one location.
Layoffs Based on Funding Raised: Investigated layoffs across different funding brackets to see if there’s a correlation between company funding and layoffs.
Industries with the Most Frequent Layoffs: Identified industries with the highest number of layoff events.
Peak Layoff Month for Each Year: Identified the month with the highest layoffs for each year.
This project is intended to provide actionable insights into the trends and factors associated with layoffs, including the impact of industry, location, and funding.

Technologies Used
SQL
Data Cleaning and Transformation Techniques
Exploratory Data Analysis (EDA)
