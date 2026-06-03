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
    status VARCHAR(30) DEFAULT 'Pending' CHECK (STATUS IN ('Pending', 'Completed', 'Cancelled')),
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
    delivery_status VARCHAR(30) CHECK (STATUS IN ('Pending', 'Out for Delivery', 'Delivered', 'Cancelled')),
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

-- INVENTORY DEDUCTION FUNCTION

CREATE OR REPLACE FUNCTION deduct_inventory()
RETURNS TRIGGER AS $$
BEGIN

    UPDATE Inventory
    SET stock_quantity =
        stock_quantity -
        (Product_Ingredient.quantity_required * NEW.quantity)

    FROM Product_Ingredient

    WHERE Inventory.inventory_id = Product_Ingredient.inventory_id
      AND Product_Ingredient.product_id = NEW.product_id;

    RETURN NEW;

END;
$$ LANGUAGE plpgsql;

-- INVENTORY DEDUCTION TRIGGER

CREATE TRIGGER trg_deduct_inventory
AFTER INSERT ON Order_Items
FOR EACH ROW
EXECUTE FUNCTION deduct_inventory();

-- ORDER TOTAL VALUE UPDATE FUNCTION

CREATE OR REPLACE FUNCTION update_order_total()
RETURNS TRIGGER AS $$
BEGIN

    UPDATE Orders 
    SET total_amount =
    (
        SELECT COALESCE(SUM(subtotal), 0)
        FROM Order_Items
        WHERE order_id = COALESCE(NEW.order_id, OLD.order_id)
    )
    WHERE order_id = COALESCE(NEW.order_id, OLD.order_id);

    RETURN NULL;

END;
$$ LANGUAGE plpgsql;

-- ORDER TOTAL VALUE TRIGGER

CREATE TRIGGER trg_update_order_total
AFTER INSERT OR UPDATE OR DELETE 
ON Order_Items
FOR EACH ROW
EXECUTE FUNCTION update_order_total();