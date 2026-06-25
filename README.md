# 🛒 RetailSmart Sales Analytics — MySQL Project

> A structured SQL analytics project built on a simulated Indian e-commerce database.  
> Covers real-world SQL topics with 25+ interview-ready queries including CTE's, Views, and Stored Procedures.

---

## 📌 Project Overview

**RetailSmart** is a fictional e-commerce company selling across 8 Indian cities.  
This project simulates a real analyst's work — answering business questions using SQL,  
from basic filtering all the way to window functions, CTEs, and stored procedures.

 Property                             Detail 

 **Database**                         MySQL 8.0  
 **Tables**                           4 
 **Total Rows**                       ~180 (20 customers · 15 products · 45 orders · 95 order items) 
 **Date Range**                       January 2024 – August 2024 
 **Cities Covered**                   Chandigarh, Mohali, Delhi, Mumbai, Bangalore, Pune, Hyderabad, Ahmedabad 
 **Product Categories**               Electronics, Clothing, Books, Home & Kitchen, Sports 

---

## 🗂️ Database Schema


```

### Table Descriptions

| Table              | Rows              | Purpose |

| `customers`        | 20                | Customer profiles — name, city, join date |
| `products`         | 15                | Product catalog — category, price, stock |
| `orders`           | 45                | Order headers — date, status (Delivered / Cancelled / Returned / Pending) |
| `order_items`      | 95                | Line items per order — quantity, discount applied |

---

## 📚 SQL Topics Covered

| # | Topic | File | Key Concepts |
|---|---|---|---|
| 1 | Basic SELECT | `01_basic_select.sql` | `WHERE`, `IN`, `ORDER BY`, `LIMIT` |
| 2 | Aggregate Functions | `02_aggregate_functions.sql` | `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `ROUND` |
| 3 | GROUP BY + HAVING | `03_group_by_having.sql` | `GROUP BY`, `HAVING`, WHERE vs HAVING |
| 4 | JOINs | `04_joins.sql` | `INNER JOIN`, `LEFT JOIN`, 4-table join |
| 5 | Subqueries | `05_subqueries.sql` | Scalar, `IN`, Correlated, `NOT EXISTS` |
| 6 | Date Functions | `06_date_functions.sql` | `MONTH()`, `YEAR()`, `DATEDIFF()`, `DATE_FORMAT()` |
| 7 | CASE WHEN | `07_case_when.sql` | Price banding, Conditional aggregation, Pivot |
| 8 | Window Functions | `08_window_functions.sql` | `RANK()`, `DENSE_RANK()`, `LAG()`, Running Total |
| 9 | CTEs | `09_ctes.sql` | `WITH` clause, Chained CTEs, CTE vs Subquery |
| 10 | Views | `10_views.sql` | `CREATE VIEW`, `OR REPLACE`, business dashboards |
| 11 | Stored Procedures | `11_stored_procedure.sql` | `IN`/`OUT` params, `DELIMITER`, `DECLARE` |

---

## 💼 Business Questions Answered

--  Topic 1: Basic SELECT
-- Q1. Which customers are from the Chandigarh-Mohali region,
--     and when did they join? (Latest joiners first)

-- Q2. Show all cancelled or returned orders in 2024,
--     sorted by order date (oldest first).

-- Q3. What are the top 5 most expensive products we sell?

-- Q4. Products under ₹1000 sorted by price



--  Topic 2: Aggregate Functions

-- Q1. How many total orders do we have, and how many
--     belong to each status?

-- Q2. What is our total revenue and average item value
--     from all delivered orders?

-- Q3. What is the price range and average price
--     across all our products?

-- Q4. How many unique customers have actually placed
--        at least one order?



--  Topic 3: GROUP BY + HAVING

-- Q1. What is the total revenue and units sold
--     per product category? (Best category first)

-- Q2. Which cities have 2 or more customers?
--     Show customer count per city, largest first.

-- Q3. Which products have sold more than 5 units total
--     across all delivered orders?



--  Topic 4: JOINs

-- Q1. Show all orders with the customer's name and city.
--     (Most recent orders first)

-- Q2. Show all customers and how many orders they have placed.
--     Include customers with ZERO orders too.

-- Q3. Find customers who have NEVER placed an order

-- Q4. Who are our top 5 highest-spending customers?



--  Topic 5: Subqueries

-- Q1. Which products are priced ABOVE the overall
--     average product price?

-- Q2. Which customers have ordered at least one
--     Electronics product? Show their name and city.

-- Q3. Which products are priced ABOVE their own
--     CATEGORY'S average price? (Not the overall average)



--  Topic 6: Date Functions

-- Q1. What is our monthly revenue trend across 2024?
--     (Which months performed best?)

-- Q2. How long has each customer been with us?
--     Segment them into loyalty tiers by tenure.



--  Topic 7: CASE WHEN

-- Q1. Classify every product into a price segment.
--     How many products and what avg price per segment?

-- Q2. Categorize each delivered order by how heavily
--     discounted it was. Show revenue per discount band.

 -- Topic 8: Window Functions

  -- Q1. Rank products by revenue within each category.
--     Show RANK vs DENSE_RANK vs ROW_NUMBER side by side.

-- Q2. What is the cumulative (running) revenue
--     month by month across 2024?

-- Q3. Month-over-month revenue change — how much did
--       each month grow or shrink vs the previous month?



--  Topic 9: CTEs (Common Table Expressions)

-- Q1. Full customer analysis pipeline using CHAINED CTEs.
--     Step 1 → compute spending
--     Step 2 → assign tier
--     Step 3 → summarise by tier



--  Topic 10: Views

-- VIEW 1: vw_product_performance
--   Shows every product's total sales performance.

-- VIEW 2: vw_customer_summary



--  Topic 11: Stored Procedures

-- PROCEDURE 1: sp_city_sales_report
--   IN parameter: city name
--   Returns: customer spending summary for that city

-- PROCEDURE 2: sp_status_revenue_summary
--   IN  parameter: order status to analyse
--   OUT parameter: total order count (returned to caller)
--   OUT parameter: total revenue     (returned to caller)



## 👤 Author

Jay Kushwaha 
Aspiring Data Scientist  



---

> ⭐ If this project helped you, consider giving it a star!