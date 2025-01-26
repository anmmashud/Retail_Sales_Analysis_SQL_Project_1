# SQL Retail Sales Analysis - P1

--------------------------------------
--------------------------------------
--------------------------------------

### Setup:

**Create Database**

```sql
CREATE DATABASE p1_retail_db;
```

**Drop Table if it exists**

```sql
DROP TABLE IF EXISTS retail_sales;
```

**Create Table**

```sql
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
```

## Import Data from CSV file...

The CSV file used in this project is here - [SQL_Retail_Sales_Analysis.csv](https://github.com/anmmashud/Retail_Sales_Analysis_SQL_Project_1/SQL_Retail_Sales_Analysis.csv)

**Display Sample Data**

```sql
SELECT * FROM retail_sales LIMIT 10;
```

**Count Rows in the Table**

```sql
SELECT COUNT(*) AS total_rows FROM retail_sales;
```

-- Data Cleaning

**Identify Rows with Null Values**

```sql
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
```

**Delete Rows with Null Values**

```sql
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
```

## Data Exploration

**1. How many sales are there (After Cleaning)?**

```sql
SELECT COUNT(*) AS total_sales FROM retail_sales;
```
*Alternative approach*
```sql
SELECT COUNT(DISTINCT transactions_id) AS total_sales FROM retail_sales;
```
`Ans:` 1987

**2. How many unique customers are there?**

```sql
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
```
`Ans:` 155

**3. How many categories are there?**

```sql
SELECT COUNT(DISTINCT category) AS total_categories FROM retail_sales;
```
`Ans:` 3

**4. What are the unique categories?**

```sql
SELECT DISTINCT category FROM retail_sales;
```
`Ans:` Electronics, Clothing, Beauty

## Data Analysis: Problems and Answers:

--

**1. Write a SQL query to Retrieve all columns for sales made on 2022-11-05**

`Ans:`
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

--

**2. -- 2. Write a SQL query to Retrieve all transactions where the category is 'Clothing', quantity sold is more than 4, in November 2022**

`Ans:`
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
	AND quantity >= 4
	AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11';
```
`Output:` 
Hint: 17 Rows

--

**3. Calculate the total sales for each category**

`Ans:`
```sql
SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category;
```
`Output:` 
Electronics = 311445
Clothing = 309995
Beauty = 286790

--

**4. Find the average age of customers who purchased items from the 'Beauty' category**

`Ans:`
```sql
SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```
`Output:` 40.4157119476268412

--

**5. Write a SQL query to Find all transactions where total_sale is greater than 1000**

`Ans:`
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```
`Output:` 
Hint: 306 Rows

--

**6. Write a SQL query to Calculate the total number of transactions made by each gender in each category**

`Ans:`
```sql
SELECT gender, category, COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category;
```
`Output:` 
Hint: 6 Rows

--

**7. Write a SQL query to Calculate the average sale for each month and find the best-selling month in each year**

`Ans:`
```sql
SELECT 
    TO_CHAR(sale_date, 'YYYY-MM') AS year_month,
    AVG(total_sale) AS average_sale,
    SUM(total_sale) AS total_monthly_sale
FROM retail_sales
GROUP BY TO_CHAR(sale_date, 'YYYY-MM')
ORDER BY SUM(total_sale) DESC;
```
`Output:` 
Hint: 24 Rows

--

**8. Write a SQL query to Find the top 5 customers based on the highest total sales**

`Ans:`
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```
`Output:` 
Customer ID : 3 > 1 > 5 > 2 > 4

--

**9. Write a SQL query to Find the number of unique customers who purchased items from each category**

`Ans:`
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```
`Output:`
Beauty = 141
Clothing = 149
Electronics = 144

--

**10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**

`Ans:`
```sql
SELECT 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(transactions_id) AS total_orders
FROM retail_sales
GROUP BY 
    CASE 
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END;
```
`Output:`

--