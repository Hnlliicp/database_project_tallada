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
-- INNER JOIN: every row needs a valid customer, order item, and product to be meaningful
SELECT
    o.order_id,
    c.name AS customer_name,
    p.product_name,
    oi.quantity,
    oi.subtotal,
    o.status
FROM Orders o
INNER JOIN Customer c ON o.customer_id = c.customer_id
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN Product p ON oi.product_id = p.product_id
ORDER BY o.order_id;

-- 10. JOIN — View all delivery orders with courier and status
-- LEFT JOIN: show all orders, delivery info shown only where it exists
SELECT
    o.order_id,
    c.name AS customer_name,
    d.courier_type,
    d.delivery_address,
    d.delivery_status,
    d.delivery_fee
FROM Orders o
INNER JOIN Customer c ON o.customer_id = c.customer_id
LEFT JOIN Delivery d ON o.order_id = d.order_id;

-- 11. JOIN — View payment details with customer name and order date
-- LEFT JOIN: show all payments even if order/customer data is incomplete
SELECT
    c.name AS customer_name,
    o.order_date,
    o.total_amount,
    py.payment_method,
    py.amount_received,
    py.change_due,
    py.payment_status
FROM Payment py
LEFT JOIN Orders o ON py.order_id = o.order_id
LEFT JOIN Customer c ON o.customer_id = c.customer_id;

-- 12. JOIN — View ingredients used per product
-- RIGHT JOIN: show all inventory items even if not yet linked to any product
SELECT
    p.product_name,
    i.ingredient_name,
    pi.quantity_required,
    i.unit_of_measurement
FROM Product_Ingredient pi
RIGHT JOIN Inventory i ON pi.inventory_id = i.inventory_id
LEFT JOIN Product p ON pi.product_id = p.product_id
ORDER BY p.product_name;

-- 13. AGGREGATION — Total sales per day
-- No JOIN needed; single table aggregation
SELECT
    DATE(order_date) AS sale_date,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS total_sales
FROM Orders
WHERE status = 'Completed'
GROUP BY DATE(order_date)
ORDER BY sale_date;

-- 14. AGGREGATION — Best-selling products by quantity sold
-- RIGHT JOIN Product: show all products even if never ordered (sold qty = 0)
SELECT
    p.product_name,
    COALESCE(SUM(oi.quantity), 0) AS total_quantity_sold,
    COALESCE(SUM(oi.subtotal), 0) AS total_revenue
FROM Order_Items oi
INNER JOIN Orders o ON oi.order_id = o.order_id
    AND o.status = 'Completed'
RIGHT JOIN Product p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_quantity_sold DESC;

-- 15. AGGREGATION — Average order value per customer
-- FULL OUTER JOIN: show all customers and all orders
-- even if a customer has no orders or an order has no customer
SELECT
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(AVG(o.total_amount), 0) AS average_order_value
FROM Orders o
FULL OUTER JOIN Customer c ON o.customer_id = c.customer_id
WHERE o.status = 'Completed' OR o.status IS NULL
GROUP BY c.name
ORDER BY average_order_value DESC;

-- 16. FILTER AND SORT — View orders within a specific date range
-- LEFT JOIN: show all orders in range, customer name shown where available
SELECT
    o.order_id,
    c.name AS customer_name,
    o.order_date,
    o.total_amount,
    o.status
FROM Orders o
LEFT JOIN Customer c ON o.customer_id = c.customer_id
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
    COALESCE(po_daily.total_expenses, 0) AS total_expenses,
    SUM(o.total_amount) - COALESCE(po_daily.total_expenses, 0) AS net_cash_flow
FROM Orders o
LEFT JOIN (
    SELECT
        DATE(purchase_date) AS purchase_day,
        SUM(total_amount) AS total_expenses
    FROM Purchase_Order
    WHERE status = 'Delivered'
    GROUP BY DATE(purchase_date)
) po_daily ON DATE(o.order_date) = po_daily.purchase_day
WHERE o.status = 'Completed'
GROUP BY DATE(o.order_date), po_daily.total_expenses
ORDER BY date;

-- 20. REPORT — Inventory consumption per product sold
SELECT 
    i.ingredient_name,
    i.unit_of_measurement,
    i.stock_quantity AS current_stock,
    COALESCE(SUM(pi.quantity_required * oi.quantity), 0) AS total_consumed,
    i.stock_quantity - COALESCE(SUM(pi.quantity_required * oi.quantity), 0) AS estimated_remaining
FROM Order_Items oi
JOIN Orders o ON oi.order_id = o.order_id
JOIN Product_Ingredient pi ON oi.product_id = pi.product_id
JOIN Inventory i ON pi.inventory_id = i.inventory_id
WHERE o.status = 'Completed'
GROUP BY i.ingredient_name, i.unit_of_measurement, i.stock_quantity
ORDER BY estimated_remaining ASC;

-- Inventory Deduction Function Queries -----------------------------------------------

-- 1st Step: See ingredient names for Party Tray Chicken Wings (40 pcs) 
-- Chicken (wings), Cooking Oil, and Signature Wing Sauce

SELECT ingredient_name, stock_quantity FROM inventory
WHERE inventory_id IN (1, 21, 3);

-- 2nd Step: Insert order of Party Tray Chicken Wings (40 pcs)
INSERT INTO Order_Items(order_id, product_id, quantity, subtotal) VALUES
(1, 16, 1, 1689.00);

-- 3rd Step: Run Inventory and check if Ingredient stock_quantity is deducted
SELECT ingredient_name, stock_quantity FROM inventory
WHERE inventory_id IN (1, 21, 3);

-- Order Update, Insert & Delete Function Queries -------------------------------------

-- 1st Step: Run to see values of order_id = 1 before customer insert
SELECT * FROM orders
where order_id = 1; 

-- 2nd Step: Insert 2 products in the customers order (order_id = 1)
INSERT INTO Order_Items(order_id, product_id, quantity, subtotal)
VALUES
(1, 1, 2, 298.00),
(1, 2, 3, 387.00);

-- 3rd Step: Check if Products are successfully updated inside order_items list (order_id = 1) 
SELECT * FROM order_items
WHERE order_id = 1;

-- 4th Step: Check if total amount is updated in Orders where order_id = 1
SELECT * FROM orders
where order_id = 1;

-- One Payment per Order ---------------------------------------------------------------------

-- First payment for order_id = 1
SELECT payment_id, payment_method, amount_received, 
change_due, payment_status FROM Payment
WHERE order_id = 1;

-- Attempt second payment for same order_id
INSERT INTO Payment (order_id, payment_method, amount_received, 
change_due, payment_status)
VALUES (1, 'Cash', 200.00, 6.00, 'Paid');

-- One Delivery per Order ---------------------------------------------------------------------

-- First delivery for order_id = 1
SELECT delivery_id, courier_type, delivery_address, delivery_status, delivery_fee FROM Delivery
WHERE order_id = 1;

-- Attempt second delivery for same order_id
INSERT INTO Delivery (order_id, service_name, courier_type, delivery_address, delivery_status, delivery_fee)
VALUES (1, 'Lalamove', 'Lalamove', 'Imus, Cavite', 'Preparing', 80.00);

-- CHECK — Order_Items.quantity >= 1 --------------------------------------------------------------

-- Attempt to insert order item with quantity 0
INSERT INTO Order_Items (order_id, product_id, quantity, subtotal)
VALUES (1, 1, 0, 0.00); 

-- DEFAULT Orders.order_date ------------------------------------------------------------------------------

-- Insert order without specifying order_date
INSERT INTO Orders (customer_id, status, total_amount)
VALUES (1, 'Pending', 500.00);

SELECT order_id, order_date FROM Orders WHERE customer_id = 1 
ORDER BY order_id DESC LIMIT 1;

-- NOT NULL Customer.name ------------------------------------------------------------------------------

-- Attempt to insert customer without name
INSERT INTO Customer (name, contact_number, complete_address)
VALUES (NULL, '09171234567', 'Imus, Cavite');

-- FOREIGN KEY Orders.customer_id ------------------------------------------------------------------------------

-- Attempt to insert order with non-existent customer_id
INSERT INTO Orders (customer_id, order_date, status, total_amount)
VALUES (999, '2026-05-26 10:00:00', 'Pending', 300.00);