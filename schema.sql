DROP TABLE IF EXISTS Purchase_Order_Items CASCADE;
DROP TABLE IF EXISTS Purchase_Order CASCADE;
DROP TABLE IF EXISTS Supplier CASCADE;

DROP TABLE IF EXISTS Product_Ingredient CASCADE;
DROP TABLE IF EXISTS Inventory CASCADE;

DROP TABLE IF EXISTS Payment CASCADE;

DROP TABLE IF EXISTS Order_Items CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;

DROP TABLE IF EXISTS Delivery_Service CASCADE;

DROP TABLE IF EXISTS Product CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;

CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    complete_address TEXT
);

CREATE TABLE Delivery_Service (
    delivery_service_id SERIAL PRIMARY KEY,

    service_name VARCHAR(50) NOT NULL,
    contact_number VARCHAR(20),
    delivery_type VARCHAR(30)
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
    delivery_service_id INTEGER,

    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(30) DEFAULT 'Pending',
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id)
        REFERENCES Customer(customer_id)
        ON DELETE CASCADE,
    
    FOREIGN KEY (delivery_service_id)
        REFERENCES Delivery_Service(delivery_service_id)
        ON DELETE CASCADE
);

CREATE TABLE Order_Items (
    order_item_id SERIAL PRIMARY KEY,

    order_id INTEGER,
    product_id INTEGER,

    quantity INTEGER NOT NULL,
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

    FOREIGN KEY(supplier_id)
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

CREATE TABLE Delivery (
    delivery_id SERIAL PRIMARY KEY,
    order_id INTEGER UNIQUE,
    courier_type VARCHAR(50),
    delivery_address TEXT,
    delivery_status VARCHAR(30),
    delivery_fee DECIMAL(10,2),
    
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
        ON DELETE CASCADE
);