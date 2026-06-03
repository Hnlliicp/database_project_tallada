-- CUSTOMERS 
INSERT INTO Customer (name, contact_number, complete_address)
VALUES
('Juan Dela Cruz',   '09171234567', 'Imus, Cavite'),
('Maria Santos',     '09987654321', 'Bacoor, Cavite'),
('Carlo Reyes',      '09175554444', 'Dasmarinas, Cavite'),
('Ana Villanueva',   '09561112222', 'Dasmarinas, Cavite'),
('Mark Bautista',    '09394445555', 'General Trias, Cavite'),
('Liza Gomez',       '09207776666', 'Imus, Cavite'),
('Ryan Castillo',    '09118889999', 'Bacoor, Cavite'),
('Jenny Flores',     '09450001111', 'Dasmarinas, Cavite');

-- PRODUCTS

-- ── BURGER MEALS 
-- product_id 1
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Classic Crispy Chicken Burger w/ Coke', 'Burger Meal', 159.00,
        'Crispy Fried Coo Roo Chicken Chunk with our signature burger sauce.', 'Available');

-- product_id 2
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Classic CC Burger w/ Fries & Coke', 'Burger Meal', 229.00,
        'Smoky BBQ sauce, crispy bacon, melted cheddar, and caramelized onions.', 'Available');

-- product_id 3
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Classic CC Burger w/ Crunches & Coke', 'Burger Meal', 269.00,
        'Crispy Fried Coo Roo Chicken Chunk with our signature burger sauce.', 'Available');

-- product_id 4
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Ultimate Crispy Chicken Burger & Coke', 'Burger Meal', 199.00,
        'Crispy Fried Coo Roo Chicken Chunk with tomato, lettuce, cucumber, onion and our signature burger sauce.', 'Available');

-- product_id 5
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Ultimate CC Burger w/ Fries & Coke', 'Burger Meal', 279.00,
        'Ultimate Crispy Fried Coo Roo Crispy Chicken burger with Crispy Flavored Fries.', 'Available');

-- product_id 6
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Ultimate CC Burger w/ Crunches & Coke', 'Burger Meal', 309.00,
        'Ultimate Crispy Fried Coo Roo Crispy Chicken burger with flavored Crispy chicken skin.', 'Available');

-- ── WINGS & BONELESS MEALS 
-- product_id 7
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Solo Boneless Chicken w/ Drink', 'Wings & Boneless Meal', 194.00,
        'Boneless chicken meal for 1 person with your choice of 1–2 signature sauces and a drink.', 'Available');

-- product_id 8
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Duo Boneless Chicken w/ Drink', 'Wings & Boneless Meal', 294.00,
        'Boneless chicken meal for 2–3 persons with your choice of 1–2 signature sauces and a drink.', 'Available');

-- product_id 9
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Barkada Tray Boneless Chicken', 'Wings & Boneless Tray', 449.00,
        'Boneless chicken tray for 4–5 persons with your choice of 1–2 signature sauces.', 'Available');

-- product_id 10
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Family Tray Boneless Chicken', 'Wings & Boneless Tray', 799.00,
        'Boneless chicken tray for 6–8 persons with up to 4 signature sauces.', 'Available');

-- product_id 11
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Party Tray Boneless Chicken', 'Wings & Boneless Tray', 1569.00,
        'Boneless chicken tray for 15–20 persons with up to 4 signature sauces.', 'Available');

-- product_id 12
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Solo Chicken Wings w/ Drink', 'Wings & Boneless Meal', 214.00,
        '4-piece chicken wings with your choice of 1–2 signature sauces and a drink.', 'Available');

-- product_id 13
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Duo Chicken Wings w/ Drink', 'Wings & Boneless Meal', 374.00,
        '8-piece chicken wings with your choice of 1–2 signature sauces and a drink.', 'Available');

-- product_id 14
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Barkada Tray Chicken Wings', 'Wings & Boneless Tray', 499.00,
        '12-piece chicken wings with your choice of 1–2 signature sauces.', 'Available');

-- product_id 15
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Family Tray Chicken Wings', 'Wings & Boneless Tray', 839.00,
        '20-piece chicken wings with up to 4 signature sauces.', 'Available');

-- product_id 16
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Party Tray Chicken Wings', 'Wings & Boneless Tray', 1689.00,
        '40-piece chicken wings with up to 4 signature sauces.', 'Available');

-- ── SOLO BOWLS 
-- product_id 17
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Java Rice + Chicken w/ Drink', 'Solo Bowl Meal', 199.00,
        'Flavorful java rice topped with crispy boneless chicken tossed and drizzled with your choice of signature sauces, served with a drink.', 'Available');

-- product_id 18
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Fries + Chicken w/ Drink', 'Solo Bowl Meal', 219.00,
        'Crispy fries topped with crispy boneless chicken tossed and drizzled with your choice of signature sauces, served with a drink.', 'Available');

-- product_id 19
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Mac & Cheese + Chicken w/ Drink', 'Solo Bowl Meal', 229.00,
        'Creamy macaroni and cheese topped with crispy boneless chicken tossed and drizzled with your choice of signature sauces, served with a drink.', 'Available');

-- ── FLAVORED FRIES 
-- product_id 20
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Flavored Fries Snap', 'Flavored Fries', 75.00,
        'Small serving of flavored crispy fries.', 'Available');

-- product_id 21
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Flavored Fries Pop', 'Flavored Fries', 99.00,
        'Regular serving of flavored crispy fries.', 'Available');

-- product_id 22
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Flavored Fries Max', 'Flavored Fries', 149.00,
        'Large serving of flavored crispy fries.', 'Available');

-- product_id 23
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Flavored Fries Feast Tub', 'Flavored Fries', 199.00,
        'Sharing-size tub of flavored crispy fries.', 'Available');

-- product_id 24
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Flavored Fries Monster Tub', 'Flavored Fries', 249.00,
        'Extra-large tub of flavored crispy fries for groups.', 'Available');

-- ── DRIZZLED FRIES 
-- product_id 25
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Drizzled Fries Pop', 'Drizzled Fries', 139.00,
        'Crispy fries topped with your choice of 1–2 signature sauces.', 'Available');

-- product_id 26
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Drizzled Fries Max', 'Drizzled Fries', 169.00,
        'Large serving of crispy fries topped with your choice of 1–2 signature sauces.', 'Available');

-- ── CRUNCHES 
-- product_id 27
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Crunches Regular', 'Crunches', 129.00,
        'Crispy chicken skin snack available in Plain, Cheese, BBQ, or Sour Cream Cajun flavor.', 'Available');

-- product_id 28
INSERT INTO Product (product_name, category, price, description, availability_status)
VALUES ('Crunches Large', 'Crunches', 189.00,
        'Large serving of crispy chicken skin snack available in Plain, Cheese, BBQ, or Sour Cream Cajun flavor.', 'Available');

-- SUPPLIER 
INSERT INTO Supplier (supplier_name, contact_number)
VALUES
('Cavite Poultry Supply',       '09178889999'),
('Fresh Grains Trading',        '09223334444'),
('Metro Beverage Distributor',  '09335556666');

-- INVENTORY

INSERT INTO Inventory (supplier_id, ingredient_name, category, unit_of_measurement, stock_quantity, reorder_level)
VALUES
(1, 'Chicken Breast / Boneless Chicken', 'Meat',        'kg',     50, 15),  -- inv 1
(2, 'Rice',                              'Grains',      'kg',     50, 15),  -- inv 2
(3, 'Cooking Oil',                       'Condiments',  'liters', 20,  5),  -- inv 3
(2, 'Potatoes (Fries)',                  'Vegetables',  'kg',     40, 12),  -- inv 4
(3, 'Cheese Sauce',                      'Condiments',  'liters',  6,  3),  -- inv 5
(3, 'Softdrink Syrup (Coke)',            'Beverages',   'liters', 10,  5),  -- inv 6
(3, 'Iced Tea Concentrate',              'Beverages',   'liters',  5,  3),  -- inv 7
(2, 'Macaroni',                          'Grains',      'kg',     10,  4),  -- inv 8
(2, 'Java Rice Mix',                     'Condiments',  'kg',      6,  3),  -- inv 9
(2, 'Burger Bun',                        'Bread',       'pcs',   100, 30),  -- inv 10
(3, 'Burger Sauce / Condiments',         'Condiments',  'liters',  5,  2),  -- inv 11
(2, 'Lettuce',                           'Vegetables',  'kg',      5,  2),  -- inv 12
(2, 'Tomato',                            'Vegetables',  'kg',      5,  2),  -- inv 13
(2, 'Cucumber',                          'Vegetables',  'kg',      3,  1),  -- inv 14
(2, 'Onion',                             'Vegetables',  'kg',      4,  2),  -- inv 15
(3, 'Cheddar Cheese (sliced)',           'Condiments',  'pcs',    50, 15),  -- inv 16
(1, 'Bacon',                             'Meat',        'kg',      5,  2),  -- inv 17
(3, 'BBQ Sauce',                         'Condiments',  'liters',  3,  1),  -- inv 18
(1, 'Chicken Skin (for Crunches)',       'Meat',        'kg',     15,  5),  -- inv 19
(3, 'Seasoning / Flavor Powder',         'Condiments',  'kg',      5,  2),  -- inv 20
(3, 'Signature Wing Sauce Blend',        'Condiments',  'liters',  8,  3);  -- inv 21


-- PRODUCT_INGREDIENT

-- ── BURGER MEALS 

-- 1. Classic Crispy Chicken Burger w/ Coke
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(1, 1,  0.15),   -- Chicken Breast
(1, 10, 1.00),   -- Burger Bun
(1, 11, 0.03),   -- Burger Sauce
(1, 3,  0.05),   -- Cooking Oil
(1, 6,  0.05);   -- Softdrink Syrup (Coke)

-- 2. Classic CC Burger w/ Fries & Coke
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(2, 1,  0.15),   -- Chicken Breast
(2, 10, 1.00),   -- Burger Bun
(2, 11, 0.03),   -- Burger Sauce
(2, 17, 0.05),   -- Bacon
(2, 16, 1.00),   -- Cheddar Cheese (1 slice)
(2, 18, 0.02),   -- BBQ Sauce
(2, 4,  0.20),   -- Potatoes (Fries)
(2, 20, 0.01),   -- Seasoning / Flavor Powder
(2, 3,  0.08),   -- Cooking Oil
(2, 6,  0.05);   -- Softdrink Syrup (Coke)

-- 3. Classic CC Burger w/ Crunches & Coke
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(3, 1,  0.15),   -- Chicken Breast
(3, 10, 1.00),   -- Burger Bun
(3, 11, 0.03),   -- Burger Sauce
(3, 19, 0.10),   -- Chicken Skin (Crunches)
(3, 20, 0.01),   -- Seasoning / Flavor Powder
(3, 3,  0.08),   -- Cooking Oil
(3, 6,  0.05);   -- Softdrink Syrup (Coke)

-- 4. Ultimate Crispy Chicken Burger & Coke
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(4, 1,  0.18),   -- Chicken Breast (larger piece)
(4, 10, 1.00),   -- Burger Bun
(4, 11, 0.04),   -- Burger Sauce
(4, 12, 0.03),   -- Lettuce
(4, 13, 0.05),   -- Tomato
(4, 14, 0.03),   -- Cucumber
(4, 15, 0.02),   -- Onion
(4, 3,  0.05),   -- Cooking Oil
(4, 6,  0.05);   -- Softdrink Syrup (Coke)

-- 5. Ultimate CC Burger w/ Fries & Coke
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(5, 1,  0.18),   -- Chicken Breast
(5, 10, 1.00),   -- Burger Bun
(5, 11, 0.04),   -- Burger Sauce
(5, 12, 0.03),   -- Lettuce
(5, 13, 0.05),   -- Tomato
(5, 14, 0.03),   -- Cucumber
(5, 15, 0.02),   -- Onion
(5, 4,  0.20),   -- Potatoes (Fries)
(5, 20, 0.01),   -- Seasoning / Flavor Powder
(5, 3,  0.08),   -- Cooking Oil
(5, 6,  0.05);   -- Softdrink Syrup (Coke)

-- 6. Ultimate CC Burger w/ Crunches & Coke
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(6, 1,  0.18),   -- Chicken Breast
(6, 10, 1.00),   -- Burger Bun
(6, 11, 0.04),   -- Burger Sauce
(6, 12, 0.03),   -- Lettuce
(6, 13, 0.05),   -- Tomato
(6, 14, 0.03),   -- Cucumber
(6, 15, 0.02),   -- Onion
(6, 19, 0.10),   -- Chicken Skin (Crunches)
(6, 20, 0.01),   -- Seasoning / Flavor Powder
(6, 3,  0.08),   -- Cooking Oil
(6, 6,  0.05);   -- Softdrink Syrup (Coke)

-- ── WINGS & BONELESS MEALS

-- 7. Solo Boneless Chicken w/ Drink
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(7, 1,  0.20),   -- Chicken Breast (boneless)
(7, 3,  0.05),   -- Cooking Oil
(7, 21, 0.03),   -- Signature Wing Sauce
(7, 6,  0.05);   -- Softdrink Syrup (Coke)

-- 8. Duo Boneless Chicken w/ Drink
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(8, 1,  0.40),   -- Chicken Breast (boneless)
(8, 3,  0.08),   -- Cooking Oil
(8, 21, 0.06),   -- Signature Wing Sauce
(8, 6,  0.10);   -- Softdrink Syrup (Coke)

-- 9. Barkada Tray Boneless Chicken (4–5 pax)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(9, 1,  0.80),   -- Chicken Breast (boneless)
(9, 3,  0.15),   -- Cooking Oil
(9, 21, 0.10);   -- Signature Wing Sauce

-- 10. Family Tray Boneless Chicken (6–8 pax)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(10, 1,  1.50),  -- Chicken Breast (boneless)
(10, 3,  0.25),  -- Cooking Oil
(10, 21, 0.18);  -- Signature Wing Sauce

-- 11. Party Tray Boneless Chicken (15–20 pax)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(11, 1,  3.00),  -- Chicken Breast (boneless)
(11, 3,  0.50),  -- Cooking Oil
(11, 21, 0.35);  -- Signature Wing Sauce

-- 12. Solo Chicken Wings w/ Drink (4 pcs)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(12, 1,  0.30),  -- Chicken (wings)
(12, 3,  0.05),  -- Cooking Oil
(12, 21, 0.04),  -- Signature Wing Sauce
(12, 6,  0.05);  -- Softdrink Syrup (Coke)

-- 13. Duo Chicken Wings w/ Drink (8 pcs)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(13, 1,  0.60),  -- Chicken (wings)
(13, 3,  0.08),  -- Cooking Oil
(13, 21, 0.08),  -- Signature Wing Sauce
(13, 6,  0.10);  -- Softdrink Syrup (Coke)

-- 14. Barkada Tray Chicken Wings (12 pcs)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(14, 1,  0.90),  -- Chicken (wings)
(14, 3,  0.15),  -- Cooking Oil
(14, 21, 0.12);  -- Signature Wing Sauce

-- 15. Family Tray Chicken Wings (20 pcs)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(15, 1,  1.50),  -- Chicken (wings)
(15, 3,  0.25),  -- Cooking Oil
(15, 21, 0.20);  -- Signature Wing Sauce

-- 16. Party Tray Chicken Wings (40 pcs)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(16, 1,  3.00),  -- Chicken (wings)
(16, 3,  0.50),  -- Cooking Oil
(16, 21, 0.40);  -- Signature Wing Sauce

-- ── SOLO BOWLS

-- 17. Java Rice + Chicken w/ Drink
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(17, 1,  0.20),  -- Chicken Breast (boneless)
(17, 2,  0.20),  -- Rice
(17, 9,  0.10),  -- Java Rice Mix
(17, 21, 0.03),  -- Signature Wing Sauce (drizzle)
(17, 3,  0.05),  -- Cooking Oil
(17, 6,  0.05);  -- Softdrink Syrup (Coke)

-- 18. Fries + Chicken w/ Drink
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(18, 1,  0.20),  -- Chicken Breast (boneless)
(18, 4,  0.20),  -- Potatoes (Fries)
(18, 20, 0.01),  -- Seasoning / Flavor Powder
(18, 21, 0.03),  -- Signature Wing Sauce (drizzle)
(18, 3,  0.08),  -- Cooking Oil
(18, 6,  0.05);  -- Softdrink Syrup (Coke)

-- 19. Mac & Cheese + Chicken w/ Drink
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(19, 1,  0.20),  -- Chicken Breast (boneless)
(19, 8,  0.15),  -- Macaroni
(19, 5,  0.12),  -- Cheese Sauce
(19, 21, 0.03),  -- Signature Wing Sauce (drizzle)
(19, 3,  0.05),  -- Cooking Oil
(19, 6,  0.05);  -- Softdrink Syrup (Coke)

-- ── FLAVORED FRIES

-- 20. Flavored Fries Snap (small)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(20, 4,  0.10),  -- Potatoes
(20, 20, 0.005), -- Seasoning
(20, 3,  0.04);  -- Cooking Oil

-- 21. Flavored Fries Pop (regular)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(21, 4,  0.15),  -- Potatoes
(21, 20, 0.008), -- Seasoning
(21, 3,  0.05);  -- Cooking Oil

-- 22. Flavored Fries Max (large)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(22, 4,  0.22),  -- Potatoes
(22, 20, 0.012), -- Seasoning
(22, 3,  0.07);  -- Cooking Oil

-- 23. Flavored Fries Feast Tub (sharing)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(23, 4,  0.35),  -- Potatoes
(23, 20, 0.018), -- Seasoning
(23, 3,  0.10);  -- Cooking Oil

-- 24. Flavored Fries Monster Tub (extra-large)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(24, 4,  0.50),  -- Potatoes
(24, 20, 0.025), -- Seasoning
(24, 3,  0.14);  -- Cooking Oil

-- ── DRIZZLED FRIES ───────────────────────────────────────

-- 25. Drizzled Fries Pop (regular + sauce)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(25, 4,  0.15),  -- Potatoes
(25, 20, 0.008), -- Seasoning
(25, 21, 0.04),  -- Signature Wing Sauce (drizzle)
(25, 3,  0.05);  -- Cooking Oil

-- 26. Drizzled Fries Max (large + sauce)
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(26, 4,  0.22),  -- Potatoes
(26, 20, 0.012), -- Seasoning
(26, 21, 0.06),  -- Signature Wing Sauce (drizzle)
(26, 3,  0.07);  -- Cooking Oil

-- ── CRUNCHES 

-- 27. Crunches Regular
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(27, 19, 0.15),  -- Chicken Skin
(27, 20, 0.01),  -- Seasoning / Flavor Powder
(27, 3,  0.05);  -- Cooking Oil

-- 28. Crunches Large
INSERT INTO Product_Ingredient (product_id, inventory_id, quantity_required) VALUES
(28, 19, 0.25),  -- Chicken Skin
(28, 20, 0.015), -- Seasoning / Flavor Powder
(28, 3,  0.08);  -- Cooking Oil

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
(1, 1,  20, 200.00, 4000.00),
(2, 2,  30, 100.00, 3000.00),
(3, 6,  10, 250.00, 2500.00),
(4, 1,  15, 200.00, 3000.00),
(4, 3,   5, 200.00, 1000.00),
(5, 2,  10, 100.00, 1000.00),
(5, 8,   5, 100.00,  500.00);

-- ORDERS
INSERT INTO Orders (customer_id, order_date, status, total_amount)
VALUES
(1, '2026-05-20 10:30:00', 'Completed', 159.00),   -- Classic CC Burger w/ Coke
(2, '2026-05-20 11:45:00', 'Completed', 423.00),   -- Solo Boneless + Crunches Reg
(3, '2026-05-20 13:00:00', 'Completed', 229.00),   -- Classic CC Burger w/ Fries
(4, '2026-05-21 09:15:00', 'Completed', 449.00),   -- Barkada Tray Boneless
(5, '2026-05-21 12:30:00', 'Completed', 578.00),   -- Family Tray Wings + Fries Pop
(6, '2026-05-22 10:00:00', 'Completed', 199.00),   -- Java Rice + Chicken Bowl
(7, '2026-05-22 14:00:00', 'Completed', 308.00),   -- Duo Wings + Flavored Fries Max
(8, '2026-05-23 11:00:00', 'Completed', 229.00),   -- Mac & Cheese Bowl
(1, '2026-05-23 13:30:00', 'Completed', 309.00),   -- Ultimate CC Burger w/ Crunches
(2, '2026-05-24 10:00:00', 'Completed', 199.00),   -- Ultimate CC Burger
(3, '2026-05-24 15:00:00', 'Completed', 75.00),    -- Fries Snap
(4, '2026-05-25 09:00:00', 'Pending',   628.00);   -- Party Tray Boneless (partial)

-- ORDER_ITEMS
INSERT INTO Order_Items (order_id, product_id, quantity, subtotal)
VALUES
-- Order 1: Classic CC Burger w/ Coke
(1,  1,  1, 159.00),

-- Order 2: Solo Boneless + Crunches Regular
(2,  7,  1, 194.00),
(2,  27, 1, 129.00),
(2,  20, 1,  75.00), 

-- Order 3: Classic CC Burger w/ Fries & Coke
(3,  2,  1, 229.00),

-- Order 4: Barkada Tray Boneless
(4,  9,  1, 449.00),

-- Order 5: Family Tray Chicken Wings + Flavored Fries Pop
(5,  15, 1, 839.00),
(5,  21, 1,  99.00),

-- Order 6: Java Rice + Chicken Bowl
(6,  17, 1, 199.00),

-- Order 7: Duo Chicken Wings + Flavored Fries Max
(7,  13, 1, 374.00),
(7,  22, 1, 149.00),

-- Order 8: Mac & Cheese + Chicken Bowl
(8,  19, 1, 229.00),

-- Order 9: Ultimate CC Burger w/ Crunches & Coke
(9,  6,  1, 309.00),

-- Order 10: Ultimate CC Burger & Coke
(10, 4,  1, 199.00),

-- Order 11: Flavored Fries Snap
(11, 20, 1,  75.00),

-- Order 12: Duo Boneless Chicken (Pending)
(12, 8,  1, 294.00),
(12, 25, 1, 139.00);

-- PAYMENT 
INSERT INTO Payment (order_id, payment_method, amount_received, change_due, payment_status)
VALUES
(1,  'Cash',          200.00, 41.00, 'Paid'),
(2,  'GCash',         423.00,  0.00, 'Paid'),
(3,  'GCash',         229.00,  0.00, 'Paid'),
(4,  'Cash',          500.00, 51.00, 'Paid'),
(5,  'Bank Transfer', 938.00,  0.00, 'Paid'),
(6,  'Cash',          200.00,  1.00, 'Paid'),
(7,  'GCash',         523.00,  0.00, 'Paid'),
(8,  'Cash',          250.00, 21.00, 'Paid'),
(9,  'COD',           350.00, 41.00, 'Paid'),
(10, 'GCash',         199.00,  0.00, 'Paid'),
(11, 'Cash',          100.00, 25.00, 'Paid'),
(12, 'COD',             0.00,  0.00, 'Pending');

-- DELIVERY 
INSERT INTO Delivery (order_id, service_name, contact_number, delivery_type,
courier_type, delivery_address, delivery_status, delivery_fee)
VALUES
(1,  'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Imus, Cavite',           'Delivered',        50.00),
(2,  'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Bacoor, Cavite',         'Delivered',        50.00),
(3,  'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Dasmarinas, Cavite',     'Delivered',        50.00),
(4,  'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Dasmarinas, Cavite',     'Delivered',        50.00),
(5,  'Lalamove',  'N/A', 'Delivery', 'Lalamove',  'General Trias, Cavite',  'Delivered',        80.00),
(6,  'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Imus, Cavite',           'Delivered',        50.00),
(7,  'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Bacoor, Cavite',         'Delivered',        50.00),
(8,  'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Dasmarinas, Cavite',     'Delivered',        50.00),
(9,  'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Imus, Cavite',           'Delivered',        50.00),
(10, 'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Bacoor, Cavite',         'Delivered',        50.00),
(11, 'Own Rider', 'N/A', 'Delivery', 'Own Rider', 'Dasmarinas, Cavite',     'Delivered',        50.00),
(12, 'Lalamove',  'N/A', 'Delivery', 'Lalamove',  'Dasmarinas, Cavite',     'Out for Delivery', 80.00);