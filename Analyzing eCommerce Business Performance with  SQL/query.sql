-- Create a database: ecommerce_analysis (Using PgAdmin4)
CREATE DATABASE ecommerce_analysis
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

--Create a table for 8 CSV dataset that has been provided
-- 1. Create a Customers Table
create table customers (
	customer_id varchar(250),
	customer_unique_id varchar(250),
	customer_zip_code_prefix int,
	customer_city varchar(250),
	customer_state varchar(250)
);
-- 2. Make a geolocation table
create table geolocation (
	geo_zip_code_prefix varchar(250),
	geo_lat varchar(250),
	geo_lng varchar(250),
	geo_city varchar(250),
	geo_state varchar(250)
);
-- 3. Create an order_item table
create table order_item (
	order_id varchar(250),
	order_item_id int,
	product_id varchar(250),
	seller_id varchar(250),
	shipping_limit_date timestamp,
	price float,
	freight_value float
);
-- 4. Create a payments table 
create table payments (
	order_id varchar(250),
	payment_sequential int,
	payment_type varchar(250),
	payment_installment int,
	payment_value float
);
-- 5. Create a reviews table 
create table reviews (
	review_id varchar(250),
	order_id varchar(250),
	review_score int, 
	review_comment_title varchar(250),
	review_comment_message text,
	review_creation_date timestamp,
	review_answer timestamp
);
-- 6. Create an orders table
create table orders (
	order_id varchar(250),
	customers_id varchar(250),
	order_status varchar(250),
	order_purchase_timestamp timestamp,
	order_approved_at timestamp,
	order_delivered_carrier_date timestamp,
	order_delivered_customer_date timestamp,
	order_estimated_delivered_date timestamp
);
-- 7. Create a products table
create table products (
	product_id varchar(250),
	product_category_name varchar(250),
	product_name_length int,
	product_description_length int,
	product_photos_qty int,
	product_weight_g int,
	product_length_cm int,
	product_height_cm int,
	product_width_cm int
);
-- 8. Create a Sellers table
create table sellers (
	seller_id varchar(250),
	seller_zip_code int,
	seller_city varchar(250),
	seller_state varchar(250)
);

-- Importing CSV Dataset into the Table
-- 1. Import customer dataset
copy customers(
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city,
	customer_state
)
from 'F:\Rakamin\Boot\mini project\Dataset\customers_dataset.csv'
delimiter ','
csv header;
-- 2. Import geolocation dataset
copy geolocation(
	geo_zip_code_prefix,
	geo_lat,
	geo_lng,
	geo_city,
	geo_state
)
from 'F:\Rakamin\Boot\mini project\Dataset\geolocation_dataset.csv'
delimiter ','
csv header;
-- 3. Import dataset order_items
copy order_item (
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_limit_date,
	price,
	freight_value 
)
from 'F:\Rakamin\Boot\mini project\Dataset\order_items_dataset.csv'
delimiter ','
csv header;
-- 4. Import dataset orders
copy orders (
	order_id,
	customers_id,
	order_status,
	order_purchase_timestamp,
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivered_date
)
from 'F:\Rakamin\Boot\mini project\Dataset\orders_dataset.csv'
delimiter ','
csv header;
-- 5. mengimporDatasetPayments
copy payments (
	order_id,
	payment_sequential,
	payment_type,
	payment_installment ,
	payment_value 
)
from 'F:\Rakamin\Boot\mini project\Dataset\order_payments_dataset.csv'
delimiter ','
csv header;
-- 6. Import dataset products
copy products (
	product_id,
	product_category_name,
	product_name_length,
	product_description_length,
	product_photos_qty,
	product_weight_g,
	product_length_cm,
	product_height_cm,
	product_width_cm 
)
from 'F:\Rakamin\Boot\mini project\Dataset\product_dataset.csv'
delimiter ','
csv header;
-- 7. Import dataset reviews
copy reviews (
	review_id,
	order_id,
	review_score, 
	review_comment_title,
	review_comment_message,
	review_creation_date,
	review_answer
)
from 'F:\Rakamin\Boot\mini project\Dataset\order_reviews_dataset.csv'
delimiter ','
csv header;
-- 8. Import Dataset Sellers
copy sellers (
	seller_id,
	seller_zip_code,
	seller_city,
	seller_state
)
from 'F:\Rakamin\Boot\mini project\Dataset\sellers_dataset.csv'
delimiter ','
csv header;

-- Create an entity relationship between tables
alter table products add constraint pk_products primary key (product_id);
alter table customers add constraint pk_cust primary key (customer_id);
alter table orders add constraint pk_orders primary key (order_id);
alter table sellers add constraint pk_seller primary key (seller_id);
alter table orders add foreign key (customers_id) references customers;
alter table order_item add foreign key (product_id) references products;
alter table order_item add foreign key (seller_id) references sellers;
alter table order_item add foreign key (product_id) references products;
alter table order_item add foreign key (order_id) references orders;
alter table payments add foreign key (order_id) references orders;
alter table reviews add foreign key (order_id) references orders;

-- For the geolocation table there is no primary key because it is not a unique column

--
-- Showing the average number of monthly active customers (Monthly Active User) for each year
select 
    -- select the year from subquery
	year, 
    -- MAU
	round(avg(mau), 2) as average_mau
from (
    -- subquery
    select
        -- Extraction of the Timestamp Year component
        date_part('year',o.order_purchase_timestamp) as year,
        -- Extraction of the Month Timestamp Component
        date_part('month',o.order_purchase_timestamp) as month,
        -- Calculate every month
        count(distinct c.customer_unique_id) as mau
    from orders o
    join customers c on o.customers_id = c.customer_id
    -- Group by year, then the month
    group by 1,2
)subq
group by 1;

-- Showing the number of new customers (first transacting) in each year
select
    -- Extract Year from the subquery results table
    date_part('year', first_purchase_time) as year,
    count(1) as new_customers
from(
    -- subquery
    select
        -- select customer_unique_id
        c.customer_unique_id,
        -- get the smallest date of each customer
        min(o.order_purchase_timestamp) as first_purchase_time
    from orders o
    join customers c on c.customer_id = o.customers_id
    group by 1
)subq
group by 1

-- Showing the number of customers who make purchases more than one time (repeat order) in each year
select
    year,
    count(distinct customer_unique_id) as repeating_customers
from(
    -- subquery
    select
        -- select customer_unique_id
        c.customer_unique_id,
        -- Extract Year in the order_purchase_timestamp column
        date_part('year', o.order_purchase_timestamp) as year,
        -- add up the number of customer unique id that appears
        count(1) as purchase_frequency
    from orders o
    join customers c on c.customer_id = o.customers_id
    group by 2,1
    having count(1) > 1
)subq
group by 1

-- Showing the average number of orders made by customers for each year
select
    year,
    round(avg(frequency_purchase),3) as avg_orders_per_customers
from(
    select
        c.customer_unique_id,
        date_part('year',o.order_purchase_timestamp) as year,
        count(1) as frequency_purchase
    from orders o
    join customers c on c.customer_id = o.customers_id
    group by 1,2
)subq 
group by 1

-- Combining the three metrics that have been successfully displayed into one table display
with
calc_mau as(select 
    -- select year from subquery
	year, 
    -- average MAU for each year
	round(avg(mau), 2) as average_mau
from (
    -- subquery
    select
        -- Extraction of the Timestamp Year component
        date_part('year',o.order_purchase_timestamp) as year,
        -- Extraction of the Month Timestamp Component
        date_part('month',o.order_purchase_timestamp) as month,
        -- Calculate every month
        count(distinct c.customer_unique_id) as mau
    from orders o
    join customers c on o.customers_id = c.customer_id
    -- Group by year, then the month
    group by 1,2
)subq
group by 1),
calc_newcust as (
    select
    -- Extract Year from the subquery results table
    date_part('year', first_purchase_time) as year,
    count(1) as new_customers
from(
    -- subquery
    select
        -- select customer_unique_id
        c.customer_unique_id,
        -- get the smallest date of each customer
        min(o.order_purchase_timestamp) as first_purchase_time
    from orders o
    join customers c on c.customer_id = o.customers_id
    group by 1
)subq
group by 1),
calc_repeat as (
select
    year,
    count(distinct customer_unique_id) as repeating_customers
from(
    -- subquery
    select
        -- select customer_unique_id
        c.customer_unique_id,
        -- Extract Year in the order_purchase_timestamp column
        date_part('year', o.order_purchase_timestamp) as year,
        -- add up the number of customer unique id that appears
        count(1) as purchase_frequency
    from orders o
    join customers c on c.customer_id = o.customers_id
    group by 2,1
    having count(1) > 1
)subq
group by 1),
calc_avg_freq as(
select
    year,
    round(avg(frequency_purchase),3) as avg_orders_per_customers
from(
    select
        c.customer_unique_id,
        date_part('year',o.order_purchase_timestamp) as year,
        count(1) as frequency_purchase
    from orders o
    join customers c on c.customer_id = o.customers_id
    group by 1,2
)subq 
group by 1)
select 
	mau.year, 
	mau.average_mau, 
	newc.new_customers,
	rep.repeating_customers, 
	freq.avg_orders_per_customers
from calc_mau mau 
join calc_newcust newc on mau.year = newc.year
join calc_repeat rep on rep.year = mau.year
join calc_avg_freq freq on freq.year = mau.year

-- Create a table that contains total company revenue information for each year
create table total_revenue_per_year as
select
    -- Extract year data
    date_part('year', o.order_purchase_timestamp) as year,
    -- sum revenue per order
	sum(revenue_per_order) as revenue
from (
    -- subquery
	select 
		order_id, 
        -- revenue
		sum(price+freight_value) as revenue_per_order
	from order_item
	group by 1
) subq
join orders o on subq.order_id = o.order_id
where o.order_status = 'delivered'
group by 1

-- Create a table that contains information on the number of total cancel orders for each year
create table total_cancel_per_year as 
select 
    -- Extract year data
	date_part('year', order_purchase_timestamp) as year,
    -- Add up to the canceled
	count(1) as num_canceled_orders
from orders
where order_status = 'canceled'
group by 1

-- Create a table that contains the name of the product category that provides the highest total income for each year
create table top_product_category_by_revenue_per_year as
select
    year,
    product_category_name,
    revenue
from(
select
    -- Extract year data
    date_part('year', o.order_purchase_timestamp) as year,
    -- Data Column Name of Product Category
    p.product_category_name,
    -- revenue
	sum(oi.price + oi.freight_value) as revenue,
    -- get the RK column which is a ranking of the product category which is assessed from the most revenue for each year
    rank() over(partition by date_part('year', o.order_purchase_timestamp)
                order by sum(oi.price + oi.freight_value) desc) as rk
from order_item oi
join orders o on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
where o.order_status = 'delivered'
group by 1,2) subq
-- Choosing the Most Revenue Product
where rk = 1

-- Create a table that contains the name of the product category that has the highest number of cancel orders for each year
create table most_canceled_product_category_per_year as 
select 
	year, 
	product_category_name, 
	num_canceled 
from(
select
    -- Extract year data
    date_part('year', o.order_purchase_timestamp) as year,
    -- Data Column Name of Product Category
	p.product_category_name,
    -- Add up to the canceled
	count(1) as num_canceled,
    -- Ranking based on the year and the number of Cancel Desc for the number of Cancel
	rank() over(partition by date_part('year', o.order_purchase_timestamp) 
			 order by count(1) desc) as rk
from order_item oi
join orders o on o.order_id = oi.order_id
join products p on p.product_id = oi.product_id
where o.order_status = 'canceled'
group by 1,2) sq
where rk = 1

-- Combine the information that has been obtained into one table display
select 
	a.year,
	a.product_category_name as top_product_category_by_revenue,
	a.revenue as category_revenue,
	b.revenue as year_total_revenue,
	c.product_category_name as most_canceled_product_category,
	c.num_canceled as category_num_canceled,
	d.num_canceled_orders as year_total_num_canceled
from top_product_category_by_revenue_per_year a
join total_revenue_per_year b on a.year = b.year 
join most_canceled_product_category_per_year c on a.year = c.year 
join total_cancel_per_year d on d.year = a.year

-- Displays the number of uses of each type of payment in all time sorted from the most favorite 
select 
	pt.payment_type,
	count(1) as num_used
from payments pt 
join orders o on o.order_id = pt.order_id
group by 1
order by 2 desc

-- Displays detailed information on the number of uses of each type of payment for each year
with 
tmp as (
select 
	date_part('year', o.order_purchase_timestamp) as year,
	pt.payment_type,
	count(1) as num_used
from payments pt 
join orders o on o.order_id = pt.order_id
group by 1, 2
) 
select *,
	case when year_2017 = 0 then NULL
		else round((year_2018 - year_2017) / year_2017, 2)
	end as pct_change_2017_2018
from (
select 
  payment_type,
  sum(case when year = '2016' then num_used else 0 end) as year_2016,
  sum(case when year = '2017' then num_used else 0 end) as year_2017,
  sum(case when year = '2018' then num_used else 0 end) as year_2018
from tmp 
group by 1) subq
order by 5 desc


