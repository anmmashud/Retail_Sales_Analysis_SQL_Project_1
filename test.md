
# Retail Sales Analysis SQL Project 1

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project demonstrates SQL skills and techniques commonly used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. It is ideal for those starting their journey in data analysis and seeking to build a solid foundation in SQL.

---

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

---

## Project Structure

### 1. **Database Setup**

- **Database Creation**: Create a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
DROP DATABASE IF EXISTS p1_retail_db;

CREATE DATABASE p1_retail_db;

USE p1_retail_db;

DROP TABLE IF EXISTS retail_sales;

CREATE TABLE retail_sales (
    transaction_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

### 2. **Data Exploration & Cleaning**

**Import Data from the CSV file**:  
[Download SQL_Retail_Sales_Analysis.csv](https://raw.githubusercontent.com/anmmashud/Retail_Sales_Analysis_SQL_Project_1/main/SQL_Retail_Sales_Analysis.csv)

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find the number of unique customers.
- **Category Count**: Identify all unique product categories.
- **Null Value Check**: Check for null values and remove records with missing data.

```sql
-- Identify Rows with Null Values
SELECT * 
FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;

-- Delete Rows with Null Values
DELETE FROM retail_sales
WHERE transaction_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

---

### 3. **Data Analysis & Business Queries**

#### Query 1: Total Number of Sales
```sql
SELECT COUNT(*) AS total_sales 
FROM retail_sales;
```

#### Query 2: Unique Customers
```sql
SELECT COUNT(DISTINCT customer_id) AS unique_customers 
FROM retail_sales;
```

#### Query 3: Unique Categories
```sql
SELECT DISTINCT category 
FROM retail_sales;
```

#### Query 4: Total Sales by Category
```sql
SELECT category, SUM(total_sale) AS total_sales 
FROM retail_sales
GROUP BY category;
```

#### Query 5: Transactions on a Specific Date (e.g., 2022-11-05)
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

#### Query 6: Transactions for 'Clothing' in November 2022
```sql
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11';
```

#### Query 7: Average Age of Customers for the 'Beauty' Category
```sql
SELECT AVG(age) AS average_age 
FROM retail_sales
WHERE category = 'Beauty';
```

#### Query 8: Top 5 Customers by Total Sales
```sql
SELECT customer_id, SUM(total_sale) AS total_sales 
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

#### Query 9: Transactions by Gender and Category
```sql
SELECT gender, category, COUNT(transaction_id) AS total_transactions 
FROM retail_sales
GROUP BY gender, category;
```

#### Query 10: Sales Shifts and Order Counts
```sql
SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transaction_id) AS total_orders
FROM retail_sales
GROUP BY shift;
```

---

## Findings

- **Sales Patterns**: Sales are distributed across various categories and demographics.
- **Customer Insights**: The 'Clothing' category has the highest number of unique customers.
- **High-Value Transactions**: A significant number of transactions exceed a total sale value of 1000.

---

## Reports

1. **Sales Summary**: Total sales, customer demographics, and category performance.
2. **Trend Analysis**: Insights into monthly sales trends.
3. **Customer Insights**: Top customers and unique customer counts per category.

---

## How to Use This Project

1. **Clone the Repository**: Download the project files from the GitHub repository.
2. **Set Up the Database**: Execute the provided SQL scripts to create and populate the database.
3. **Run the Queries**: Use the sample queries for analysis and customization.
4. **Explore Further**: Modify queries or add new ones to generate additional insights.

## Author - A. N. M. Mashud

For questions, feedback, or collaboration, feel free to reach out via social media:

- **YouTube**: [@anmmashud](https://www.youtube.com/@anmmashud)  
- **Instagram**: [@anmmashud](https://www.instagram.com/anmmashud)  
- **LinkedIn**: [Connect](https://www.linkedin.com)
```

This version includes all your original queries, objectives, and structure, with grammar and formatting improved for readability.