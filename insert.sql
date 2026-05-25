-- CUSTOMERS
INSERT INTO Customer (name, contact_number, complete_address)
VALUES
('Juan Dela Cruz', '09171234567', 'Imus, Cavite'),
('Maria Santos', '09987654321', 'Bacoor, Cavite'),
('Carlo Reyes', '09175554444', 'Dasmarinas, Cavite'),
('Ana Villanueva', '09561112222', 'Dasmarinas, Cavite'),
('Mark Bautista', '09394445555', 'General Trias, Cavite'),
('Liza Gomez', '09207776666', 'Imus, Cavite'),
('Ryan Castillo', '09118889999', 'Bacoor, Cavite'),
('Jenny Flores', '09450001111', 'Dasmarinas, Cavite');

-- PRODUCTS
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES
('2-PC Boneless Chicken Meal', 'Meals', 149.00, '2-piece boneless chicken with rice', 'Available'),
('Spicy Chicken Fillet', 'Meals', 129.00, 'Spicy chicken fillet with rice', 'Available'),
('Cheesy Fries', 'Sides', 89.00, 'Fries topped with cheese sauce', 'Available'),
('Coke Regular', 'Drinks', 45.00, 'Regular Coca-Cola drink', 'Available'),
('4-PC Boneless Chicken Meal', 'Meals', 249.00, '4-piece boneless chicken with rice', 'Available'),
('Java Rice', 'Sides', 40.00, 'Garlic fried rice', 'Available'),
('Lipton Iced Tea', 'Drinks', 45.00, 'Chilled Lipton iced tea', 'Available'),
('Mac and Cheese Bowl', 'Meals', 189.00, 'Creamy mac and cheese with boneless chicken', 'Available');

-- INVENTORY
INSERT INTO Inventory (ingredient_name, category, unit_of_measurement, stock_quantity, reorder_level)
VALUES
('Chicken Breast', 'Meat', 'kg', 25, 10),
('Rice', 'Grains', 'kg', 50, 15),
('Cooking Oil', 'Condiments', 'liters', 20, 5),
('Potatoes', 'Vegetables', 'kg', 30, 10),
('Cheese Sauce', 'Condiments', 'liters', 4, 5),
('Softdrink Syrup', 'Beverages', 'liters', 3, 5),
('Iced Tea Concentrate', 'Beverages', 'liters', 2, 4),
('Macaroni', 'Grains', 'kg', 8, 5),
('Java Rice Mix', 'Condiments', 'kg', 3, 4);

-- PRODUCT_INGREDIENT
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required)
VALUES
-- 2-PC Boneless Chicken Meal
(1, 1, 0.25),
(1, 2, 0.20),
(1, 3, 0.05),
-- Spicy Chicken Fillet
(2, 1, 0.20),
(2, 2, 0.20),
(2, 3, 0.05),
-- Cheesy Fries
(3, 4, 0.30),
(3, 5, 0.10),
-- Coke Regular
(4, 6, 0.05),
-- 4-PC Boneless Chicken Meal
(5, 1, 0.50),
(5, 2, 0.40),
(5, 3, 0.10),
-- Java Rice
(6, 9, 0.15),
(6, 2, 0.15),
-- Lipton Iced Tea
(7, 7, 0.10),
-- Mac and Cheese Bowl
(8, 8, 0.20),
(8, 5, 0.15),
(8, 1, 0.25);

-- SUPPLIER
INSERT INTO Supplier (supplier_name, contact_number)
VALUES
('Cavite Poultry Supply', '09178889999'),
('Fresh Grains Trading', '09223334444'),
('Metro Beverage Distributor', '09335556666');

-- PURCHASE_ORDER
INSERT INTO Purchase_Order (supplier_id, total_amount, status)
VALUES
(1, 5000.00, 'Delivered'),
(2, 3000.00, 'Delivered'),
(3, 2500.00, 'Pending'),
(1, 4000.00, 'Delivered'),
(2, 1500.00, 'Delivered');

-- PURCHASE_ORDER_ITEMS
INSERT INTO Purchase_Order_Items (purchase_order_id, inventory_id, quantity, unit_cost, subtotal)
VALUES
(1, 1, 20, 200.00, 4000.00),
(2, 2, 30, 100.00, 3000.00),
(3, 6, 10, 250.00, 2500.00),
(4, 1, 15, 200.00, 3000.00),
(4, 3, 5, 200.00, 1000.00),
(5, 2, 10, 100.00, 1000.00),
(5, 8, 5, 100.00, 500.00);

-- ORDERS
-- spread across different dates for daily sales queries
INSERT INTO Orders (customer_id, order_date, fulfillment_type, status, total_amount)
VALUES
(1, '2026-05-20 10:30:00', 'Pickup', 'Completed', 194.00),
(2, '2026-05-20 11:45:00', 'Pickup', 'Completed', 278.00),
(3, '2026-05-20 13:00:00', 'Delivery', 'Completed', 174.00),
(4, '2026-05-21 09:15:00', 'Pickup', 'Completed', 249.00),
(5, '2026-05-21 12:30:00', 'Delivery', 'Completed', 338.00),
(6, '2026-05-22 10:00:00', 'Pickup', 'Completed', 149.00),
(7, '2026-05-22 14:00:00', 'Delivery', 'Completed', 234.00),
(8, '2026-05-23 11:00:00', 'Pickup', 'Completed', 189.00),
(1, '2026-05-23 13:30:00', 'Delivery', 'Completed', 294.00),
(2, '2026-05-24 10:00:00', 'Pickup', 'Completed', 149.00),
(3, '2026-05-24 15:00:00', 'Pickup', 'Completed', 89.00),
(4, '2026-05-25 09:00:00', 'Delivery', 'Pending', 338.00);

-- ORDER_ITEMS
INSERT INTO Order_Items (order_id, product_id, quantity, subtotal)
VALUES
-- Order 1: 2-PC Meal + Coke
(1, 1, 1, 149.00),
(1, 4, 1, 45.00),
-- Order 2: Spicy Fillet + Cheesy Fries + 2x Coke
(2, 2, 1, 129.00),
(2, 3, 1, 89.00),
(2, 4, 2, 90.00),
-- Order 3: 2-PC Meal + Coke
(3, 1, 1, 149.00),
(3, 4, 1, 45.00),
-- Order 4: 4-PC Meal
(4, 5, 1, 249.00),
-- Order 5: 4-PC Meal + Cheesy Fries + Coke
(5, 5, 1, 249.00),
(5, 3, 1, 89.00),
-- Order 6: 2-PC Meal
(6, 1, 1, 149.00),
-- Order 7: 2-PC Meal + Java Rice + Iced Tea
(7, 1, 1, 149.00),
(7, 6, 1, 40.00),
(7, 7, 1, 45.00),
-- Order 8: Mac and Cheese Bowl
(8, 8, 1, 189.00),
-- Order 9: 4-PC Meal + Iced Tea
(9, 5, 1, 249.00),
(9, 7, 1, 45.00),
-- Order 10: 2-PC Meal
(10, 1, 1, 149.00),
-- Order 11: Cheesy Fries
(11, 3, 1, 89.00),
-- Order 12: 4-PC Meal + Cheesy Fries + Coke
(12, 5, 1, 249.00),
(12, 3, 1, 89.00);

-- PAYMENT
INSERT INTO Payment (order_id, payment_method, amount_received, change_due, payment_status)
VALUES
(1, 'Cash', 200.00, 6.00, 'Paid'),
(2, 'GCash', 278.00, 0.00, 'Paid'),
(3, 'GCash', 174.00, 0.00, 'Paid'),
(4, 'Cash', 300.00, 51.00, 'Paid'),
(5, 'Bank Transfer', 338.00, 0.00, 'Paid'),
(6, 'Cash', 150.00, 1.00, 'Paid'),
(7, 'GCash', 234.00, 0.00, 'Paid'),
(8, 'Cash', 200.00, 11.00, 'Paid'),
(9, 'COD', 300.00, 6.00, 'Paid'),
(10, 'GCash', 149.00, 0.00, 'Paid'),
(11, 'Cash', 100.00, 11.00, 'Paid'),
(12, 'COD', 0.00, 0.00, 'Pending');

-- DELIVERY
-- only for orders with Fulfillment_Type = Delivery
INSERT INTO Delivery (order_id, courier_type, delivery_address, delivery_status, delivery_fee)
VALUES
(3, 'Own Rider', 'Dasmarinas, Cavite', 'Delivered', 50.00),
(5, 'Lalamove', 'General Trias, Cavite', 'Delivered', 80.00),
(7, 'Own Rider', 'Bacoor, Cavite', 'Delivered', 50.00),
(9, 'Own Rider', 'Imus, Cavite', 'Delivered', 50.00),
(12, 'Lalamove', 'Dasmarinas, Cavite', 'Out for Delivery', 80.00);