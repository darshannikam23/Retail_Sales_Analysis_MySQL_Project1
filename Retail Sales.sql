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
select * from retail_sales;
select count(*) from retail_sales;
select count(distinct customer_id) from retail_sales;

select * from retail_sales 
where 
	sale_date is null or sale_time is null or customer_id is null or gender is null or age is null or category is null or quantiy is null or price_per_unit is null or cogs is null or total_sale is null;
    
delete from retail_sales
where
	sale_date is null or sale_time is null or customer_id is null or gender is null or age is null or category is null or quantiy is null or price_per_unit is null or cogs is null or total_sale is null;
    
select * from retail_sales
where sale_date = "2022-11-05";

select * from retail_sales
where category = "Clothing" and quantiy >= 4
and date_format(sale_date, "%Y-%m") = "2022-11";

select 
	category,
	sum(total_sale) as total_sales,
    count(*) as total_orders
from retail_sales
group by category;

select 
	round(avg(age), 2) as Avg_Age
from retail_sales
where category = "Beauty";

select * from retail_sales
where total_sale > 1000;

select category, gender,
	count(*) as total_transaction
    from retail_sales
group by
	category, gender
order by 1;

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

select 
	customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

select 
	category,
	count(distinct customer_id) as no_of_unique_cust
from retail_sales
group by category;

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