-- QUANTITY ORDERED BASED ON PRODUCT CODE
SELECT productCode, SUM(quantityOrdered) AS TotalQuantitySold FROM orderdetails
GROUP BY productCode;

-- AERAGE PAYMENT AMOUNT
SELECT AVG(amount) AS AveragePaymentAmount
FROM payments;

-- TOTAL SALES
SELECT SUM(quantityOrdered * priceEach) AS TotalSales
FROM orderdetails;

-- NO. OF OFFICES
select count(officeCode) as Office_number from offices;

-- TOTAL NO.OF CUSTOMERS
select count(*) as number_of_customers from customers;

-- TOTAL NO. OF EMPLOYEES
select count(employeeNumber) as total_employees from employees;

-- TOP 5 COUNTRIES BASED ON CUSTOMER BASE
SELECT country, COUNT(*) AS customerCount FROM customers GROUP BY country ORDER BY customerCount DESC LIMIT 5;

-- TOTAL NO.OF ORDERS
select count(*) as count_of_orders from orders;

-- TOP 5 REVENUE GIVING CUSTOMERS
SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) AS totalRevenue
FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN customers c ON o.customerNumber = c.customerNumber
GROUP BY c.customerName
ORDER BY totalRevenue DESC
LIMIT 5;

-- ORDER COUNTS FOR EACH MONTH
SELECT MONTHNAME(orderDate) AS orderMonth, COUNT(*) AS orderCount
FROM orders GROUP BY orderMonth ORDER BY MONTH(orderDate);

-- INDIVIDUAL SHIPPING STATUS
SELECT status, COUNT(*) AS orderCount
FROM orders GROUP BY status ORDER BY status;

-- TOP 5 PRODUCTS BASED ON QUANTITY SOLD
SELECT p.productName, p.productLine, SUM(od.quantityOrdered) AS totalQuantitySold
FROM products p JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.productLine
ORDER BY totalQuantitySold DESC
LIMIT 5;

-- LEAST 5 SALES MAKING COUNTRY
SELECT c.country, SUM(od.quantityOrdered * od.priceEach) AS totalSales
FROM orders o JOIN orderdetails od ON o.orderNumber = od.orderNumber
JOIN customers c ON o.customerNumber = c.customerNumber
GROUP BY c.country
ORDER BY totalSales
LIMIT 5;

-- LEAST 5 Total Sales by Year and Month
SELECT LEFT(orderDate, 7) AS Year_Mon, SUM(quantityordered * priceEach) AS Total_Sales 
FROM orders ord JOIN orderdetails ordl ON ord.orderNumber=ordl.orderNumber
GROUP BY Year_Mon
ORDER BY Total_Sales
LIMIT 5;

-- TO SHOW THE TOTAL SALES, ACTUAL SALES AND PROFIT
SELECT Total_Sales, Actual_Sales, (Total_Sales - Actual_Sales) AS Profit
FROM ( SELECT SUM(quantityordered * priceEach) AS Total_Sales, SUM(quantityordered * buyprice) AS Actual_Sales FROM orderdetails 
INNER JOIN products ON products.productcode=orderdetails.productCode) Profit;