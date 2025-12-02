---Check For Nulls or Duplicate in Primary Key
--Expectations: No Result
SELECT 
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

--Check For Spaces(Check for all String Values)
SELECT 
cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

--Data Standardization and Consistency 
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info;


--CHECK FOR DUPLICATES AND OR NULL
SELECT 
prd_id,
COUNT(*)
FROM silver.crm_prd_info
WHERE prd_key IS NULL
GROUP BY prd_id
HAVING COUNT(*) > 1 ;

--CHECK FOR UNWANTED SPACES
SELECT 
prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

--CHECK FOR NULLS AND NEGATIVE VALUES
SELECT 
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost IS NULL OR prd_cost < 0;
/*====================================================================
Script Purpose : Performs quality checks for data consistency,accuracy 
and Standardization across the 'silver' schema*/
=====================================================================
DATA STANDARDIZATION
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

--CHECK FOR INVALID DATE ORDER
SELECT prd_start_dt,
prd_end_dt
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt OR prd_start_dt IS NULL OR prd_start_dt = '';

--CHECK FOR INVALID DATES
SELECT 
NULLIF(sls_due_dt,0)
FROM bronze.crm_sales_details
WHERE sls_due_dt < =0 
OR LEN(sls_due_dt) !=8
OR sls_due_dt> 20500101
OR sls_due_dt < 19000101;

--CHECK FOR INVALID DATE ORDERS
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
OR sls_order_dt>sls_ship_dt
OR sls_ship_dt >sls_due_dt;

--BUSINESS RULES(SUM OF SALES = QUANTITY * PRICE), NEGATIVE, ZEROS,NULLS ARE NOT ALLOWED
SELECT sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales ! = sls_quantity *sls_price 
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales < =0 OR sls_quantity <= 0 OR sls_price < =0


--IDENTIFY THE DIFFERENT cid
SELECT 
cid
FROM silver.erp_cust_az12
WHERE cid LIKE 'NAS%'

---IDENTIFY OUT OF RANGE DATE
SELECT DISTINCT 
bdate
FROM silver.erp_cust_az12
WHERE  bdate > GETDATE();

--DATA STANDARDIZATION & CONSISTENCY
SELECT DISTINCT 
gen
FROM silver.erp_cust_az12

--STANDARDIZED cid FOR DATA MODELING
SELECT 
cid
FROM silver.erp_loc_a101

--DATA STANDARDIZATION AND CONSISTENCY
SELECT DISTINCT
cntry
FROM silver.erp_loc_a101


-- CHECK FOR UNWANTED SPACES
SELECT *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR
subcat ! = TRIM(subcat) OR
maintenance ! = TRIM(maintenance) 


--DATA STANDARDIZATION
SELECT DISTINCT
subcat
FROM silver.erp_px_cat_g1v2
