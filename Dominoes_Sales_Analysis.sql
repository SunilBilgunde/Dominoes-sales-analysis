Dominoes Pizza Sales Analysis:

-- 1. a.How many customers do we have each day? b.Are there any peak hours?
a)
SELECT date,COUNT(Order_id) AS totalCust
FROM orders
GROUP BY date;

b)
SELECT EXTRACT(HOUR FROM TIME) AS Peak_hours, COUNT(order_id) as TotalCust
FROM orders
GROUP BY Peak_hours
ORDER BY TotalCust DESC;

-- 2. How many pizzas are typically in an order? Do we have any bestsellers?
SELECT AVG(Quantity)
FROM order_details;
-----------------
SELECT pizza_id, SUM(Quantity) as TotalSales
FROM order_details
GROUP BY pizza_id
ORDER BY TotalSales DESC
LIMIT 5;

-- 3. How much money did we make this year in each month? Can we identify any seasonality in the sales?
SELECT MONTHNAME(date) AS Month, SUM(od.quantity * p.Price) AS TotalRevenue
FROM order_details od
INNER JOIN orders o
	ON od.order_id = o.order_id
INNER JOIN pizzas p
	ON od.pizza_id = p.pizza_id
GROUP BY Month
ORDER BY TotalRevenue DESC;

-- 4. Are there any pizzas we should take off the menu, or any promotions we could leverage?
-- Based on the sales of pizzas--
SELECT pizza_id, SUM(Quantity) as TotalSales
FROM order_details
GROUP BY pizza_id
ORDER BY TotalSales;

-- Based on the revenue--
SELECT od.pizza_id, SUM(od.quantity * p.Price) AS TotalRevenue
FROM order_details od
INNER JOIN orders o
	ON od.order_id = o.order_id
INNER JOIN pizzas p
	ON od.pizza_id = p.pizza_id
GROUP BY od.pizza_id
ORDER BY TotalRevenue;
-- 5. What is the average order value for each pizza category (e.g., Vegetarian, Non-Vegetarian, etc.)?
SELECT pt.Category, AVG(o.quantity * p.price) as order_Value
FROM order_details o
INNER JOIN pizzas p
	ON o.pizza_id = p.pizza_id
INNER JOIN pizza_types pt
	ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.Category;

-- 6. Are there any trends in sales based on the day of the week?

SELECT DAYNAME(o.date) AS Day, SUM(od.Quantity) as Sales_trend
FROM orders o
INNER JOIN order_details od
	ON o.order_id = od.order_id
GROUP BY Day
ORDER BY Sales_trend DESC;