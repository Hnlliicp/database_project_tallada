INSERT INTO Customer (name, contact_number, complete_address)
VALUES
('Juan Dela Cruz', '09171234567', 'Imus, Cavite'),
('Maria Santos', '09987654321', 'Bacoor, Cavite'),
('Carlo Reyes', '09175554444', 'Dasmarinas, Cavite');

INSERT INTO Delivery_Service (service_name, contact_number, delivery_type)VALUES
('GrabFood', 'N/A', 'Delivery'),
('Foodpanda', 'N/A', 'Delivery'),
('Lalamove', 'N/A', 'Delivery'),
('Store Pickup', 'N/A', 'Take-Out');

INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES
('2-PC Boneless Chicken Meal', 'Meals', 149.00, '2-piece boneless chicken with rice', 'Available'),

('Spicy Chicken Fillet', 'Meals', 129.00, 'Spicy chicken fillet with rice', 'Available'),

('Cheesy Fries', 'Sides', 89.00, 'Fries topped with cheese sauce', 'Available'),

('Coke Regular', 'Drinks', 45.00, 'Regular Coca-Cola drink', 'Available');

INSERT INTO Orders (customer_id, delivery_service_id, status, total_amount)
VALUES
(1, 1, 'Completed', 194.00),
(2, 1, 'Completed', 278.00),
(3, 1, 'Pending', 174.00);

INSERT INTO Order_Items (order_id, product_id, quantity, subtotal)
VALUES
(1, 1, 1, 149.00),
(1, 4, 1, 45.00),

(2, 2, 1, 129.00),
(2, 3, 1, 89.00),
(2, 4, 2, 90.00),

(3, 1, 1, 149.00),
(3, 4, 1, 45.00);

INSERT INTO Payment (order_id, payment_method, amount_received, change_due, payment_status)
VALUES
(1, 'Cash', 200.00, 6.00, 'Paid'),
(2, 'GCash', 278.00, 0.00, 'Paid'),
(3, 'Cash', 200.00, 26.00, 'Pending');

INSERT INTO Inventory (ingredient_name, category, unit_of_measurement, stock_quantity, reorder_level)
VALUES
('Chicken Breast', 'Meat', 'kg', 25, 10),

('Rice', 'Grains', 'kg', 50, 15),

('Cooking Oil', 'Condiments', 'liters', 20, 5),

('Potatoes', 'Vegetables', 'kg', 30, 10),

('Cheese Sauce', 'Condiments', 'liters', 8, 3),

('Softdrink Syrup', 'Beverages', 'liters', 12, 5);

INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required)
VALUES
(1, 1, 0.25),
(1, 2, 0.20),
(1, 3, 0.05),

(2, 1, 0.20),
(2, 2, 0.20),
(2, 3, 0.05),

(3, 4, 0.30),
(3, 5, 0.10),

(4, 6, 0.05);

INSERT INTO Supplier (supplier_name, contact_number)
VALUES
('Cavite Poultry Supply', '09178889999'),
('Fresh Grains Trading', '09223334444'),
('Metro Beverage Distributor', '09335556666');

INSERT INTO Purchase_Order (supplier_id, total_amount, status)
VALUES
(1, 5000.00, 'Delivered'),
(2, 3000.00, 'Delivered'),
(3, 2500.00, 'Pending');

INSERT INTO Purchase_Order_Items (
    purchase_order_id,
    inventory_id,
    quantity,
    unit_cost,
    subtotal
)
VALUES
(1, 1, 20, 200.00, 4000.00),

(2, 2, 30, 100.00, 3000.00),

(3, 6, 10, 250.00, 2500.00);
