-- Inspecting Data
SELECT * FROM sales_data_sample;

-- Checking unique values
SELECT DISTINCT status FROM sales_data_sample;
SELECT DISTINCT year_id FROM sales_data_sample;
SELECT DISTINCT PRODUCTLINE FROM sales_data_sample;
SELECT DISTINCT COUNTRY FROM sales_data_sample;
SELECT DISTINCT DEALSIZE FROM sales_data_sample;
SELECT DISTINCT TERRITORY FROM sales_data_sample;

-- Analysis
-- Group sales by product line and calculate the total revenue
SELECT PRODUCTLINE, SUM(sales) AS Revenue
FROM sales_data_sample
GROUP BY PRODUCTLINE
ORDER BY Revenue DESC;

-- Group sales by year and calculate the total revenue
SELECT YEAR_ID, SUM(sales) AS Revenue
FROM sales_data_sample
GROUP BY YEAR_ID
ORDER BY Revenue DESC;

-- Group sales by deal size and calculate the total revenue
SELECT DEALSIZE, SUM(sales) AS Revenue
FROM sales_data_sample
GROUP BY DEALSIZE
ORDER BY Revenue DESC;

-- Find the best month for sales in a specific year and calculate the revenue and frequency
SELECT MONTH_ID, SUM(sales) AS Revenue, COUNT(ORDERNUMBER) AS Frequency
FROM sales_data_sample
WHERE YEAR_ID = 2004
GROUP BY MONTH_ID
ORDER BY Revenue DESC;

-- Identify the product line sold in November of a specific year
SELECT MONTH_ID, PRODUCTLINE, SUM(sales) AS Revenue, COUNT(ORDERNUMBER)
FROM sales_data_sample
WHERE YEAR_ID = 2004 AND MONTH_ID = 11
GROUP BY MONTH_ID, PRODUCTLINE
ORDER BY Revenue DESC;

-- Best Customer Analysis (Using Subqueries)
SELECT CUSTOMERNAME, TotalSales
FROM (
  SELECT CUSTOMERNAME, SUM(sales) AS TotalSales
  FROM sales_data_sample
  GROUP BY CUSTOMERNAME
  ORDER BY TotalSales DESC
) AS customer_summary
LIMIT 1;

-- Categorize customers into segments based on their total sales
SELECT CUSTOMERNAME, TotalSales,
  CASE
    WHEN TotalSales > 10000 THEN 'High-Value Customer'
    WHEN TotalSales > 5000 THEN 'Medium-Value Customer'
    ELSE 'Low-Value Customer'
  END AS CustomerSegment
FROM (
  SELECT CUSTOMERNAME, SUM(sales) AS TotalSales
  FROM sales_data_sample
  GROUP BY CUSTOMERNAME
) AS customer_summary;
