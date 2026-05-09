CREATE DATABASE sql_project_p2;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(50),
    age INT,
    category VARCHAR(50),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

select * from retail_sales
limit 10;


select count(*) from retail_sales;

select * from retail_sales
where transactions_id is null;

select * from retail_sales
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 category is null
	 or
	 quantity is null
	 or
	 cogs is null
	 or
	 total_sale is null;


Delete from retail_sales
where 
     transactions_id is null
	 or
	 sale_date is null
	 or
	 sale_time is null
	 or
	 gender is null
	 or
	 category is null
	 or
	 quantity is null
	 or
	 cogs is null
	 or
	 total_sale is null;
	 
-- Data Exploration

-- How many sales we have?
select count(*) as total_sale from retail_sales;

-- How many customers we have?
select count(customer_id) as total_sales from retail_sales

-- How many unique customers we have?
select count(DISTINCT customer_id) as total_sales from retail_sales

-- How many unique category we have?
select Distinct category from retail_sales

-- Data Analysis & Business Key Problems & Answers

-- 1) Write SQL Query to retrieve all column for sales made on '2022-11-05'
select * from retail_sales where sale_date = '2022-11-05';

-- 2) write a SQL Query to retrive all transactions where the category is 'clothing' and 
-- the quantity sold is more than or equal to 4 in the month of Nov-2022
SELECT 
    *
FROM retail_sales
WHERE category = 'Clothing'
AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
AND quantity >= 4

--3) Write a SQL query to calculate the total sales (total_sales) for each category.
select 
category,
sum(total_sale) as net_sale,
count(*) as total_orders
from retail_sales
group by 1

-- 4) Write a SQL query to find the average age of customers who purchased items from the 
-- 'beauty' category.

select Round(avg(age),2) as avg_age
from retail_sales
where category = 'Beauty'

-- 5) Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale > 1000;

-- 6) Write a SQL Query to find the total number of transactions(transaction_id) 
-- made by each gender in each category.
select  
category,
gender,
count (*) as total_trans
 from retail_sales
 group by 
 category,gender
order by 1

-- 7) Write a SQL Query to calculate the average sale for the each month, find out best 
-- selling month in each year

select
year,
month,
avg_sale
from(
select
extract (year from sale_date) as year,
extract (month from sale_date) as month,
Avg(total_sale) as avg_sale,
Rank () Over(Partition by extract(year from sale_date) order by avg(total_sale) desc) as rank
from retail_sales
group by 1, 2
) as t1
where rank = 1

-- 8) Write a SQL Query to find the top 5 customers based on the highest total sales

select 
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5

-- 9) Write a SQL Query to find the number of unique customers who purchased items from each
-- category.
select 
 category,
 count(distinct customer_id) as cnt_uni_cs
from retail_sales
group by category
xample

-- 10) Write a SQL Query to create each shift and number of orders (Example Morning < 12,
-- afternoon between 12 & 17, Evening >17)
with hourly_sale
as
(
select *,
case
when extract(hour from sale_time) < 12 Then 'Morning'
when extract(hour from sale_time) between 12 and 17 Then 'Afternoon'
Else 'Evening'
end as shift
from retail_sales
)
select 
shift,
count(*) as total_orders
from hourly_sale
group by shift


                                        --------
























































