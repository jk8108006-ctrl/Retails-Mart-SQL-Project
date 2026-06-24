-- ============================================================
--  RetailSmart Sales Analytics
--  MySQL Interview Project
--  Tables: customers, products, orders, order_items
-- ============================================================

DROP DATABASE IF EXISTS retailsmart;
CREATE DATABASE retailsmart;
USE retailsmart;

-- ============================================================
-- TABLE 1: CUSTOMERS
-- ============================================================
CREATE TABLE customers (
    customer_id  INT           PRIMARY KEY AUTO_INCREMENT,
    full_name    VARCHAR(100)  NOT NULL,
    email        VARCHAR(150)  UNIQUE NOT NULL,
    city         VARCHAR(50)   NOT NULL,
    join_date    DATE          NOT NULL
);

-- ============================================================
-- TABLE 2: PRODUCTS
-- ============================================================
CREATE TABLE products (
    product_id     INT           PRIMARY KEY AUTO_INCREMENT,
    product_name   VARCHAR(150)  NOT NULL,
    category       VARCHAR(50)   NOT NULL,
    price          DECIMAL(10,2) NOT NULL,
    stock_quantity INT           DEFAULT 0
);

-- ============================================================
-- TABLE 3: ORDERS
-- ============================================================
CREATE TABLE orders (
    order_id    INT         PRIMARY KEY AUTO_INCREMENT,
    customer_id INT         NOT NULL,
    order_date  DATE        NOT NULL,
    status      VARCHAR(20) NOT NULL DEFAULT 'Pending',
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- ============================================================
-- TABLE 4: ORDER_ITEMS
-- ============================================================
CREATE TABLE order_items (
    item_id          INT           PRIMARY KEY AUTO_INCREMENT,
    order_id         INT           NOT NULL,
    product_id       INT           NOT NULL,
    quantity         INT           NOT NULL,
    discount_percent DECIMAL(5,2)  DEFAULT 0.00,
    CONSTRAINT fk_item_order
        FOREIGN KEY (order_id)   REFERENCES orders(order_id),
    CONSTRAINT fk_item_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ============================================================
-- DATA: CUSTOMERS (20 rows)
-- ============================================================
INSERT INTO customers (full_name, email, city, join_date) VALUES
('Arjun Sharma',    'arjun.sharma@gmail.com',   'Chandigarh', '2023-01-15'),
('Priya Mehta',     'priya.mehta@gmail.com',    'Mumbai',     '2023-02-20'),
('Rahul Verma',     'rahul.verma@gmail.com',    'Delhi',      '2023-03-10'),
('Sneha Gupta',     'sneha.gupta@gmail.com',    'Bangalore',  '2023-03-25'),
('Vikram Singh',    'vikram.singh@gmail.com',   'Mohali',     '2023-04-05'),
('Ananya Joshi',    'ananya.joshi@gmail.com',   'Pune',       '2023-04-18'),
('Karan Patel',     'karan.patel@gmail.com',    'Ahmedabad',  '2023-05-02'),
('Pooja Nair',      'pooja.nair@gmail.com',     'Chennai',    '2023-05-15'),
('Rohit Yadav',     'rohit.yadav@gmail.com',    'Hyderabad',  '2023-06-01'),
('Deepika Reddy',   'deepika.reddy@gmail.com',  'Bangalore',  '2023-06-20'),
('Amit Kumar',      'amit.kumar@gmail.com',     'Delhi',      '2023-07-08'),
('Neha Sinha',      'neha.sinha@gmail.com',     'Chandigarh', '2023-07-22'),
('Suresh Iyer',     'suresh.iyer@gmail.com',    'Mumbai',     '2023-08-05'),
('Kavita Rao',      'kavita.rao@gmail.com',     'Hyderabad',  '2023-08-19'),
('Manish Tiwari',   'manish.tiwari@gmail.com',  'Mohali',     '2023-09-10'),
('Riya Chawla',     'riya.chawla@gmail.com',    'Chandigarh', '2023-09-28'),
('Ajay Bhatt',      'ajay.bhatt@gmail.com',     'Pune',       '2023-10-15'),
('Sonia Kapoor',    'sonia.kapoor@gmail.com',   'Delhi',      '2023-11-01'),
('Nikhil Desai',    'nikhil.desai@gmail.com',   'Mumbai',     '2023-11-20'),
('Tanya Malhotra',  'tanya.malhotra@gmail.com', 'Mohali',     '2023-12-05');


-- ============================================================
-- DATA: PRODUCTS (15 rows | 5 categories)
-- ============================================================
INSERT INTO products (product_name, category, price, stock_quantity) VALUES
('Wireless Bluetooth Headphones', 'Electronics',   2499.00, 150),
('Laptop Stand Adjustable',       'Electronics',   1299.00, 200),
('USB-C Hub 7-in-1',              'Electronics',   1899.00, 100),
('Mechanical Keyboard',           'Electronics',   3499.00,  80),
('Webcam 1080p HD',               'Electronics',   2199.00, 120),
('Men Cotton Casual Shirt',       'Clothing',       799.00, 300),
('Women Kurta Set',               'Clothing',      1199.00, 250),
('Running Shoes',                 'Clothing',      3999.00,  90),
('Data Science with Python',      'Books',          649.00, 500),
('Clean Code',                    'Books',          549.00, 400),
('SQL Zero to Hero',              'Books',          499.00, 350),
('Non-stick Cookware Set',        'Home & Kitchen',2799.00,  60),
('Air Purifier Mini',             'Home & Kitchen',4999.00,  40),
('Yoga Mat Premium',              'Sports',         899.00, 180),
('Resistance Bands Set',          'Sports',         699.00, 220);


-- ============================================================
-- DATA: ORDERS (45 rows)
-- ============================================================
INSERT INTO orders (customer_id, order_date, status) VALUES
-- Jan 2024
( 1, '2024-01-05', 'Delivered'),
( 2, '2024-01-08', 'Delivered'),
( 3, '2024-01-12', 'Delivered'),
( 4, '2024-01-15', 'Delivered'),
( 5, '2024-01-20', 'Delivered'),
( 6, '2024-01-25', 'Cancelled'),
-- Feb 2024
( 7, '2024-02-02', 'Delivered'),
( 8, '2024-02-05', 'Delivered'),
( 9, '2024-02-10', 'Delivered'),
(10, '2024-02-15', 'Returned'),
( 1, '2024-02-20', 'Delivered'),
(11, '2024-02-25', 'Delivered'),
-- Mar 2024
(12, '2024-03-01', 'Delivered'),
(13, '2024-03-05', 'Pending'),
(14, '2024-03-10', 'Delivered'),
( 3, '2024-03-15', 'Delivered'),
(15, '2024-03-20', 'Delivered'),
(16, '2024-03-25', 'Delivered'),
-- Apr 2024
( 2, '2024-04-01', 'Delivered'),
( 5, '2024-04-05', 'Cancelled'),
(17, '2024-04-10', 'Delivered'),
(18, '2024-04-15', 'Delivered'),
( 7, '2024-04-20', 'Delivered'),
( 9, '2024-04-25', 'Delivered'),
-- May 2024
(19, '2024-05-01', 'Delivered'),
(20, '2024-05-05', 'Delivered'),
( 4, '2024-05-10', 'Delivered'),
( 8, '2024-05-15', 'Returned'),
(12, '2024-05-20', 'Delivered'),
( 1, '2024-05-25', 'Delivered'),
-- Jun 2024
( 6, '2024-06-01', 'Delivered'),
(11, '2024-06-05', 'Delivered'),
(14, '2024-06-10', 'Delivered'),
(16, '2024-06-15', 'Delivered'),
( 3, '2024-06-20', 'Pending'),
-- Jul 2024
( 2, '2024-07-02', 'Delivered'),
(10, '2024-07-08', 'Delivered'),
(13, '2024-07-15', 'Delivered'),
(17, '2024-07-20', 'Delivered'),
( 5, '2024-07-25', 'Delivered'),
-- Aug 2024
(20, '2024-08-01', 'Delivered'),
(18, '2024-08-10', 'Delivered'),
( 1, '2024-08-15', 'Delivered'),
(15, '2024-08-20', 'Delivered'),
( 9, '2024-08-28', 'Delivered');


-- ============================================================
-- DATA: ORDER_ITEMS (95 rows)
-- ============================================================
INSERT INTO order_items (order_id, product_id, quantity, discount_percent) VALUES
-- Order 1  (Arjun - Jan)
(1,  1, 1,  5.00), (1,  9, 2,  0.00),
-- Order 2  (Priya - Jan)
(2,  6, 2, 10.00), (2, 14, 1,  0.00),
-- Order 3  (Rahul - Jan)
(3,  3, 1,  0.00), (3, 10, 1,  5.00),
-- Order 4  (Sneha - Jan)
(4, 12, 1, 15.00), (4, 11, 2,  0.00),
-- Order 5  (Vikram - Jan)
(5,  4, 1,  0.00), (5,  2, 1, 10.00),
-- Order 6  (Ananya - Jan CANCELLED)
(6,  7, 1, 20.00),
-- Order 7  (Karan - Feb)
(7,  5, 1,  0.00), (7, 15, 2,  5.00),
-- Order 8  (Pooja - Feb)
(8,  8, 1,  0.00), (8,  9, 1,  0.00),
-- Order 9  (Rohit - Feb)
(9, 13, 1,  0.00), (9,  6, 3, 10.00),
-- Order 10 (Deepika - Feb RETURNED)
(10, 4, 1,  0.00),
-- Order 11 (Arjun - Feb)
(11, 2, 1,  5.00), (11,10, 2,  0.00),
-- Order 12 (Amit - Feb)
(12, 1, 2, 10.00), (12,14, 1,  0.00),
-- Order 13 (Neha - Mar PENDING)
(13,11, 3,  0.00),
-- Order 14 (Suresh - Mar)
(14, 5, 1,  0.00), (14, 7, 2,  5.00),
-- Order 15 (Kavita - Mar)
(15, 3, 1, 15.00), (15, 6, 1,  0.00),
-- Order 16 (Rahul - Mar)
(16,12, 1,  0.00), (16, 9, 2, 10.00),
-- Order 17 (Manish - Mar)
(17, 8, 1,  0.00), (17,15, 1,  5.00),
-- Order 18 (Riya - Mar)
(18, 4, 1, 20.00), (18, 2, 1,  0.00),
-- Order 19 (Priya - Apr)
(19, 1, 1,  0.00), (19,13, 1,  0.00),
-- Order 20 (Vikram - Apr CANCELLED)
(20, 6, 2, 10.00),
-- Order 21 (Ajay - Apr)
(21,10, 2,  0.00), (21,11, 1,  5.00),
-- Order 22 (Sonia - Apr)
(22, 5, 1,  0.00), (22,14, 2,  0.00),
-- Order 23 (Karan - Apr)
(23, 3, 2,  5.00), (23, 9, 1,  0.00),
-- Order 24 (Rohit - Apr)
(24, 7, 1,  0.00), (24,15, 3, 10.00),
-- Order 25 (Nikhil - May)
(25,12, 1,  0.00), (25, 4, 1, 15.00),
-- Order 26 (Tanya - May)
(26,13, 1,  0.00), (26, 6, 1,  0.00),
-- Order 27 (Sneha - May)
(27, 1, 1,  5.00), (27, 2, 1,  0.00),
-- Order 28 (Pooja - May RETURNED)
(28, 8, 1,  0.00),
-- Order 29 (Neha - May)
(29,10, 2,  5.00), (29,11, 1,  0.00),
-- Order 30 (Arjun - May)
(30, 5, 1,  0.00), (30,14, 1, 10.00),
-- Order 31 (Ananya - Jun)
(31, 3, 1,  0.00), (31, 7, 2,  5.00),
-- Order 32 (Amit - Jun)
(32, 4, 1,  0.00), (32, 9, 3,  0.00),
-- Order 33 (Suresh - Jun)
(33,12, 1, 10.00), (33,15, 2,  0.00),
-- Order 34 (Riya - Jun)
(34, 1, 2,  0.00), (34, 6, 1,  5.00),
-- Order 35 (Rahul - Jun PENDING)
(35,13, 1,  0.00),
-- Order 36 (Priya - Jul)
(36, 2, 1, 10.00), (36,10, 2,  5.00),
-- Order 37 (Deepika - Jul)
(37, 5, 1,  0.00), (37,11, 1,  0.00),
-- Order 38 (Neha - Jul)
(38, 7, 1, 15.00), (38,14, 2,  0.00),
-- Order 39 (Ajay - Jul)
(39, 4, 1,  0.00), (39, 3, 1, 10.00),
-- Order 40 (Vikram - Jul)
(40, 8, 1,  0.00), (40,15, 1,  5.00),
-- Order 41 (Tanya - Aug)
(41,12, 1,  0.00), (41, 9, 2,  0.00),
-- Order 42 (Sonia - Aug)
(42, 1, 1,  5.00), (42, 6, 2, 10.00),
-- Order 43 (Arjun - Aug)
(43,13, 1,  0.00), (43, 2, 1,  0.00),
-- Order 44 (Manish - Aug)
(44, 4, 1, 10.00), (44,11, 3,  5.00),
-- Order 45 (Rohit - Aug)
(45, 5, 1,  0.00), (45,14, 1,  0.00);