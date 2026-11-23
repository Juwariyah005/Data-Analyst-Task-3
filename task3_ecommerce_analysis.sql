
-- ==========================================
-- TASK 3: SQL FOR DATA ANALYSIS
-- Database: task3_ecommerce
-- Table: ecommerce_sales_data
-- ==========================================


-- STEP 1: DATABASE SELECTION

USE task3_ecommerce;


-- STEP 2: DATA EXPLORATION

-- 1. Display first 10 records
SELECT *
FROM ecommerce_sales_data
LIMIT 10;

-- 2. Count total records
SELECT COUNT(*) AS total_records
FROM ecommerce_sales_data;

-- 3. Display all records
SELECT *
FROM ecommerce_sales_data;

-- 4. Display table structure
DESCRIBE ecommerce_sales_data;


-- STEP 3: BASIC DATA ANALYSIS

-- 5. Product category analysis
SELECT
    `Product Category`,
    COUNT(*) AS total_records
FROM ecommerce_sales_data
GROUP BY `Product Category`
ORDER BY total_records DESC;

-- 6. Calculate total revenue
SELECT
    SUM(Price * Quantity) AS total_revenue
FROM ecommerce_sales_data;

-- 7. Calculate average product price
SELECT
    AVG(Price) AS average_price
FROM ecommerce_sales_data;

-- 8. Find top 5 highest priced products
SELECT
    `Product Name`,
    Price
FROM ecommerce_sales_data
ORDER BY Price DESC
LIMIT 5;


-- STEP 4: FILTERING AND SORTING

-- 9. Customers above age 30
SELECT *
FROM ecommerce_sales_data
WHERE Age > 30;

-- 10. Female customers above age 25
SELECT *
FROM ecommerce_sales_data
WHERE Gender = 'Female'
AND Age > 25;

-- 11. Products sorted by price
SELECT
    `Product Name`,
    Price
FROM ecommerce_sales_data
ORDER BY Price DESC;

-- 12. Unique payment methods
SELECT DISTINCT `Payment Method`
FROM ecommerce_sales_data;

-- 13. Display first five records
SELECT *
FROM ecommerce_sales_data
LIMIT 5;


-- STEP 5: AGGREGATE FUNCTIONS

-- 14. Overall e-commerce sales analysis
SELECT
    COUNT(*) AS total_records,
    SUM(Quantity) AS total_quantity_sold,
    AVG(Age) AS average_customer_age,
    MIN(Price) AS minimum_price,
    MAX(Price) AS maximum_price,
    SUM(Price * Quantity) AS total_revenue,
    AVG(Price) AS average_price
FROM ecommerce_sales_data;



-- STEP 6: GROUP BY AND HAVING

-- 15. Total revenue by product category
SELECT
    `Product Category`,
    SUM(Price * Quantity) AS category_revenue
FROM ecommerce_sales_data
GROUP BY `Product Category`
ORDER BY category_revenue DESC;

-- 16. Total orders by city
SELECT
    City,
    COUNT(*) AS total_orders
FROM ecommerce_sales_data
GROUP BY City
ORDER BY total_orders DESC;

-- 17. Categories with more than 5 records
SELECT
    `Product Category`,
    COUNT(*) AS total_records
FROM ecommerce_sales_data
GROUP BY `Product Category`
HAVING COUNT(*) > 5;



-- STEP 7: JOINS

-- Create a customer details table for JOIN practice
-- The original dataset contains only one table.

CREATE TABLE IF NOT EXISTS customer_details AS
SELECT DISTINCT
    `Customer ID` AS customer_id,
    Gender AS gender,
    Age AS age,
    City AS city
FROM ecommerce_sales_data;


-- 18. INNER JOIN
SELECT
    s.`Order ID`,
    s.`Customer ID`,
    c.gender,
    c.city,
    s.Price,
    s.Quantity
FROM ecommerce_sales_data s
INNER JOIN customer_details c
ON s.`Customer ID` = c.customer_id;


-- 19. LEFT JOIN
SELECT
    s.`Order ID`,
    s.`Customer ID`,
    c.gender,
    c.city
FROM ecommerce_sales_data s
LEFT JOIN customer_details c
ON s.`Customer ID` = c.customer_id;


-- 20. RIGHT JOIN
SELECT
    s.`Order ID`,
    s.`Customer ID`,
    c.gender,
    c.city
FROM ecommerce_sales_data s
RIGHT JOIN customer_details c
ON s.`Customer ID` = c.customer_id;


-- STEP 8: SUBQUERIES

-- 21. Products priced above average price
SELECT
    `Product Name`,
    Price
FROM ecommerce_sales_data
WHERE Price > (
    SELECT AVG(Price)
    FROM ecommerce_sales_data
);


-- 22. Find the highest priced product
SELECT
    `Product Name`,
    Price
FROM ecommerce_sales_data
WHERE Price = (
    SELECT MAX(Price)
    FROM ecommerce_sales_data
);


-- 23. Customers whose age is above average
SELECT DISTINCT
    `Customer ID`,
    Age
FROM ecommerce_sales_data
WHERE Age > (
    SELECT AVG(Age)
    FROM ecommerce_sales_data
);


-- STEP 9: CREATE AND USE VIEWS

-- 24. Create a view for sales details
CREATE OR REPLACE VIEW sales_summary AS
SELECT
    `Order ID`,
    `Customer ID`,
    `Product Category`,
    `Product Name`,
    Quantity,
    Price,
    (Price * Quantity) AS total_amount,
    City
FROM ecommerce_sales_data;


-- 25. Display data from the view
SELECT *
FROM sales_summary;


-- 26. Display top 5 highest revenue records from the view
SELECT *
FROM sales_summary
ORDER BY total_amount DESC
LIMIT 5;


-- ==========================================
-- END OF TASK 3
-- ==========================================
