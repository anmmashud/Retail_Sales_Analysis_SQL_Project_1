# Retail Sales Analysis SQL Project 1

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. **Database Setup**

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.


```sql

DROP DATABASE IF EXISTS p1_retail_db;

CREATE DATABASE p1_retail_db;

DROP TABLE IF EXISTS retail_sales;

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

<details>
  <summary>Click to see detailed breakdown!</summary>

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
</details>

### 2. **Data Exploration & Cleaning**

**Import Data from the CSV file:** [SQL_Retail_Sales_Analysis.csv](https://github.com/anmmashud/Retail_Sales_Analysis_SQL_Project_1/SQL_Retail_Sales_Analysis.csv)

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
-- Identify Rows with Null Values

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

-- Delete Rows with Null Values

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

<details>
  <summary>Click to see detailed breakdown!</summary>

**Display Sample Data**

To check if all data imported successfully
```sql
SELECT * FROM retail_sales LIMIT 10;
```

**Count Rows in the Table**

```sql
SELECT COUNT(*) AS total_rows FROM retail_sales;
```
here we have 2000 rows (if you use the given file with the project)

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
</details>

### Data Exploration (After Cleaning)

**1. How many sales are there?**

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

### 3. **Data Analysis & Findings**

The following SQL queries were developed to answer specific business questions:

**1. Write a SQL query to Retrieve all columns for sales made on 2022-11-05**

`Ans:`
```sql
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';
```
---

**2. Write a SQL query to Retrieve all transactions where the category is 'Clothing', quantity sold is more than 4, in November 2022**

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

---

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

---

**4. Find the average age of customers who purchased items from the 'Beauty' category**

`Ans:`
```sql
SELECT AVG(age) AS average_age
FROM retail_sales
WHERE category = 'Beauty';
```
`Output:` 40.4157119476268412

---

**5. Write a SQL query to Find all transactions where total_sale is greater than 1000**

`Ans:`
```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```
`Output:` 
Hint: 306 Rows

---

**6. Write a SQL query to Calculate the total number of transactions made by each gender in each category**

`Ans:`
```sql
SELECT gender, category, COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category;
```
`Output:` 
Hint: 6 Rows

---

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

---

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

---

**9. Write a SQL query to Find the number of unique customers who purchased items from each category**

`Ans:`
```sql
SELECT category, COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```
`Output:` Beauty = 141, Clothing = 149, Electronics = 144

---

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


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## **How to Use This Project**

1. **Clone the Repository**: Clone this project repository from GitHub to your local machine.

2. **Set Up the Database**: Use the SQL script provided in the `Project_1_SQL_Query.sql` file to create and populate the database with the necessary tables and data.

3. **Run the Queries**: Execute the SQL queries in the same `Project_1_SQL_Query.sql` file to analyze the dataset and generate insights.

4. **Customize and Explore**: 
   - Modify the existing queries to explore additional aspects of the dataset.
   - Add new queries to answer further business questions or customize the analysis as needed.

## Author - A. N. M. Mashud

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Stay Updated and Join the Community

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **YouTube**: [Subscribe to my channel for tutorials and insights](https://www.youtube.com/@anmmashud)
- **Instagram**: [Follow me for daily tips and updates](https://www.instagram.com/anmmashud/)
- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/anm-mashud)
- **Whatsapp**: [Contact with me via phone Call](tel:+8801872809600)

Thank you for your support, and I look forward to connecting with you!
