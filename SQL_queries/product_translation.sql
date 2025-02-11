INSERT INTO product_category_name_translation (product_category_name)
SELECT DISTINCT p.product_category_name
FROM products AS p
LEFT JOIN product_category_name_translation AS pcnt
    ON p.product_category_name = pcnt.product_category_name
WHERE pcnt.product_category_name IS NULL;


WITH product_cat AS (
	SELECT DISTINCT
	p.product_category_name AS product_category_name,
    pcnt.product_category_name_english AS en_product_category_name
FROM products AS p
LEFT JOIN product_category_name_translation AS pcnt
USING(product_category_name)
)

UPDATE product_category_name_translation
SET product_category_name_english = 
		CASE 
			WHEN product_category_name_english IS NULL AND product_cat.product_category_name = 'pc_gamer'
			THEN 'pc_gamer'
			WHEN product_category_name_english IS NULL AND product_cat.product_category_name = 'portateis_cozinha_e_preparadores_de_alimentos'
			THEN 'portable_kitchen_and_food_preparators'
			ELSE product_category_name_english
		END
FROM product_cat
WHERE product_category_name_translation.product_category_name = product_cat.product_category_name;

SELECT *
FROM product_category_name_translation
