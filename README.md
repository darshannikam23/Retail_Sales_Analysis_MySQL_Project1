# Retail Sales Analysis MySQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `mysql_project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `mysql_project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
create database mysql_project;

create table retail_sales
(
    transactions_id int primary key,
    sale_date date,	
    sale_time time,
    customer_id int,	
    gender varchar(10),
    age int,
    category varchar(35),
    quantity int,
    price_per_unit float,	
    cogs float,
    total_sale float
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select * from retail_sales;
select count(*) from retail_sales;
select count(distinct customer_id) from retail_sales;

select * from retail_sales 
where 
	transactions_id is null or sale_date is null or sale_time is null or customer_id is null or gender is null or age is null or category is null or quantiy is null or price_per_unit is null or cogs is null or total_sale is null;
    
delete from retail_sales
where
	sale_date is null or sale_time is null or customer_id is null or gender is null or age is null or category is null or quantiy is null or price_per_unit is null or cogs is null or total_sale is null;
```
### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
select * from retail_sales
where sale_date = "2022-11-05";
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select * from retail_sales
where category = "Clothing" and quantiy >= 4
and date_format(sale_date, "%Y-%m") = "2022-11";
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select 
	category,
	sum(total_sale) as total_sales,
    count(*) as total_orders
from retail_sales
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
select 
	round(avg(age), 2) as Avg_Age
from retail_sales
where category = "Beauty";
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
select * from retail_sales
where total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select category, gender,
	count(*) as total_transaction
    from retail_sales
group by
	category, gender
order by 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
select year, month, avg_sales
from 
(
select
	extract(year from sale_date) as year,
    extract(month from sale_date) as month,
    avg(total_sale) as avg_sales,
    rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc) as ranks
from retail_sales
group by 1, 2
) as t1
where ranks = 1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
select 
	customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
select 
	category,
	count(distinct customer_id) as no_of_unique_cust
from retail_sales
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
with hourly_sale
as
(
select *,
    case
        when extract(hour from sale_time) < 12 then 'Morning'
        when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as shift
from retail_sales
)
select 
    shift,
    count(*) as total_orders    
from hourly_sale
group by shift
```

## Findings

- **Customer Demographics**: The dataset comprises clients of diverse ages, and sales are dispersed over several categories, including apparel and cosmetics.
- **High-Value Transactions**: A few of these transactions involved premium purchases, with the total sale amount exceeding $1,000.
- **Sales Trends**: Monthly analysis helps determine peak seasons by displaying variances in sales.
- **Customer insights**: The analysis determines the most popular product categories and the highest-spending clients.

## Reports

- **Sales Summary**: A thorough report that provides an overview of category performance, consumer demographics, and overall sales.
- **Trend analysis**: Provides information about sales patterns over several months and time periods.
- **Customer insights**: Data on the most popular clients and the number of distinct clients in each category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## Inspiration

Zero Analyst - https://www.youtube.com/watch?v=ChIQjGBI3AM&list=PLF2u7Zn-dIxbeais0AkBxUqdWM1hnSJDS
