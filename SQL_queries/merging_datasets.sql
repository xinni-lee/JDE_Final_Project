--Merging 2 Datasets

-- Marketing funnel datasets (NaN are leads that did not close a deal)
WITH mf AS (SELECT *
FROM mqleads
LEFT JOIN closed_deals
USING(mql_id)
)

-- Marketing funnel merged with sellers (this way you get seller location)
-- SELECT *
-- FROM mf
-- LEFT JOIN sellers
-- USING(seller_id)
-- WHERE seller_id IS NOT NULL;


-- Marketing funnel merged with items (this way you get products sold by sellers)
SELECT * 
FROM mf
LEFT JOIN order_items
USING(seller_id)
WHERE seller_id IS NOT NULL;
