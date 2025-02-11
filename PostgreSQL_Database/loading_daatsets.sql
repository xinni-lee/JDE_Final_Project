-- Create a database in pgadmin first then open the query
-- Load csv files into C drive (for Windows)
-- Run part by part in 3 steps for each table
-- (1. Create table, 2. Copy records in csv files into new table, 3. Check table is created by looking at number of records and field names/types)

--0 olist_order_items_dataset.csv
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items
 (order_id UUID NOT NULL,
 order_item_id INTEGER NOT NULL,
 product_id UUID,
 seller_id UUID,
 shipping_limit_date TIMESTAMP,
 price NUMERIC(10, 2),
 freight_value NUMERIC(10, 2)
 );

COPY order_items
FROM 'C:\\olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*)
FROM order_items
LIMIT 10;

--1 olist_order_reviews_dataset.csv
DROP TABLE IF EXISTS order_reviews;
CREATE TABLE order_reviews
 (review_id UUID NOT NULL,
 order_id UUID,
 review_score INTEGER,
 review_comment_title VARCHAR,
 review_comment_message VARCHAR,
 review_creation_date TIMESTAMP,
 review_answer_timestamp TIMESTAMP,
 CHECK (review_score >= 1 AND review_score <= 5)
 );

COPY order_reviews
FROM 'C:\\olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT *
FROM order_reviews
LIMIT 10;


--2 olist_orders_dataset.csv
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
 (order_id UUID PRIMARY KEY,
 customer_id UUID,
 order_status VARCHAR(12),
 order_purchase_timestamp TIMESTAMP,
 order_approved_at TIMESTAMP,
 order_delivered_carrier_date TIMESTAMP,
 order_delivered_customer_date TIMESTAMP,
 order_estimated_delivery_date TIMESTAMP,
 UNIQUE(order_id)
 );

COPY orders
FROM 'C:\\olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT *
FROM orders
LIMIT 10;


--3 olist_products_dataset.csv
DROP TABLE IF EXISTS products;
CREATE TABLE products
 (product_id UUID PRIMARY KEY,
 product_category_name VARCHAR,
 product_name_length INTEGER,
 product_description_length INTEGER,
 product_photos_qty INTEGER,
 product_weight_g INTEGER,
 product_length_cm INTEGER,
 product_height_cm INTEGER,
 product_width_cm INTEGER,
 UNIQUE(product_id)
 );

COPY products
FROM 'C:\\olist_products_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT *
FROM products
LIMIT 10;


-- 4 olist_geolocation_dataset.csv
DROP TABLE IF EXISTS geolocation;
CREATE TABLE geolocation
 (geolocation_zip_code_prefix VARCHAR(5),
 geolocation_lat NUMERIC,
 geolocation_lng NUMERIC,
 geolocation_city VARCHAR,
 geolocation_state VARCHAR(2)
 );

COPY geolocation
FROM 'C:\\olist_geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*)
FROM geolocation
LIMIT 10;


-- 5 olist_sellers_dataset.csv
DROP TABLE IF EXISTS sellers;
CREATE TABLE sellers
 (seller_id UUID PRIMARY KEY,
 seller_zip_code_prefix VARCHAR(5),
 seller_city VARCHAR,
 seller_state VARCHAR(2)
 );

COPY sellers
FROM 'C:\\olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT *
FROM sellers
LIMIT 10;


-- 6 olist_order_payments_dataset.csv
DROP TABLE IF EXISTS order_payments;
CREATE TABLE order_payments
 (order_id UUID,
 payment_sequential INTEGER,
 payment_type VARCHAR,
 payment_installments INTEGER,
 payment_value NUMERIC(10,2)
 );

COPY order_payments
FROM 'C:\\olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*)
FROM order_payments
LIMIT 10;


--7 olist_customers_dataset.csv
DROP TABLE IF EXISTS customers;
CREATE TABLE customers
 (customer_id UUID PRIMARY KEY,
 customer_unique_id UUID,
 customer_zip_code_prefix VARCHAR(5),
 customer_city VARCHAR(32),
 customer_state VARCHAR(2)
 );

COPY customers
FROM 'C:\\olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*)
FROM customers
LIMIT 10;


-- 8 product_category_name_translation.csv
DROP TABLE IF EXISTS product_category_name_translation;
CREATE TABLE product_category_name_translation
 (product_category_name VARCHAR,
 product_category_name_english VARCHAR
 );

COPY product_category_name_translation
FROM 'C:\\product_category_name_translation.csv'
DELIMITER ','
CSV HEADER;

SELECT *
FROM product_category_name_translation
LIMIT 10;


 --Setting Foreign keys
ALTER TABLE order_items ADD CONSTRAINT orders_orderid
 	FOREIGN KEY (order_id) REFERENCES orders(order_id);
ALTER TABLE order_reviews ADD CONSTRAINT orders_orderid
 	FOREIGN KEY (order_id) REFERENCES orders(order_id);
ALTER TABLE order_payments ADD CONSTRAINT orders_orderid
 	FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE order_items ADD CONSTRAINT products_productid
 	FOREIGN KEY (product_id) REFERENCES products(product_id);

ALTER TABLE order_items ADD CONSTRAINT sellers_sellerid
 	FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);

ALTER TABLE orders ADD CONSTRAINT customers_customerid
 	FOREIGN KEY (customer_id) REFERENCES customers(customer_id);


-- ### Marketing Funnel by Olist ###
-- # 0 - olist_closed_deals_dataset.csv
-- # 1 - olist_marketing_qualified_leads_dataset.csv

--0 olist_closed_deals_dataset.csv
DROP TABLE IF EXISTS closed_deals;
CREATE TABLE closed_deals
 (mql_id UUID NOT NULL,
 seller_id UUID,
 sdr_id UUID,
 sr_id UUID,
 won_date TIMESTAMP,
 business_segment VARCHAR,
 lead_type VARCHAR,
 lead_behaviour_profile VARCHAR,
 has_company BOOLEAN,
 has_gtin BOOLEAN,
 average_stock VARCHAR,
 business_type VARCHAR,
 declared_product_catalog_size NUMERIC,
 declared_monthly_revenue NUMERIC
 );

COPY closed_deals
FROM 'C:\\olist_closed_deals_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT *
FROM closed_deals
LIMIT 10;


--1 olist_marketing_qualified_leads_dataset.csv
DROP TABLE IF EXISTS mqleads;
CREATE TABLE mqleads
 (mql_id UUID NOT NULL,
 first_contact_date TIMESTAMP,
 landing_page_id UUID,
 origin VARCHAR
 );

COPY mqleads
FROM 'C:\\olist_marketing_qualified_leads_dataset.csv'
DELIMITER ','
CSV HEADER;

SELECT COUNT(*)
FROM mqleads
LIMIT 10;
