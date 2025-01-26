-- SQL Retail Sales Analysis - P1

-- Create Database
CREATE DATABASE p1_retail_db;

-- Drop Table if it exists
DROP TABLE IF EXISTS retail_sales;

-- Create Table
CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
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

-- Display Sample Data
SELECT * FROM retail_sales LIMIT 10;

-- Count Rows in the Table
SELECT COUNT(*) AS total_rows FROM retail_sales;

-- Data Cleaning --

SELECT * 
FROM retail_sales
WHERE transactions_id IS NULL
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
   
-- DELETE Null values --

DELETE FROM retail_sales
WHERE transactions_id IS NULL
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

-- Data Exploration --

-- 1. How many sales are there (After Cleaning)?
SELECT COUNT(*) as total_sale FROM retail_sales;
-- Alternative approach --
SELECT COUNT(DISTINCT transactions_id) AS total_sales FROM retail_sales;
-- ans: 1987

-- 2. How many unique customers are there?
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
-- ans: 155

-- 3. How many Categories are there?
SELECT COUNT(DISTINCT category) AS total_categories FROM retail_sales;
-- ans: 3

-- 4. What are the unique categories??
SELECT DISTINCT category FROM retail_sales;
-- ans: Electronics, Clothing, Beauty

---------------------------------------~~>
---------------------------------------~~>
-- Data Analysis: Problems and Answers ~~>
---------------------------------------~~>
---------------------------------------~~>

-- 1. Write a SQL query to Retrieve all columns for sales made on 2022-11-05
-- ans:

SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- 2. Write a SQL query to Retrieve all transactions where the category is 'Clothing', quantity sold is more than 4, in November 2022
-- ans:
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	AND quantity >= 4
	AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
	
-- 3. Write a SQL query to Calculate the total sales for each category
-- ans: 
SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;

-- 4. Write a SQL query to Find the average age of customers who purchased items from the 'Beauty' category
-- ans:

SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';

-- 5. Write a SQL query to Find all transactions where total_sale is greater than 1000
-- ans:

SELECT *
FROM retail_sales
WHERE total_sale > 1000;

-- 6. Write a SQL query to Calculate the total number of transactions made by each gender in each category
-- ans:

SELECT category, gender, COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category;

-- 7. Write a SQL query to Calculate the average sale for each month and find the best-selling month in each year
-- ans:

SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS year_month,
    AVG(total_sale) AS average_sale,
    SUM(total_sale) AS total_monthly_sale
FROM retail_sales
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY SUM(total_sale) DESC;

-- 8. Write a SQL query to Find the top 5 customers based on the highest total sales
-- ans:

SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- 9. Write a SQL query to Find the number of unique customers who purchased items from each category
-- ans:

SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)?
-- ans:

SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS number_of_orders
FROM retail_sales

GROUP BY 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;