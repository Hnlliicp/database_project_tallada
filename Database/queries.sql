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



-- Inventory Deduction Function
-- Quick look at starting stock before any test

SELECT inventory_id, ingredient_name, stock_quantity
FROM Inventory
ORDER BY inventory_id;


-- TEST 1: trg_deduct_inventory
-- Trigger: AFTER INSERT ON Order_Items
-- Expected: Stock of ingredients used by product_id 1
--           (Classic Crispy Chicken Burger w/ Coke) should DROP.

-- Step 1A: Insert a test customer
INSERT INTO Customer (name, contact_number, complete_address)
VALUES ('Test Customer', '09990001111', 'Imus, Cavite');

-- Step 1B: Insert a test order for that customer
INSERT INTO Orders (customer_id, status)
VALUES ((SELECT customer_id FROM Customer WHERE name = 'Test Customer'),'Pending');

-- Step 1C: Insert an order item — this should fire trg_deduct_inventory function

INSERT INTO Order_Items(order_id, product_id, quantity, subtotal) VALUES
(13, 1, 2, 318.00);

-- Step 1D: CHECK — stock should have decreased for ingredients of product 1
-- (Chicken Breast, Burger Bun, Burger Sauce, Cooking Oil, Softdrink Syrup) 
-- Basically the Ingredients used for Classic Crispy Chicken Burger w/ Coke
SELECT i.inventory_id, i.ingredient_name, i.stock_quantity
FROM Inventory i
JOIN Product_Ingredient pi ON i.inventory_id = pi.inventory_id
WHERE pi.product_id = 1
ORDER BY i.inventory_id;


-- TEST 2: trg_adjust_inventory_on_order_update
-- Trigger: AFTER UPDATE ON Order_Items
-- Expected: Stock adjusts — reverses qty 2, applies qty 4.
--           Ingredients should be deducted by 2 more (net difference).

-- Step 2A: Update the order item quantity from 2 to 4
UPDATE Order_Items
SET quantity = 4, subtotal = 636.00
WHERE order_id = (
    SELECT order_id FROM Orders WHERE customer_id =
        (SELECT customer_id FROM Customer WHERE name = 'Test Customer') LIMIT 1
)
AND product_id = 1;

-- Step 2B: CHECK — stock should have decreased by 2 more units worth
SELECT i.inventory_id, i.ingredient_name, i.stock_quantity
FROM Inventory i
JOIN Product_Ingredient pi ON i.inventory_id = pi.inventory_id
WHERE pi.product_id = 1
ORDER BY i.inventory_id;


-- TEST 3: trg_restore_inventory_on_order_delete
-- Trigger: AFTER DELETE ON Order_Items
-- Expected: Stock goes BACK UP by the qty 4 that was deducted.

-- Step 3A: Delete the order item (simulating cancellation)
DELETE FROM Order_Items
WHERE order_id = (
    SELECT order_id FROM Orders WHERE customer_id =
        (SELECT customer_id FROM Customer WHERE name = 'Test Customer') LIMIT 1
)
AND product_id = 1;

-- Step 3B: See if the Inventory Ingredient Quantities come back to before

SELECT i.inventory_id, i.ingredient_name, i.stock_quantity
FROM Inventory i
JOIN Product_Ingredient pi ON i.inventory_id = pi.inventory_id
WHERE pi.product_id = 1
ORDER BY i.inventory_id;


-- TEST 4: trg_update_order_total
-- Trigger: AFTER INSERT OR UPDATE OR DELETE ON Order_Items
-- Expected: Orders.total_amount updates automatically.

-- Step 4A: Add two items back to the order
INSERT INTO Order_Items (order_id, product_id, quantity, subtotal)
VALUES (
    (SELECT order_id FROM Orders WHERE customer_id =
        (SELECT customer_id FROM Customer WHERE name = 'Test Customer') LIMIT 1),
    1, 1, 159.00   -- 1x Classic Crispy Chicken Burger
);

INSERT INTO Order_Items (order_id, product_id, quantity, subtotal)
VALUES (
    (SELECT order_id FROM Orders WHERE customer_id =
        (SELECT customer_id FROM Customer WHERE name = 'Test Customer') LIMIT 1),
    20, 1, 75.00   -- 1x Flavored Fries Snap
);

-- Step 4B: CHECK — total_amount should be 159 + 75 = 234.00
SELECT o.order_id, o.total_amount
FROM Orders o
WHERE o.customer_id = (
    SELECT customer_id FROM Customer WHERE name = 'Test Customer'
);

-- Step 4C: Delete one item and check total drops
DELETE FROM Order_Items
WHERE order_id = (
    SELECT order_id FROM Orders WHERE customer_id =
        (SELECT customer_id FROM Customer WHERE name = 'Test Customer') LIMIT 1
)
AND product_id = 20;

-- Step 4D: CHECK — total_amount should now be 159.00 only
SELECT o.order_id, o.total_amount
FROM Orders o
WHERE o.customer_id = (
    SELECT customer_id FROM Customer WHERE name = 'Test Customer'
);


-- TEST 5: trg_restock_inventory_on_purchase
-- Trigger: AFTER INSERT ON Purchase_Order_Items
-- Expected: Stock of inventory_id 1 (Chicken Breast) should GO UP.

-- Step 5A: Create a purchase order from supplier 1
INSERT INTO Purchase_Order (supplier_id, total_amount, status)
VALUES (1, 3000.00, 'Delivered');

-- Step 5B: Check stock of Chicken Breast BEFORE restock
SELECT inventory_id, ingredient_name, stock_quantity
FROM Inventory
WHERE inventory_id = 1;

-- Step 5C: Insert purchase order item — fires trg_restock_inventory_on_purchase
INSERT INTO Purchase_Order_Items (purchase_order_id, inventory_id, quantity, unit_cost, subtotal)
VALUES ((SELECT purchase_order_id FROM Purchase_Order 
    ORDER BY purchase_order_id DESC LIMIT 1),
    1, 10.00, 200.00, 2000.00);

-- Step 5D: CHECK — Chicken Breast stock should have increased by 10
SELECT inventory_id, ingredient_name, stock_quantity
FROM Inventory
WHERE inventory_id = 1;


-- TEST 6: trg_adjust_inventory_on_purchase_update
-- Trigger: AFTER UPDATE ON Purchase_Order_Items
-- Expected: Old qty (10) is reversed, new qty (15) is applied.
--           Net change = +5 more kg of Chicken Breast.

-- Step 6A: Update the purchase order item quantity from 10 to 15
UPDATE Purchase_Order_Items
SET quantity = 15.00, subtotal = 3000.00
WHERE purchase_order_id = (
    SELECT purchase_order_id FROM Purchase_Order ORDER BY purchase_order_id DESC LIMIT 1
)
AND inventory_id = 1;

-- Step 6B: CHECK — Chicken Breast stock should have gone up by 5 more
SELECT inventory_id, ingredient_name, stock_quantity
FROM Inventory
WHERE inventory_id = 1;


-- CLEANUP ONLY!! FOR FUNCTION TEST REMOVAL!!

DELETE FROM Orders
WHERE customer_id = (
    SELECT customer_id FROM Customer WHERE name = 'Test Customer'
);

DELETE FROM Customer WHERE name = 'Test Customer';

DELETE FROM Purchase_Order_Items
WHERE purchase_order_id = (
    SELECT purchase_order_id FROM Purchase_Order ORDER BY purchase_order_id DESC LIMIT 1
);

DELETE FROM Purchase_Order
WHERE purchase_order_id = (
    SELECT purchase_order_id FROM Purchase_Order ORDER BY purchase_order_id DESC LIMIT 1
);