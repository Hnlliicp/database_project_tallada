--Drop/Delete Tables 

DROP TABLE IF EXISTS Purchase_Order_Items CASCADE;
DROP TABLE IF EXISTS Purchase_Order CASCADE;
DROP TABLE IF EXISTS Supplier CASCADE;

DROP TABLE IF EXISTS Product_Ingredient CASCADE;
DROP TABLE IF EXISTS Inventory CASCADE;

DROP TABLE IF EXISTS Payment CASCADE;

DROP TABLE IF EXISTS Order_Items CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;

DROP TABLE IF EXISTS Delivery CASCADE;

DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;

--Tables Creation

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    complete_address TEXT
);

CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    availability_status VARCHAR(20) DEFAULT 'Available'
);

CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INTEGER,

    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Completed', 'Cancelled')),
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON DELETE CASCADE
);

CREATE TABLE Delivery (
    delivery_id SERIAL PRIMARY KEY,
    order_id INTEGER UNIQUE,

    service_name VARCHAR(50),
    contact_number VARCHAR(20),
    delivery_type VARCHAR(30),

    courier_type VARCHAR(50),
    delivery_address TEXT,
    delivery_status VARCHAR(30) DEFAULT 'Pending' CHECK (delivery_status IN ('Pending', 'Out for Delivery', 'Delivered', 'Cancelled')),
    delivery_fee DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
);

CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,

    order_id INTEGER,
    product_id INTEGER,

    quantity INTEGER CHECK (quantity >= 1),
    subtotal DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE,

    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON DELETE CASCADE
);

CREATE TABLE Payment (
    payment_id SERIAL PRIMARY KEY,

    order_id INTEGER UNIQUE,

    payment_method VARCHAR(50),
    amount_received DECIMAL(10,2),
    change_due DECIMAL(10,2),
    payment_status VARCHAR(30),

    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
);

CREATE TABLE Supplier (
    supplier_id SERIAL PRIMARY KEY,

    supplier_name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20)
);

CREATE TABLE Inventory (
    inventory_id SERIAL PRIMARY KEY,
    supplier_id INTEGER,

    ingredient_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    unit_of_measurement VARCHAR(30),

    stock_quantity DECIMAL(10,2),
    reorder_level DECIMAL(10,2),

    FOREIGN KEY (supplier_id)
        REFERENCES Supplier(supplier_id)
        ON DELETE CASCADE
);

CREATE TABLE Product_Ingredient (
    product_ingredient_id SERIAL PRIMARY KEY,

    product_id INTEGER,
    inventory_id INTEGER,

    quantity_required DECIMAL(10,2),

    FOREIGN KEY (product_id)
        REFERENCES Product(product_id)
        ON DELETE CASCADE,

    FOREIGN KEY (inventory_id)
        REFERENCES Inventory(inventory_id)
        ON DELETE CASCADE
);

CREATE TABLE Purchase_Order (
    purchase_order_id SERIAL PRIMARY KEY,

    supplier_id INTEGER,

    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(30),

    FOREIGN KEY (supplier_id)
        REFERENCES Supplier(supplier_id)
        ON DELETE CASCADE
);

CREATE TABLE Purchase_Order_Items (
    purchase_order_item_id SERIAL PRIMARY KEY,

    purchase_order_id INTEGER,
    inventory_id INTEGER,

    quantity DECIMAL(10,2),
    unit_cost DECIMAL(10,2),
    subtotal DECIMAL(10,2),

    FOREIGN KEY (purchase_order_id)
        REFERENCES Purchase_Order(purchase_order_id)
        ON DELETE CASCADE,

    FOREIGN KEY (inventory_id)
        REFERENCES Inventory(inventory_id)
        ON DELETE CASCADE
);

-- TRIGGER 1: DEDUCT INVENTORY WHEN AN ORDER ITEM IS INSERTED
-- This Fires on INSERT into Order_Items.
-- It then DEDUCTS stock based on quantity_required per ingredient.
 
CREATE OR REPLACE FUNCTION deduct_inventory()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Inventory
    SET stock_quantity = COALESCE(stock_quantity, 0) -
                         (pi.quantity_required * NEW.quantity)
    FROM Product_Ingredient pi
    WHERE Inventory.inventory_id = pi.inventory_id
      AND pi.product_id = NEW.product_id;
 
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_deduct_inventory
AFTER INSERT ON Order_Items
FOR EACH ROW
EXECUTE FUNCTION deduct_inventory();
 
 
-- TRIGGER 2: RESTORE THE INVENTORY WHEN AN ORDER ITEM IS UPDATED
-- Fires on UPDATE into Order_Items.
-- REVERSES the old quantity deduction, then applies the new one.
-- Handles cases like quantity corrections or order edits.
 
CREATE OR REPLACE FUNCTION adjust_inventory_on_order_update()
RETURNS TRIGGER AS $$
BEGIN
    -- Step 1: Reverse the OLD quantity deduction
    UPDATE Inventory
    SET stock_quantity = COALESCE(stock_quantity, 0) +
                         (pi.quantity_required * OLD.quantity)
    FROM Product_Ingredient pi
    WHERE Inventory.inventory_id = pi.inventory_id
      AND pi.product_id = OLD.product_id;
 
    -- Step 2: Apply the NEW quantity deduction
    UPDATE Inventory
    SET stock_quantity = COALESCE(stock_quantity, 0) -
                         (pi.quantity_required * NEW.quantity)
    FROM Product_Ingredient pi
    WHERE Inventory.inventory_id = pi.inventory_id
      AND pi.product_id = NEW.product_id;
 
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_adjust_inventory_on_order_update
AFTER UPDATE ON Order_Items
FOR EACH ROW
EXECUTE FUNCTION adjust_inventory_on_order_update();
 
 
-- TRIGGER 3: RESTORE INVENTORY WHEN AN ORDER ITEM IS DELETED
-- Fires on DELETE from Order_Items.
-- Returns the stock that was consumed by the deleted order item.
-- Handles order cancellations or removed items.
 
CREATE OR REPLACE FUNCTION restore_inventory_on_order_delete()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Inventory
    SET stock_quantity = COALESCE(stock_quantity, 0) +
                         (pi.quantity_required * OLD.quantity)
    FROM Product_Ingredient pi
    WHERE Inventory.inventory_id = pi.inventory_id
      AND pi.product_id = OLD.product_id;
 
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_restore_inventory_on_order_delete
AFTER DELETE ON Order_Items
FOR EACH ROW
EXECUTE FUNCTION restore_inventory_on_order_delete();
 
 
-- TRIGGER 4: RESTOCK INVENTORY WHEN A PURCHASE ORDER ITEM IS INSERTED
-- Fires on INSERT into Purchase_Order_Items.
-- Adds the received quantity directly to Inventory stock.
-- Represents a supplier delivery / restock event.
 
CREATE OR REPLACE FUNCTION restock_inventory_on_purchase()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Inventory
    SET stock_quantity = COALESCE(stock_quantity, 0) + NEW.quantity
    WHERE inventory_id = NEW.inventory_id;
 
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_restock_inventory_on_purchase
AFTER INSERT ON Purchase_Order_Items
FOR EACH ROW
EXECUTE FUNCTION restock_inventory_on_purchase();
 
 
-- TRIGGER 5: ADJUST INVENTORY WHEN A PURCHASE ORDER ITEM IS UPDATED
-- Fires on UPDATE into Purchase_Order_Items.
-- Reverses the old quantity added, then applies the corrected quantity.
-- Handles cases like receiving a different amount than originally recorded.

 
CREATE OR REPLACE FUNCTION adjust_inventory_on_purchase_update()
RETURNS TRIGGER AS $$
BEGIN
    -- Step 1: Reverse the OLD restocked quantity
    UPDATE Inventory
    SET stock_quantity = COALESCE(stock_quantity, 0) - OLD.quantity
    WHERE inventory_id = OLD.inventory_id;
 
    -- Step 2: Apply the NEW restocked quantity
    UPDATE Inventory
    SET stock_quantity = COALESCE(stock_quantity, 0) + NEW.quantity
    WHERE inventory_id = NEW.inventory_id;
 
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_adjust_inventory_on_purchase_update
AFTER UPDATE ON Purchase_Order_Items
FOR EACH ROW
EXECUTE FUNCTION adjust_inventory_on_purchase_update();
 
 

-- TRIGGER 6: UPDATE ORDER TOTAL ON ORDER ITEM INSERT/UPDATE/DELETE
-- Keeps Orders.total_amount always in sync with Order_Items subtotals.

 
CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Orders
    SET total_amount = (
        SELECT COALESCE(SUM(subtotal), 0)
        FROM Order_Items
        WHERE order_id = COALESCE(NEW.order_id, OLD.order_id)
    )
    WHERE order_id = COALESCE(NEW.order_id, OLD.order_id);
 
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;
 
CREATE TRIGGER trg_update_order_total
AFTER INSERT OR UPDATE OR DELETE
ON Order_Items
FOR EACH ROW
EXECUTE FUNCTION update_order_total();