--Adding constraints for ERDiagram
DROP TABLE IF EXISTS geolocation_new;
CREATE TABLE geolocation_new
 (geolocation_zip_code_prefix VARCHAR(5) PRIMARY KEY,
 geolocation_lat NUMERIC,
 geolocation_lng NUMERIC,
 geolocation_city VARCHAR,
 geolocation_state VARCHAR(2)
 );

-- Copy table from geolocation but keep unique zipcode value as PK
DROP TABLE IF EXISTS geolocation_new;
CREATE TABLE geolocation_new AS
WITH unique_city_state AS (
    SELECT DISTINCT ON (geolocation_zip_code_prefix) 
        geolocation_zip_code_prefix, 
        geolocation_city, 
        geolocation_state
    FROM geolocation
    ORDER BY geolocation_zip_code_prefix, geolocation_city
)
SELECT 
    g.geolocation_zip_code_prefix AS geolocation_zip_code_prefix,  
    AVG(g.geolocation_lat) AS geolocation_lat,  
    AVG(g.geolocation_lng) AS geolocation_lng,  
    u.geolocation_city,  
    u.geolocation_state  
FROM geolocation g
JOIN unique_city_state u 
ON g.geolocation_zip_code_prefix = u.geolocation_zip_code_prefix
GROUP BY g.geolocation_zip_code_prefix, u.geolocation_city, u.geolocation_state;

-- Insert null values
INSERT INTO geolocation_new (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state)
SELECT DISTINCT seller_zip_code_prefix, 0, 0, 'U0', 'U0' 
FROM sellers 
WHERE seller_zip_code_prefix NOT IN (SELECT geolocation_zip_code_prefix FROM geolocation_new);

SELECT DISTINCT COUNT (geolocation_zip_code_prefix)
FROM geolocation_new

ALTER TABLE geolocation_new ADD CONSTRAINT unique_zip UNIQUE (geolocation_zip_code_prefix);

ALTER TABLE sellers
ADD CONSTRAINT fk_seller_zip
FOREIGN KEY (seller_zip_code_prefix)
REFERENCES geolocation_new(geolocation_zip_code_prefix)
MATCH SIMPLE;

ALTER TABLE sellers ALTER COLUMN seller_zip_code_prefix DROP NOT NULL;

-- Insert null values
INSERT INTO geolocation_new (geolocation_zip_code_prefix, geolocation_lat, geolocation_lng, geolocation_city, geolocation_state)
SELECT DISTINCT customer_zip_code_prefix, 0, 0, 'U0', 'U0' 
FROM customers 
WHERE customer_zip_code_prefix NOT IN (SELECT geolocation_zip_code_prefix FROM geolocation_new);

ALTER TABLE customers
ADD CONSTRAINT fk_customers_zip
FOREIGN KEY (customer_zip_code_prefix)
REFERENCES geolocation_new(geolocation_zip_code_prefix)
MATCH SIMPLE;

ALTER TABLE customers ALTER COLUMN customer_zip_code_prefix DROP NOT NULL;


--2nd dataset
ALTER TABLE mqleads ADD CONSTRAINT unique_mql UNIQUE (mql_id);

ALTER TABLE closed_deals ADD CONSTRAINT sellers_sellerid
 	FOREIGN KEY (seller_id) REFERENCES sellers(seller_id);
ALTER TABLE closed_deals ADD CONSTRAINT mql_mqlid
 	FOREIGN KEY (mql_id) REFERENCES mqleads(mql_id);
