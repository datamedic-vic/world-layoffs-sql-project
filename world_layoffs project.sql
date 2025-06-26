-- Data Cleaning

SELECT 
    *
FROM
    layoffs;
    
-- 1. Removing Duplicates
-- 2. Standardize the Data
-- 3. Null values or blank values
-- 4. Remove any irrelevant column

CREATE TABLE layoff_practice
LIKE layoffs;

INSERT layoff_practice
SELECT *
FROM layoffs;

SELECT *
FROM layoff_practice;


-- 1. Removing the duplicates:

SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoff_practice;

#create a cte to identify duplicate row_num
WITH duplicate_cte AS
	(SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoff_practice)
SELECT *
FROM duplicate_cte
WHERE row_num >1;

SELECT *
FROM layoff_practice
WHERE company = 'hibob';

#create a new table to insert row_num and delete duplicates
DROP TABLE IF EXISTS layoff_practice2;
 CREATE TABLE `layoff_practice2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
#insert data from layoff_practice into layoff_practice2
INSERT INTO layoff_practice2
SELECT *, 
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoff_practice;

SELECT *
FROM layoff_practice2
WHERE row_num >1;

#delete duplicates
DELETE
FROM layoff_practice2
WHERE row_num >1;


-- 2: Standardizing the data

SELECT *
FROM layoff_practice2;

#unnecessary spaces in the company column
SELECT company, (TRIM(company))
FROM layoff_practice2;

UPDATE layoff_practice2
SET company = (TRIM(company));

SELECT DISTINCT industry
FROM layoff_practice2
ORDER BY 1;

#multiple cryptocurrency industries
SELECT DISTINCT industry
FROM layoff_practice2
ORDER BY 1;

SELECT DISTINCT industry
FROM layoff_practice2
WHERE industry LIKE 'crypto%';

UPDATE layoff_practice2
SET industry = 'Crypto'
WHERE industry LIKE 'crypto%';

#review all columns for errors and make updates where necessary
SELECT DISTINCT country
FROM layoff_practice2
ORDER BY 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoff_practice2
WHERE country LIKE 'united states%';

UPDATE layoff_practice2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'united states%';

SELECT DISTINCT country
FROM layoff_practice2
ORDER BY 1;

#Date column is in text format, convert to DATE formate
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') AS date
FROM layoff_practice2;

UPDATE layoff_practice2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoff_practice2;

#change date data type from text to date data type (do not do this on your raw data)
ALTER TABLE layoff_practice2
MODIFY COLUMN `date` DATE;


-- 3. Null values or blank values

SELECT *
FROM layoff_practice2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoff_practice2
WHERE industry IS NULL 
OR industry = '';

SELECT *
FROM layoff_practice2
WHERE company = 'Airbnb';

#since the 2nd Airbnb is travel, the 1st row can be populated to be travel too
#convert blanks to NULLS
UPDATE layoff_practice2
SET industry = null
WHERE industry = '';

SELECT tab1.industry, tab2.industry
FROM layoff_practice2 AS tab1
JOIN layoff_practice2 AS tab2
	ON tab1.company = tab2.company
		AND tab1.location = tab2.location
WHERE (tab1.industry IS NULL)
AND tab2.industry IS NOT NULL;

 
UPDATE layoff_practice2 AS tab1
JOIN layoff_practice2 AS tab2
	ON tab1.company = tab2.company
SET tab1.industry = tab2.industry
WHERE (tab1.industry IS NULL OR tab1.industry = '')
AND tab2.industry IS NOT NULL;

SELECT *
FROM layoff_practice2;


-- 4. Remove any irrelevant column
DELETE
FROM layoff_practice2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoff_practice2;

ALTER TABLE layoff_practice2
DROP COLUMN row_num;

#finalized clean data
SELECT *
FROM layoff_practice2;