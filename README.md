# 🌍 World Layoffs SQL Data Cleaning Project

This SQL project focuses on cleaning and preparing data on global layoffs for analysis. The dataset includes company names, locations, industries, number of employees laid off, funding, and more.

---

## 📁 Contents

- `world_layoffs_project.sql`: A full SQL script for cleaning the raw data.

---

## 🧹 Cleaning Tasks Performed

1. **Removed duplicates** using `ROW_NUMBER()` and `CTEs`
2. **Trimmed whitespace** from company names
3. **Standardized values** in columns like `industry` and `country`
4. **Converted dates** from string to proper `DATE` format
5. **Handled NULLs and blanks**, especially in industry
6. **Dropped irrelevant or incomplete rows**
7. Final clean data stored in `layoff_practice2` table

---

## 🛠️ Tools Used

- MySQL
- SQL Window Functions
- CTEs and Subqueries

---

## 📌 How to Use

1. Import your raw layoff data into a table called `layoffs`
2. Run the `world_layoffs_project.sql` script in MySQL Workbench or another SQL client
3. View and analyze the cleaned data in `layoff_practice2`

---

## 👤 Author

Datamedic Vic  
[GitHub Profile](https://github.com/datamedic-vic)
