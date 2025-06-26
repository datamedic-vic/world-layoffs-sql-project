# 🌍 World Layoffs SQL Data Cleaning Project

This project focuses on cleaning and preparing a dataset of global tech layoffs using MySQL. It includes the raw data and the SQL cleaning script.

---

## 📁 Contents

- `data/raw_layoffs_data.csv`: The original dataset (before cleaning)
- `world_layoffs_project.sql`: SQL script used for cleaning the data

---

## 🧹 Cleaning Steps Performed

1. Removed duplicate rows using window functions
2. Trimmed and standardized text values (e.g., `industry`, `company`)
3. Converted `date` column from string to `DATE` format
4. Filled missing `industry` values using other rows from same company
5. Dropped irrelevant or incomplete records
6. Final cleaned data stored in `layoff_practice2`

---

## 📊 Dataset Overview

The raw dataset includes:

- Company name
- Location
- Industry
- Total laid off
- Percentage laid off
- Date
- Stage of funding
- Country
- Funds raised (millions)

---

## 🚀 How to Use

1. Import the `raw_layoffs_data.csv` into a MySQL table called `layoffs`
2. Run `world_layoffs_project.sql` to clean the data
3. Use the cleaned data in `layoff_practice2` for your analysis

---

## 👤 Author

Datamedic Vic  
[GitHub Profile](https://github.com/datamedic-vic)
