-- REPORTS SAMPLE — orders per delivery service/courier
SELECT
    d.service_name,
    COUNT(*) AS total_orders
FROM Orders o
JOIN Delivery d ON o.order_id = d.order_id
GROUP BY d.service_name;

-- A. Basic SQL Queries

-- 1. SELECT — View all customers
SELECT * FROM Customer;

-- 2. SELECT — View all available products
SELECT product_name, category, price
FROM Product
WHERE availability_status = 'Available';

-- 3. SELECT — View all pending orders
SELECT order_id, customer_id, order_date, total_amount
FROM Orders
WHERE status = 'Pending';

-- 4. INSERT — Add a new customer
INSERT INTO Customer (name, contact_number, complete_address)
VALUES ('Jose Rizal', '09501234567', 'Kawit, Cavite');

-- 5. INSERT — Add a new order
INSERT INTO Orders (customer_id, order_date, status, total_amount)
VALUES (9, '2026-05-25 10:00:00', 'Pending', 249.00);

-- 6. UPDATE — Mark an order as completed
UPDATE Orders
SET status = 'Completed'
WHERE order_id = 12;

-- 7. UPDATE — Set a product as unavailable
UPDATE Product
SET availability_status = 'Unavailable'
WHERE product_id = 3;

-- 8. DELETE — Remove a customer record
DELETE FROM Customer
WHERE customer_id = 9;

-- B. Complex Queries

-- 9. JOIN — View full order details with customer name and product name
SELECT 
    o.order_id,
    c.name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.subtotal,
    o.status
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Product p ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- 10. JOIN — View all delivery orders with courier and status
SELECT 
    o.order_id,
    c.name AS customer_name,
    d.courier_type,
    d.delivery_address,
    d.delivery_status,
    d.delivery_fee
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Delivery d ON o.order_id = d.order_id;

-- 11. JOIN — View payment details with customer name and order date
SELECT 
    c.name AS customer_name,
    o.order_date,
    o.total_amount,
    py.payment_method,
    py.amount_received,
    py.change_due,
    py.payment_status
FROM Payment py
JOIN Orders o ON py.order_id = o.order_id
JOIN Customer c ON o.customer_id = c.customer_id;

-- 12. JOIN — View ingredients used per product
SELECT 
    p.product_name,
    i.ingredient_name,
    pi.quantity_required,
    i.unit_of_measurement
FROM Product_Ingredient pi
JOIN Product p ON pi.product_id = p.product_id
JOIN Inventory i ON pi.inventory_id = i.inventory_id
ORDER BY p.product_name;

-- 13. AGGREGATION — Total sales per day
SELECT 
    DATE(order_date) AS sale_date,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales
FROM Orders
WHERE status = 'Completed'
GROUP BY DATE(order_date)
ORDER BY sale_date;

-- 14. AGGREGATION — Best-selling products by quantity sold
SELECT 
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.subtotal) AS total_revenue
FROM Order_Items oi
JOIN Product p ON oi.product_id = p.product_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

-- 15. AGGREGATION — Average order value per customer
SELECT 
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    AVG(o.total_amount) AS average_order_value
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.status = 'Completed'
GROUP BY c.name
ORDER BY average_order_value DESC;

-- 16. FILTER AND SORT — View orders within a specific date range
SELECT 
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.total_amount,
    o.status
FROM Orders o
JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2026-05-20' AND '2026-05-22'
ORDER BY o.order_date ASC;

-- 17. FILTER AND SORT — View payment breakdown by payment method
SELECT 
    payment_method,
    COUNT(payment_id) AS total_transactions,
    SUM(amount_received) AS total_collected
FROM Payment
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_collected DESC;

-- C. Reports and Outputs

-- 18. REPORT — Low stock alert (ingredients below reorder level)
SELECT 
    ingredient_name,
    category,
    unit_of_measurement,
    stock_quantity,
    reorder_level,
    (reorder_level - stock_quantity) AS shortage_amount
FROM Inventory
WHERE stock_quantity < reorder_level
ORDER BY shortage_amount DESC;

-- 19. REPORT — Daily cash flow summary (revenue vs purchase expenses)
SELECT 
    DATE(o.order_date) AS date,
    SUM(o.total_amount) AS total_revenue,
    COALESCE((
        SELECT SUM(po.total_amount)
        FROM Purchase_Order po
        WHERE DATE(po.purchase_date) = DATE(o.order_date)
        AND po.status = 'Delivered'
    ), 0) AS total_expenses,
    SUM(o.total_amount) - COALESCE((
        SELECT SUM(po.total_amount)
        FROM Purchase_Order po
        WHERE DATE(po.purchase_date) = DATE(o.order_date)
        AND po.status = 'Delivered'
    ), 0) AS net_cash_flow
FROM Orders o
WHERE o.status = 'Completed'
GROUP BY DATE(o.order_date)
ORDER BY date;

-- 20. REPORT — Inventory consumption per product sold
SELECT 
    i.ingredient_name,
    i.unit_of_measurement,
    i.stock_quantity AS current_stock,
    SUM(pi.quantity_required * oi.quantity) AS total_consumed,
    i.stock_quantity - SUM(pi.quantity_required * oi.quantity) AS estimated_remaining
FROM Order_Items oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Product_Ingredient pi ON oi.product_id = pi.product_id
JOIN Inventory i ON pi.inventory_id = i.inventory_id
WHERE o.status = 'Completed'
GROUP BY i.ingredient_name, i.unit_of_measurement, i.stock_quantity
ORDER BY estimated_remaining ASC;