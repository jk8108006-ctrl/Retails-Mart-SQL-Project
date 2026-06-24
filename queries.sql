--  Topic 1: Basic SELECT
--  Concepts: SELECT, WHERE, IN, AND/OR, ORDER BY, LIMIT

-- Q1. Which customers are from the Chandigarh-Mohali region,
--     and when did they join? (Latest joiners first)
select * from customers where city in ("chandigarh", "Mohali") order by join_date desc;

-- Q2. Show all cancelled or returned orders in 2024,
--     sorted by order date (oldest first).
select * from orders where status in ("cancelled","returned") order by order_date asc;

-- Q3. What are the top 5 most expensive products we sell?
select * from products order by price desc limit 5;

-- Q4. Products under ₹1000 sorted by price
select * from products where price < 1000 order by price asc;



--  Topic 2: Aggregate Functions
--  Concepts: COUNT, SUM, AVG, MIN, MAX, ROUND, DISTINCT

-- Q1. How many total orders do we have, and how many
--     belong to each status?
select count(*) as total_orders,
count(case when status="delivered" then 1 end) as deliverd,
count(case when status="Cancelled" then 1 end) as cancelled,
count(case when status="returned" then 1 end) as returned,
count(case when status="pending" then 1 end) as pending
 from orders;

-- Q2. What is our total revenue and average item value
--     from all delivered orders?
select 
      round(
            sum(p.price * oi.quantity * (1 - oi.discount_percent/100)),2) as total_revenue,
	 
     round(
           avg(p.price * oi.quantity * (1 - oi.discount_percent/100)),2) as avg_item_value,
	
    sum(oi.quantity) as total_units_sold,
    count(oi.item_id) as total_line_items
    
from order_items oi
join orders o on oi.order_id = o.order_id
join products p on oi.product_id = p.product_id
where o.status = "Delivered";

-- Q3. What is the price range and average price
--     across all our products?
select
count(*) as total_products,
min(price) as cheapest_price,
max(price) as expensive_price,
round(avg(price),2) as average_price,
max(price) - min(price) as price_range
from products;

-- Q4. How many unique customers have actually placed
--        at least one order?
SELECT
    COUNT(*) as total_customers,
    COUNT(DISTINCT customer_id) as customers_who_ordered
FROM orders;



--  Topic 3: GROUP BY + HAVING
--  Concepts: GROUP BY, HAVING, WHERE vs HAVING difference,
--            aggregate filters, multi-column grouping

-- Q1. What is the total revenue and units sold
--     per product category? (Best category first)
select
p.category,
count(distinct o.order_id) as total_orders,
sum(oi.quantity) as units_sold,
round(
      sum(p.price * oi.quantity * (1-oi.discount_percent / 100)),2) as total_revenue,
round(
      avg(p.price * oi.quantity * (1-oi.discount_percent / 100)),2) as avg_item_value
from order_items oi
join orders o on oi.order_id = o.order_id
join products p on oi.product_id = p.product_id
where o.status = "Delivered"
group by category
order by total_revenue desc;
 
-- Q2. Which cities have 2 or more customers?
--     Show customer count per city, largest first.
select city,count(*) from customers group by city having count(*)>=2;

-- Q3. Which products have sold more than 5 units total
--     across all delivered orders?
select p.product_name, p.category,
sum(oi.quantity) from products p
join order_items oi
on p.product_id = oi.product_id
join orders o
on oi.order_id = o.order_id
where o.status = "Delivered"
group by p.product_id,p.product_name,p.category
having sum(oi.quantity)>5 ;

-- BONUS: Which months had more than 4 delivered orders?
--        (Finding peak sales months)
select 
monthname(order_date) as month_name,
month(order_date) as month_num,
count(*) as delivered_orders
from orders
where status ="Delivered"
group by monthname(order_date), month(order_date)
having count(*)>4;



--  Topic 4: JOINs
--  Concepts: INNER JOIN, LEFT JOIN, multi-table JOIN,
--            NULL check after LEFT JOIN, JOIN + GROUP BY

-- Q1. Show all orders with the customer's name and city.
--     (Most recent orders first)
select 
	o.order_id,
    c.full_name as customer_name,
    c.city,
    o.order_date,
    o.status
from orders o
inner join customers c  on o.customer_id = c.customer_id
order by o.order_date desc;

-- Q2. Show all customers and how many orders they have placed.
--     Include customers with ZERO orders too.
select 
     c.customer_id,
     c.full_name,
     c.city,
     count(order_id) as total_orders
from customers c
left join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.full_name, c.city
order by total_orders desc;

-- Q3. Find customers who have NEVER placed an order
select 
    c.customer_id,
    c.full_name,
    c.city
from customers c
inner join orders o on c.customer_id = o.customer_id
where o.order_id is null;

-- Q3. Show complete order line item details —
--     customer, product, quantity, discount, and revenue.
--     (Delivered orders only)
select
      o.order_id,
      c.full_name as customer_name,
      c.city,
      p.product_name,
      p.category,
      oi.quantity,
      p.price,
      oi.discount_percent,
      round(
            p.price * oi.quantity * (1 - oi.discount_percent / 100),2) as revenue
from order_items oi
inner join orders o 
on oi.order_id   = o.order_id
inner join customers c 
on o.customer_id = c.customer_id
inner join products  p   
on  oi.product_id = p.product_id
where o.status = "Delivered"
order by o.order_id, oi.item_id;

-- Q4. Who are our top 5 highest-spending customers?
select 
	  c.customer_id,
      c.full_name,
      c.city,
     sum(p.price* oi.quantity) as total_spent
from customers c
inner join orders o
on c.customer_id = o.customer_id
inner join order_items oi
on o.order_id    = oi.order_id
inner join products p
ON  oi.product_id = p.product_id
where o.status = "Delivered"
group by c.customer_id,c.full_name,c.city
order by total_spent desc
limit 5;



--  Topic 5: Subqueries
--  Concepts: Scalar subquery, IN subquery, Correlated subquery,
--            NOT IN, NOT EXISTS, Subquery in FROM (derived table)

-- Q1. Which products are priced ABOVE the overall
--     average product price?
select 
product_name, 
category, 
price
from products
where price > (select avg(price) from products)
order by price desc;

-- Q2. Which customers have ordered at least one
--     Electronics product? Show their name and city.
select 
customer_id,
full_name,
city
from customers
where customer_id in(
 select distinct o.customer_id 
 from orders o
join order_items oi  on o.order_id   = oi.order_id
    join products    p   on oi.product_id = p.product_id
    where p.category   = 'Electronics'
    and   o.status     = 'Delivered'
)
order by city;

-- Q3. Which products are priced ABOVE their own
--     CATEGORY'S average price? (Not the overall average)
SELECT
    product_name,
    price,
    category
FROM products p1
WHERE price >
(
    SELECT AVG(price)
    FROM products p2
    WHERE p1.category = p2.category
);



--  Topic 6: Date Functions

-- Q1. What is our monthly revenue trend across 2024?
--     (Which months performed best?)
select 
year(o.order_date) as yr,
month(o.order_date) as month_num,
monthname(o.order_date) as month_name,
count(Distinct o.order_id) as total_orders,
sum(oi.quantity) as units_sold,
round(
      sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)), 2) as monthly_revenue
from orders o
join order_items oi on o.order_id   = oi.order_id
join products  p   on oi.product_id = p.product_id
where o.status = 'Delivered'
group by
    YEAR(o.order_date),
    MONTH(o.order_date),
    MONTHNAME(o.order_date),
    DATE_FORMAT(o.order_date, '%b %Y')
order by yr, month_num;

-- Q2. How long has each customer been with us?
--     Segment them into loyalty tiers by tenure.
select
customer_id,
full_name,
city,
join_date,
curdate() as today,
datediff(curdate(), join_date) as days_with_us,
timestampdiff(month, join_date, CURDATE()) as months_with_us,

case
    when timestampdiff(month,join_date,curdate()) >=36 then
"Gold" 
    when timestampdiff(month,join_date,curdate()) >=24 then
"Silver"
else
"Bronze"
end
as loyalty_tier
from customers
order by days_with_us desc;



--  Topic 7: CASE WHEN
--  Concepts: Simple CASE WHEN, CASE WHEN in GROUP BY,
--            Conditional Aggregation (SUM/COUNT + CASE WHEN),
--            CASE WHEN with JOINs

-- Q1. Classify every product into a price segment.
--     How many products and what avg price per segment?
select 
case
    when price < 700 then "Budget"
    when price between 700 and 1999 then "Mid Range"
    when price between 20000 and 3999 then "Premium"
    else "Luxury"
    end as price_segment,
count(*) as total_products,
max(price) as highest_price,
min(price) as lowest_price,
round(avg(price),2) as avg_price
from products
group by
     case
         when price < 700 then "Budget"
    when price between 700 and 1999 then "Mid Range"
    when price between 20000 and 3999 then "Premium"
    else "Luxury"
    end
order by avg_price;

-- Q2. Categorize each delivered order by how heavily
--     discounted it was. Show revenue per discount band.
select
     case
         when oi.discount_percent = 0 then "No Discount"
         when oi.discount_percent between 1 and 9 then "Low (1 - 9%)"
         when oi.discount_percent between 10 and 19 then "Medium (10 - 19%)"
         else "High Discount"
         end as discount_band,
         count(oi.item_id) as total_line_items,
         sum(oi.quantity) as units_sold,
         round(
               sum(p.price * oi.quantity),2) as gross_revenue,
		round(
              sum(p.price * oi.quantity * (1 - discount_percent / 100)),2) as net_revenue
from order_items oi
join orders o 
on oi.order_id   = o.order_id
join products p 
on oi.product_id = p.product_id
where o.status ="Delivered"
group by 
        case 
        when oi.discount_percent = 0 then "No Discount"
         when oi.discount_percent between 1 and 9 then "Low (1 - 9%)"
         when oi.discount_percent between 10 and 19 then "Medium (10 - 19%)"
         else "High Discount"
         end
order by discount_band;



 -- Topic 8: Window Functions
 
 -- Q1. Rank products by revenue within each category.
--     Show RANK vs DENSE_RANK vs ROW_NUMBER side by side.
select 
      p.category,
      p.product_name,
      round( 
            sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)),2) as category_revenue,
            
            RANK() OVER(
            partition by p.category
            order by SUM(p.price * oi.quantity * (1 - oi.discount_percent/100)) desc) as rnk,
            
            DENSE_RANK()   OVER (
        partition by p.category
        order by SUM(p.price * oi.quantity * (1 - oi.discount_percent/100))desc) as dense_rnk,
        
        ROW_NUMBER()   OVER (
        partition by p.category
        order by SUM(p.price * oi.quantity * (1 - oi.discount_percent/100)) desc) as row_num
from order_items oi
join products  p  
on oi.product_id = p.product_id	
join orders    o  
on oi.order_id   = o.order_id
where o.status = "Delivered"
group by 
p.category, p.product_id, p.product_name
order by p.category, category_revenue desc;
     
-- Q2. What is the cumulative (running) revenue
--     month by month across 2024?
select 
      month_name,
      monthly_revenue,
      round(
            sum(monthly_revenue) over (
            order by yr, month_num
            rows between unbounded preceding and current row),2) as cumulative_revenue
from (
      select 
      year(o.order_date) as yr,
      month(o.order_date) as month_num,
      monthname(o.order_date) as month_name,
      round(
           SUM(p.price * oi.quantity * (1 - oi.discount_percent/100)),2) as monthly_revenue
	 from orders o 
     join order_items oi 
     on o.order_id   = oi.order_id
     join products p 
     on oi.product_id = p.product_id
     where o.status = "Delivered"
     group by
            year(o.order_date),
            month(o.order_date),
			monthname(o.order_date)) as monthly_data
            order by yr , month_num;
  
  -- Q3. Month-over-month revenue change — how much did
--       each month grow or shrink vs the previous month?
select month_name,
monthly_revenue,

LAG(monthly_revenue) over(order by yr, month_num) as prev_month_revenue,
LEAD(monthly_revenue) over( order by yr, month_num) as next_month_revenue,
round(
      monthly_revenue - Lag(monthly_revenue) over (order by yr, month_num),2) as mom_change
from (
select 
      year(o.order_date) as yr,
      month(o.order_date) as month_num,
      monthname(o.order_date) as month_name,
      round(
           sum(p.price * oi.quantity * (1 - oi.discount_percent/100)),2) as monthly_revenue

from orders o
JOIN order_items oi  ON o.order_id   = oi.order_id
    JOIN products    p   ON oi.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY
        YEAR(o.order_date),
        MONTH(o.order_date),
        MONTHNAME(o.order_date)
) AS monthly_data
ORDER BY yr, month_num;



--  Topic 9: CTEs (Common Table Expressions)

-- Q2. Full customer analysis pipeline using CHAINED CTEs.
--     Step 1 → compute spending
--     Step 2 → assign tier
--     Step 3 → summarise by tier

with customer_spending as (
select 
      c.customer_id,
      c.full_name,
      c.city,
      count(distinct o.order_id) as total_orders,
      round(
            sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)),2) as total_spent
from customers c
join  orders o   
on c.customer_id = o.customer_id
join order_items oi
on o.order_id    = oi.order_id
join products p
on oi.product_id = p.product_id
where o.status = "Delivered"
group by c.customer_id , c.full_name, c.city
),

customer_tiers as (
select 
        customer_id,
        full_name,
        city,
        total_orders,
        total_spent,
        case
			when total_spent >= 15000 then 'VIP'
            when total_spent >=  7000 then 'Regular'
            else 'New'
			end as tier,
            RANK () over (order by total_spent desc) as overall_rank
from customer_spending)
select * from customer_tiers;



--  Topic 10: Views

-- VIEW 1: vw_product_performance
--   Shows every product's total sales performance.
create view vw_product_performance as 
select
      p.product_id,
      p.product_name,
      p.category,
      p.price,
      sum(oi.quantity) as total_units_sold,
      round(
            sum(p.price * oi.quantity *
            (1 - oi.discount_percent / 100)),2) as total_revenue,
	  count(distinct oi.order_id) as total_orders
from products p
left join order_items oi
on p.product_id = oi.product_id
left join orders o 
on oi.order_id = o.order_id
where o.status ="delivered"
group by
p.product_id,
    p.product_name,
    p.category;
select * from vw_product_performance;

-- VIEW 2: vw_customer_summary
select 
       c.full_name, 
       c.email, 
       c.city, 
       c.join_date,
       sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)) as total_spent,
       timestampdiff(Month, c.join_date, curdate()) as month_as_customer,
       count(distinct o.order_id) as total_orders,
       sum(oi.quantity) as total_units_bought,
       max(o.order_date) as last_order_date,
       datediff(curdate(),max(o.order_date)) as days_since_last_order,
       case
           when  sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)) >= 15000 then "Premium"
           when  sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)) >=7000 then "Regular"
           else "New"
           end as customer_tier
from customers c
left join orders o 
on c.customer_id = o.customer_id
and o.status = 'Delivered'
left join order_items oi 
on o.order_id    = oi.order_id
left join products p
on oi.product_id = p.product_id
group by
        c.customer_id,
		c.full_name,
        c.city,
        c.join_date;

   

--  Topic 11: Stored Procedures

-- PROCEDURE 1: sp_city_sales_report
--   IN parameter: city name
--   Returns: customer spending summary for that city

drop procedure sp_city_sales_report;

delimiter //
create procedure sp_city_sales_report(
          IN p_city varchar(40) )
begin
     if p_city is null or p_city = "" then
         select "error : Please provide a valid city name.AS message";
     else
         select
               c.full_name,
               c.city,
			   c.join_date,
               COUNT(DISTINCT o.order_id) as total_orders,
               sum(oi.quantity) as units_bought,
               sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)) as total_spent,
                 case
           when  sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)) >= 15000 then "Premium"
           when  sum(p.price * oi.quantity * (1 - oi.discount_percent / 100)) >=7000 then "Regular"
           else "New"
           end as customer_tier
from customers c
join orders o 
on c.customer_id = o.customer_id
join order_items oi 
on o.order_id    = oi.order_id
join products p
on oi.product_id = p.product_id
where  c.city    = p_city     
and o.status  = 'Delivered'
group by
        c.customer_id,
		c.full_name,
        c.city,
        c.join_date;
end if;
end //
delimiter ;
call sp_city_sales_report('Chandigarh');

-- PROCEDURE 2: sp_status_revenue_summary
--   IN  parameter: order status to analyse
--   OUT parameter: total order count (returned to caller)
--   OUT parameter: total revenue     (returned to caller)

drop procedure if exists sp_status_revenue_summary;

delimiter //
create procedure sp_status_revenue_summary(
	   IN p_status varchar(20),
       OUT p_order_count int,
       OUT p_total_revenue decimal(12,2)
       )
begin
     select
           count(distinct o.order_id),
           sum(p.price * oi.quantity * (1 - oi.discount_percent/100))
           into
           p_order_count,     
		   p_total_revenue 
           from orders o
           join order_items oi
           on o.order_id   = oi.order_id
           join products p
           on oi.product_id = p.product_id
           where o.status = p_status;
	select
          p_status as status,
          p_order_count as total_orders,
		  p_total_revenue as total_revenue;
end //
delimiter ;

# Creating Variables
set @order_count = 0;
set @revenue = 0;

# Calling Procedure
call sp_status_revenue_summary(
    'Delivered',
    @order_count,
    @revenue
);

# See OUT Values
SELECT
    @order_count AS total_orders,
    @revenue AS total_revenue;
           