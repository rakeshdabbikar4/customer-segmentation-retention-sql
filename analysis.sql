-- 1. Data Preview
SELECT * FROM retail LIMIT 10;

-- 2. Data Cleaning
CREATE TABLE retail_clean AS
SELECT *
FROM retail
WHERE CustomerID IS NOT NULL
AND Quantity > 0
AND UnitPrice > 0;

-- 3. Monthly Revenue
SELECT 
    substr(InvoiceDate, 7, 4) || '-' || substr(InvoiceDate, 4, 2) AS month,
    SUM(Quantity * UnitPrice) AS revenue
FROM retail_clean
GROUP BY month
ORDER BY month;

-- 4. Top Customers
SELECT 
    CustomerID,
    SUM(Quantity * UnitPrice) AS total_spent
FROM retail_clean
GROUP BY CustomerID
ORDER BY total_spent DESC
LIMIT 10;

-- 5. Customer Segmentation
SELECT 
    CustomerID,
    SUM(Quantity * UnitPrice) AS total_spent,
    CASE 
        WHEN SUM(Quantity * UnitPrice) > 5000 THEN 'High Value'
        WHEN SUM(Quantity * UnitPrice) > 2000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM retail_clean
GROUP BY CustomerID;

-- 6. Country Analysis
SELECT 
    Country,
    SUM(Quantity * UnitPrice) AS revenue
FROM retail_clean
GROUP BY Country
ORDER BY revenue DESC;

-- 7. Top Revenue Products
SELECT 
    Description,
    SUM(Quantity * UnitPrice) AS revenue
FROM retail_clean
GROUP BY Description
ORDER BY revenue DESC
LIMIT 10;
