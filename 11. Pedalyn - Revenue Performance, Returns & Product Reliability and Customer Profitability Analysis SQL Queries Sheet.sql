CREATE SCHEMA pedalyn;
# ______________________________________________________________________________________________________________________________________
USE pedalyn;
# ______________________________________________________________________________________________________________________________________
DESCRIBE calendar;
SELECT * FROM calendar;
# -------------------------------------------------------------------------------------------------------------------------------------
DESCRIBE customers;
SELECT * FROM customers;
# -------------------------------------------------------------------------------------------------------------------------------------
DESCRIBE product_categories;
SELECT * FROM product_categories;
# -------------------------------------------------------------------------------------------------------------------------------------
DESCRIBE product_subcategories;
SELECT * FROM product_subcategories;
# -------------------------------------------------------------------------------------------------------------------------------------
DESCRIBE products;
SELECT * FROM products;
# -------------------------------------------------------------------------------------------------------------------------------------
DESCRIBE `returns`;
SELECT * FROM `returns`;
# -------------------------------------------------------------------------------------------------------------------------------------
DESCRIBE sales_2015;
SELECT * FROM sales_2015;
# -------------------------------------------------------------------------------------------------------------------------------------
DESCRIBE sales_2016;
SELECT * FROM sales_2016;
# -------------------------------------------------------------------------------------------------------------------------------------
DESCRIBE sales_2017;
SELECT * FROM sales_2017;
# ______________________________________________________________________________________________________________________________________
DESCRIBE territories;
SELECT * FROM territories;
# ______________________________________________________________________________________________________________________________________
-- rename columns & change data type
-- calender
ALTER TABLE calendar CHANGE `ï»¿Year` Year INT;
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE calendar ADD COLUMN Date_new DATE;
UPDATE calendar SET Date_new = STR_TO_DATE(Date, '%d-%m-%Y');
ALTER TABLE calendar DROP COLUMN Date;
ALTER TABLE calendar CHANGE Date_new Date DATE;
-- -------------------------------------------------------------------------------------------------------------------------------------
#customers
ALTER TABLE customers CHANGE `ï»¿CustomerKey` CustomerKey INT;
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE customers ADD COLUMN FullName TEXT;
UPDATE customers SET FullName = CONCAT(FirstName, ' ', LastName);
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE customers ADD COLUMN BirthDate_new DATE;
UPDATE customers SET BirthDate_new = STR_TO_DATE(BirthDate, '%d-%m-%Y');
ALTER TABLE customers DROP COLUMN BirthDate;
ALTER TABLE customers CHANGE BirthDate_new BirthDate DATE;
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE customers DROP COLUMN MyUnknownColumn;
-- -------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT AnnualIncome FROM customers;
UPDATE customers SET AnnualIncome = TRIM(REPLACE(REPLACE(AnnualIncome, '$', ''), ',', ''));
UPDATE customers SET AnnualIncome = NULL WHERE AnnualIncome = '' OR AnnualIncome = 'Unknown';
ALTER TABLE customers MODIFY COLUMN AnnualIncome INT;
-- -------------------------------------------------------------------------------------------------------------------------------------
UPDATE customers SET MaritalStatus = 
    CASE 
        WHEN MaritalStatus = 'M' THEN 'Married'
        WHEN MaritalStatus = 'S' THEN 'Single'
        ELSE MaritalStatus
    END;
-- -------------------------------------------------------------------------------------------------------------------------------------
UPDATE customers SET Gender = 
    CASE 
        WHEN Gender = 'M' THEN 'Male'
        WHEN Gender = 'F' THEN 'Female'
        ELSE 'Other'
    END;
-- -------------------------------------------------------------------------------------------------------------------------------------
UPDATE customers SET HomeOwner = 
    CASE 
        WHEN HomeOwner = 'Y' THEN 'Yes'
        WHEN HomeOwner = 'N' THEN 'No'
        ELSE NULL
    END;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- product_categories
ALTER TABLE product_categories CHANGE ï»¿ProductCategoryKey ProductCategoryKey INT;
-- -------------------------------------------------------------------------------------------------------------------------------------
#product_subcategories
ALTER TABLE product_subcategories CHANGE ï»¿ProductSubcategoryKey ProductSubcategoryKey INT;
-- -------------------------------------------------------------------------------------------------------------------------------------
#products
ALTER TABLE products CHANGE `ï»¿ProductKey` ProductKey INT;
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE products MODIFY ProductCost DECIMAL(10,2), MODIFY ProductPrice DECIMAL(10,2);
-- -------------------------------------------------------------------------------------------------------------------------------------
#returns
ALTER TABLE `returns` CHANGE `ï»¿ReturnDate` ReturnDate TEXT;
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE `returns` ADD COLUMN ReturnDate_new DATE;
UPDATE `returns` SET ReturnDate_new = 
    CASE
        WHEN ReturnDate LIKE '%/%/%' 
            THEN STR_TO_DATE(ReturnDate, '%m/%d/%Y')
        WHEN ReturnDate LIKE '%-%-%' 
            THEN STR_TO_DATE(ReturnDate, '%d-%m-%Y')
        ELSE NULL
    END;
ALTER TABLE `returns` DROP COLUMN ReturnDate;
ALTER TABLE `returns` CHANGE ReturnDate_new ReturnDate DATE;
-- -------------------------------------------------------------------------------------------------------------------------------------
#sales_2015
ALTER TABLE sales_2015 CHANGE `ï»¿OrderDate` OrderDate TEXT;
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE sales_2015 ADD COLUMN OrderDate_new DATE;
ALTER TABLE sales_2015 ADD COLUMN StockDate_new DATE;
UPDATE sales_2015 SET OrderDate_new = 
        CASE
            WHEN OrderDate LIKE '%/%/%' 
                THEN STR_TO_DATE(OrderDate, '%m/%d/%Y')
            WHEN OrderDate LIKE '%-%-%' 
                THEN STR_TO_DATE(OrderDate, '%d-%m-%Y')
            ELSE NULL
        END,
						StockDate_new = 
        CASE
            WHEN StockDate LIKE '%/%/%' 
                THEN STR_TO_DATE(StockDate, '%m/%d/%Y')
            WHEN StockDate LIKE '%-%-%' 
                THEN STR_TO_DATE(StockDate, '%d-%m-%Y')
            ELSE NULL
        END;

ALTER TABLE sales_2015 DROP COLUMN OrderDate, DROP COLUMN StockDate;

ALTER TABLE sales_2015 CHANGE OrderDate_new OrderDate DATE, CHANGE StockDate_new StockDate DATE;
-- -------------------------------------------------------------------------------------------------------------------------------------
#sales_2016
ALTER TABLE sales_2016 CHANGE `ï»¿OrderDate` OrderDate TEXT;
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE sales_2016 ADD COLUMN OrderDate_new DATE;
ALTER TABLE sales_2016 ADD COLUMN StockDate_new DATE;

UPDATE sales_2016 SET OrderDate_new = 
        CASE
            WHEN OrderDate LIKE '%/%/%' 
                THEN STR_TO_DATE(OrderDate, '%m/%d/%Y')
            WHEN OrderDate LIKE '%-%-%' 
                THEN STR_TO_DATE(OrderDate, '%d-%m-%Y')
            ELSE NULL
        END,
						StockDate_new = 
        CASE
            WHEN StockDate LIKE '%/%/%' 
                THEN STR_TO_DATE(StockDate, '%m/%d/%Y')
            WHEN StockDate LIKE '%-%-%' 
                THEN STR_TO_DATE(StockDate, '%d-%m-%Y')
            ELSE NULL
        END;


ALTER TABLE sales_2016 DROP COLUMN OrderDate, DROP COLUMN StockDate;

ALTER TABLE sales_2016 CHANGE OrderDate_new OrderDate DATE, CHANGE StockDate_new StockDate DATE;
-- -------------------------------------------------------------------------------------------------------------------------------------
#sales_2017
ALTER TABLE sales_2017 CHANGE `ï»¿OrderDate` OrderDate TEXT;
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE sales_2017 ADD COLUMN OrderDate_new DATE;
ALTER TABLE sales_2017 ADD COLUMN StockDate_new DATE;

UPDATE sales_2017 SET OrderDate_new = 
        CASE
            WHEN OrderDate LIKE '%/%/%' 
                THEN STR_TO_DATE(OrderDate, '%m/%d/%Y')
            WHEN OrderDate LIKE '%-%-%' 
                THEN STR_TO_DATE(OrderDate, '%d-%m-%Y')
            ELSE NULL
        END,
						StockDate_new = 
        CASE
            WHEN StockDate LIKE '%/%/%' 
                THEN STR_TO_DATE(StockDate, '%m/%d/%Y')
            WHEN StockDate LIKE '%-%-%' 
                THEN STR_TO_DATE(StockDate, '%d-%m-%Y')
            ELSE NULL
        END;

ALTER TABLE sales_2017 DROP COLUMN OrderDate, DROP COLUMN StockDate;

ALTER TABLE sales_2017 CHANGE OrderDate_new OrderDate DATE, CHANGE StockDate_new StockDate DATE;
-- -------------------------------------------------------------------------------------------------------------------------------------
#territories
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE territories CHANGE `ï»¿SalesTerritoryKey` SalesTerritoryKey INT;
# ______________________________________________________________________________________________________________________________________
CREATE TABLE sales_combined AS
	SELECT * FROM sales_2015
		UNION ALL
	SELECT * FROM sales_2016
		UNION ALL
	SELECT * FROM sales_2017;
# ______________________________________________________________________________________________________________________________________
ALTER TABLE customers ADD PRIMARY KEY (CustomerKey);
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE products ADD PRIMARY KEY (ProductKey);
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE product_categories ADD PRIMARY KEY (ProductCategoryKey);
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE product_subcategories ADD PRIMARY KEY (ProductSubcategoryKey);
-- -------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE territories ADD PRIMARY KEY (SalesTerritoryKey);
-- -------------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT CustomerKey FROM sales_combined WHERE CustomerKey NOT IN (SELECT CustomerKey FROM customers);
SELECT DISTINCT ProductKey FROM sales_combined WHERE ProductKey NOT IN (SELECT ProductKey FROM products);
SELECT DISTINCT TerritoryKey FROM sales_combined WHERE TerritoryKey NOT IN (SELECT SalesTerritoryKey FROM territories);

DELETE FROM sales_combined
			WHERE CustomerKey NOT IN (SELECT CustomerKey FROM customers)
			OR ProductKey NOT IN (SELECT ProductKey FROM products)
			OR TerritoryKey NOT IN (SELECT SalesTerritoryKey FROM territories);

ALTER TABLE sales_combined
			ADD CONSTRAINT fk_sales_product FOREIGN KEY (ProductKey) REFERENCES products(ProductKey),
			ADD CONSTRAINT fk_sales_customer FOREIGN KEY (CustomerKey) REFERENCES customers(CustomerKey),
			ADD CONSTRAINT fk_sales_territory FOREIGN KEY (TerritoryKey) REFERENCES territories(SalesTerritoryKey);
# ______________________________________________________________________________________________________________________________________

-- # A. Revenue & Sales Performance
-- 1. Which product categories generate the highest revenue?
	SELECT 
    pc.CategoryName,
    ROUND(SUM(sc.OrderQuantity * p.ProductPrice), 2) AS total_revenue
	FROM sales_combined sc
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	JOIN product_subcategories ps 
		ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
	JOIN product_categories pc 
		ON ps.ProductCategoryKey = pc.ProductCategoryKey
	GROUP BY pc.CategoryName
	ORDER BY total_revenue DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 2. Which products contribute the most to total revenue?
	SELECT 
		p.ProductName,
		SUM(r.ReturnQuantity) AS total_returns,
		SUM(sc.OrderQuantity) AS total_sales,
		ROUND(SUM(r.ReturnQuantity) / NULLIF(SUM(sc.OrderQuantity),0), 4) AS return_rate
	FROM sales_combined sc
	LEFT JOIN returns r 
		ON sc.ProductKey = r.ProductKey
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY p.ProductName;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 3. Which months show the highest sales growth?
	SELECT 
		`year_month`,
		revenue,
		prev_revenue,
		ROUND((revenue - prev_revenue) * 100.0 / prev_revenue,2) AS growth_percentage
	FROM (SELECT 
			DATE_FORMAT(OrderDate, '%Y-%m') AS `year_month`,
			ROUND(SUM(sc.OrderQuantity * p.ProductPrice), 2) AS revenue,
			LAG(ROUND(SUM(sc.OrderQuantity * p.ProductPrice), 2)) OVER (ORDER BY DATE_FORMAT(OrderDate, '%Y-%m')) AS prev_revenue
		FROM sales_combined sc
		JOIN products p 
			ON sc.ProductKey = p.ProductKey
		GROUP BY `year_month`
	) AS sub
	ORDER BY growth_percentage DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 4. Are sales increasing or declining over time?
	SELECT order_month,
		   sales,
		   CASE 
			   WHEN sales > LAG(sales) OVER (ORDER BY order_month) THEN 'Increasing'
			   WHEN sales < LAG(sales) OVER (ORDER BY order_month) THEN 'Decreasing'
			   ELSE 'Stable'
		   END AS trend
	FROM (SELECT DATE_FORMAT(OrderDate, '%Y-%m') AS order_month,
			   SUM(OrderQuantity) AS sales
			FROM sales_combined
			GROUP BY order_month
		) t;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- # B. Product Performance & Profitability
-- 5. Which products are the most profitable?
	SELECT p.ProductName,
		   SUM(sc.OrderQuantity * (p.ProductPrice - p.ProductCost)) AS profit
	FROM sales_combined sc
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY p.ProductName
	ORDER BY profit DESC
	LIMIT 10;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 6. Which product models generate the highest profit margins?
	SELECT p.ModelName,
		   AVG((p.ProductPrice - p.ProductCost) / p.ProductPrice) AS profit_margin
	FROM products p
	GROUP BY p.ModelName
	ORDER BY profit_margin DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 7. Which products are priced above their category average?
	SELECT p.ProductName, p.ProductPrice
	FROM products p
	JOIN product_subcategories ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
	WHERE p.ProductPrice > (SELECT AVG(p2.ProductPrice)
							FROM products p2
							WHERE p2.ProductSubcategoryKey = p.ProductSubcategoryKey);
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 8. Which products perform consistently across years?
	SELECT p.ProductName,
		   YEAR(sc.OrderDate) AS year,
		   SUM(sc.OrderQuantity) AS total_sales
	FROM sales_combined sc
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY p.ProductName, year
	ORDER BY p.ProductName, year;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- # C. Returns & Risk Analysis
-- 9. Which products have the highest return quantities?
	SELECT p.ProductName,
		   SUM(r.ReturnQuantity) AS total_returns
	FROM returns r
	JOIN products p ON r.ProductKey = p.ProductKey
	GROUP BY p.ProductName
	ORDER BY total_returns DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 10. Which product categories and subcategories have the highest returns?
	SELECT pc.CategoryName, ps.SubcategoryName,
		   SUM(r.ReturnQuantity) AS total_returns
	FROM returns r
	JOIN products p ON r.ProductKey = p.ProductKey
	JOIN product_subcategories ps ON p.ProductSubcategoryKey = ps.ProductSubcategoryKey
	JOIN product_categories pc ON ps.ProductCategoryKey = pc.ProductCategoryKey
	GROUP BY pc.CategoryName, ps.SubcategoryName
	ORDER BY total_returns DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 11. Which regions or countries have the highest return rates?
	SELECT t.Country,
		   SUM(r.ReturnQuantity) / SUM(sc.OrderQuantity) AS return_rate
	FROM sales_combined sc
	JOIN returns r ON sc.ProductKey = r.ProductKey
	JOIN territories t ON sc.TerritoryKey = t.SalesTerritoryKey
	GROUP BY t.Country
	ORDER BY return_rate DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 12. Which products have above-average return rates?
	SELECT p.ProductName,
		   SUM(r.ReturnQuantity)/SUM(sc.OrderQuantity) AS return_rate
	FROM sales_combined sc
	JOIN returns r 
		ON sc.ProductKey = r.ProductKey
	JOIN products p 
		ON p.ProductKey = sc.ProductKey
	GROUP BY p.ProductName
	HAVING return_rate > (
		SELECT AVG(return_rate) FROM (
			SELECT SUM(r.ReturnQuantity)/SUM(sc.OrderQuantity) AS return_rate
			FROM sales_combined sc
			JOIN returns r 
				ON sc.ProductKey = r.ProductKey
			GROUP BY sc.ProductKey
		) t
	);
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 13. Are cheaper products returned more frequently than expensive ones?
	SELECT 
		CASE 
			WHEN p.ProductPrice < 500 THEN 'Cheap'
			ELSE 'Expensive'
		END AS price_category,
		SUM(r.ReturnQuantity) AS total_returns
	FROM returns r
	JOIN products p 
		ON r.ProductKey = p.ProductKey
	GROUP BY price_category;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 14. Which products are never returned?
	SELECT p.ProductName
	FROM products p
	LEFT JOIN returns r 
		ON p.ProductKey = r.ProductKey
	WHERE r.ProductKey IS NULL;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- # D. Customer Behavior & Segmentation
-- 15. Who are the most valuable customers (by revenue or volume)?
	SELECT c.FullName,
		   SUM(sc.OrderQuantity * p.ProductPrice) AS revenue
	FROM sales_combined sc
	JOIN customers c 
		ON sc.CustomerKey = c.CustomerKey
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY c.FullName
	ORDER BY revenue DESC
	LIMIT 10;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 16. Are high-spending customers also frequent buyers?
	SELECT c.CustomerKey,
		   COUNT(sc.OrderNumber) AS orders,
		   SUM(sc.OrderQuantity * p.ProductPrice) AS revenue
	FROM sales_combined sc
	JOIN customers c 
		ON sc.CustomerKey = c.CustomerKey
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY c.CustomerKey;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 17. Which customers are repeat buyers?
	SELECT CustomerKey,
		   COUNT(DISTINCT OrderNumber) AS orders
	FROM sales_combined
	GROUP BY CustomerKey
	HAVING orders > 1;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 18. Which customers frequently return products?
	SELECT c.FullName,
		   SUM(r.ReturnQuantity) AS total_returns
	FROM returns r
	JOIN sales_combined sc 
		ON r.ProductKey = sc.ProductKey
	JOIN customers c 
		ON sc.CustomerKey = c.CustomerKey
	GROUP BY c.FullName
	ORDER BY total_returns DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 19. How does purchasing behavior vary by gender?
	SELECT 
		c.Gender,
		COUNT(DISTINCT sc.CustomerKey) AS total_customers,
		SUM(sc.OrderQuantity) AS total_orders,
		ROUND(SUM(sc.OrderQuantity * p.ProductPrice), 2) AS total_revenue
	FROM sales_combined sc
	JOIN customers c 
		ON sc.CustomerKey = c.CustomerKey
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY c.Gender
	ORDER BY total_revenue DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 20. How does purchasing vary across income groups?
	SELECT 
		CASE 
			WHEN c.AnnualIncome < 50000 THEN 'Low Income'
			WHEN c.AnnualIncome BETWEEN 50000 AND 100000 THEN 'Middle Income'
			ELSE 'High Income'
		END AS income_group,
		COUNT(DISTINCT sc.CustomerKey) AS customers,
		SUM(sc.OrderQuantity) AS total_orders,
		ROUND(SUM(sc.OrderQuantity * p.ProductPrice), 2) AS revenue
	FROM sales_combined sc
	JOIN customers c 
		ON sc.CustomerKey = c.CustomerKey
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY income_group
	ORDER BY revenue DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- # E. Demographics & Customer Insights
-- 21. Which customer segments (education, occupation) contribute most to sales?
	SELECT 
		c.EducationLevel,
		c.Occupation,
		ROUND(SUM(sc.OrderQuantity * p.ProductPrice), 2) AS revenue
	FROM sales_combined sc
	JOIN customers c 
		ON sc.CustomerKey = c.CustomerKey
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY c.EducationLevel, c.Occupation
	ORDER BY revenue DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 22. Which customer groups have the highest number of children?
	SELECT 
		c.Occupation,
		c.EducationLevel,
		AVG(c.TotalChildren) AS avg_children,
		SUM(c.TotalChildren) AS total_children
	FROM customers c
	GROUP BY c.Occupation, c.EducationLevel
	ORDER BY avg_children DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- # F. Geographic Insights
-- 23. Which countries and continents generate the highest sales?
	SELECT 
		t.Country,
		ROUND(SUM(sc.OrderQuantity * p.ProductPrice), 2) AS revenue
	FROM sales_combined sc
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	JOIN territories t 
		ON sc.TerritoryKey = t.SalesTerritoryKey
	GROUP BY t.Country
	ORDER BY revenue DESC;

	SELECT 
		t.Continent,
		ROUND(SUM(sc.OrderQuantity * p.ProductPrice), 2) AS revenue
	FROM sales_combined sc
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	JOIN territories t 
		ON sc.TerritoryKey = t.SalesTerritoryKey
	GROUP BY t.Continent
	ORDER BY revenue DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 24. Which territories generate the highest returns?
	SELECT 
		t.Region,
		SUM(r.ReturnQuantity) AS total_returns
	FROM returns r
	JOIN territories t 
		ON r.TerritoryKey = t.SalesTerritoryKey
	GROUP BY t.Region
	ORDER BY total_returns DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- # G. Advanced Business Insights (🔥 Standout Level)
-- 25. What is the return rate per product (Returns / Sales)?
	SELECT 
		p.ProductName,
		SUM(r.ReturnQuantity) AS total_returns,
		SUM(sc.OrderQuantity) AS total_sales,
		ROUND(SUM(r.ReturnQuantity) / SUM(sc.OrderQuantity), 4) AS return_rate
	FROM sales_combined sc
	LEFT JOIN returns r 
		ON sc.ProductKey = r.ProductKey
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	GROUP BY p.ProductName
	ORDER BY return_rate DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 26. What is the average selling price variation across regions?
	SELECT 
		t.Region,
		ROUND(AVG(p.ProductPrice), 2) AS avg_price
	FROM sales_combined sc
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	JOIN territories t 
		ON sc.TerritoryKey = t.SalesTerritoryKey
	GROUP BY t.Region
	ORDER BY avg_price DESC;
-- -------------------------------------------------------------------------------------------------------------------------------------
-- 27. Which segments (product + region + customer type) drive maximum profit?
	SELECT 
		p.ProductName,
		t.Region,
		c.Occupation,
		ROUND(SUM(sc.OrderQuantity * (p.ProductPrice - p.ProductCost)), 2) AS profit
	FROM sales_combined sc
	JOIN products p 
		ON sc.ProductKey = p.ProductKey
	JOIN customers c 
		ON sc.CustomerKey = c.CustomerKey
	JOIN territories t 
		ON sc.TerritoryKey = t.SalesTerritoryKey
	GROUP BY p.ProductName, t.Region, c.Occupation
	ORDER BY profit DESC
	LIMIT 10;
# ______________________________________________________________________________________________________________________________________
