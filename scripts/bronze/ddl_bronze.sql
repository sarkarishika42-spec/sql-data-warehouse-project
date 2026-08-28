/*
============================================================
DDL Script: Create Bronze Tables
============================================================
Script Purpose: 
This script creates tables in the 'bronze' schema dropping existing tables
if they already exist.
Run this script to re-define the DDL Structure of the 'Bronze' Tables
=============================================================
*/

IF OBJECT_ID ('BRONZE.crm_cust_info', 'U') IS NOT NULL
DROP TABLE BRONZE.crm_cust_info;
CREATE TABLE BRONZE.crm_cust_info (
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_material_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);

IF OBJECT_ID ('BRONZE.crm_prd_info', 'U') IS NOT NULL
DROP TABLE BRONZE.crm_prd_info;
CREATE TABLE BRONZE.crm_prd_info (
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);

IF OBJECT_ID ('BRONZE.crm_sales_details', 'U') IS NOT NULL
DROP TABLE BRONZE.crm_sales_details;
CREATE TABLE BRONZE.crm_sales_details (
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);


IF OBJECT_ID ('BRONZE.erp_loc_a101', 'U') IS NOT NULL
DROP TABLE BRONZE.erp_loc_a101;
CREATE TABLE BRONZE.erp_loc_a101 (
cid NVARCHAR(50),
cntry NVARCHAR(50)
);


IF OBJECT_ID ('BRONZE.erp_cust_az12', 'U') IS NOT NULL
DROP TABLE BRONZE.erp_cust_az12;
CREATE TABLE BRONZE.erp_cust_az12 (
cid NVARCHAR(50),
bdate DATE,
gen NVARCHAR(50)
);


IF OBJECT_ID ('BRONZE.erp_px_cat_g1v2', 'U') IS NOT NULL
DROP TABLE BRONZE.erp_px_cat_g1v2;
CREATE TABLE BRONZE.erp_px_cat_g1v2 (
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
maintenance NVARCHAR(50)
);

GO

CREATE OR ALTER PROCEDURE BRONZE.load_BRONZE AS
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
SET @batch_start_time = GETDATE();
PRINT '==============================';
PRINT 'LOADING BRONZE LAYER';
PRINT '==============================';

PRINT '------------------------------';
PRINT 'LOADING CRM TABLES';
PRINT '------------------------------';

SET @start_time = GETDATE();
PRINT '>> TRUNCATING TABLE: BRONZE.crm_cust_info'; 
TRUNCATE TABLE BRONZE.crm_cust_info;
PRINT '>> INSERTING DATA INTO: BRONZE.crm_cust_info'; 
BULK INSERT BRONZE.crm_cust_info
FROM 'C:\Users\SOUMIKA\Downloads\sql-data-warehouse-project (2)\datasets\source_crm\cust_info.csv'
WITH (
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK
);
SET @end_time = GETDATE();
PRINT ' >> LOAD DURATION: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';
PRINT '-------------------------------';

SELECT COUNT (*) FROM BRONZE.crm_cust_info

SET @start_time = GETDATE();
PRINT '>> TRUNCATING TABLE: BRONZE.crm_prd_info'; 
TRUNCATE TABLE BRONZE.crm_prd_info;
PRINT '>> INSERTING DATA INTO: BRONZE.crm_prd_info';
BULK INSERT BRONZE.crm_prd_info
FROM 'C:\Users\SOUMIKA\Downloads\sql-data-warehouse-project (2)\datasets\source_crm\prd_info.csv'
WITH (
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK 
);
SET @end_time = GETDATE();
PRINT ' >> LOAD DURATION: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';
PRINT '-------------------------------';
SELECT COUNT (*) FROM BRONZE.crm_prd_info

SET @start_time = GETDATE();
PRINT '>> TRUNCATING TABLE: BRONZE.crm_sales_details';
TRUNCATE TABLE BRONZE.crm_sales_details;
PRINT '>> INSERTING DATA INTO: BRONZE.crm_sales_details';
BULK INSERT BRONZE.crm_sales_details
FROM 'C:\Users\SOUMIKA\Downloads\sql-data-warehouse-project (2)\datasets\source_crm\sales_details.csv'
WITH (
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK
);
SET @end_time = GETDATE();
PRINT ' >> LOAD DURATION: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';
PRINT '-------------------------------';

SELECT COUNT (*) FROM BRONZE.crm_sales_details

PRINT '------------------------------';
PRINT 'LOADING ERP TABLES';
PRINT '------------------------------';

SET @start_time = GETDATE();
PRINT '>> TRUNCATING TABLE: BRONZE.erp_loc_a101';
TRUNCATE TABLE BRONZE.erp_loc_a101;
PRINT '>> INSERTING DATA INTO: BRONZE.erp_loc_a101';
BULK INSERT BRONZE.erp_loc_a101
FROM 'C:\Users\SOUMIKA\Downloads\sql-data-warehouse-project (2)\datasets\source_erp\loc_a101.csv'
WITH (
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK
);
SET @end_time = GETDATE();
PRINT ' >> LOAD DURATION: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';
PRINT '-------------------------------';

SELECT COUNT (*) FROM BRONZE.erp_loc_a101

SET @start_time = GETDATE();
PRINT '>> TRUNCATING TABLE: BRONZE.erp_cust_az12';
TRUNCATE TABLE BRONZE.erp_cust_az12;
PRINT '>> INSERTING DATA INTO: BRONZE.erp_cust_az12';
BULK INSERT BRONZE.erp_cust_az12
FROM 'C:\Users\SOUMIKA\Downloads\sql-data-warehouse-project (2)\datasets\source_erp\cust_az12.csv'
WITH (
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK
);
SET @end_time = GETDATE();
PRINT ' >> LOAD DURATION: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';
PRINT '-------------------------------';

SELECT COUNT (*) FROM BRONZE.erp_cust_az12

SET @start_time = GETDATE();
PRINT '>> TRUNCATING TABLE: BRONZE.erp_px_cat_g1v2';
TRUNCATE TABLE BRONZE.erp_px_cat_g1v2;
PRINT '>> INSERTING DATA INTO: BRONZE.erp_px_cat_g1v2';
BULK INSERT BRONZE.erp_px_cat_g1v2
FROM 'C:\Users\SOUMIKA\Downloads\sql-data-warehouse-project (2)\datasets\source_erp\px_cat_g1v2.csv'
WITH (
	 FIRSTROW = 2,
	 FIELDTERMINATOR = ',',
	 TABLOCK
);
SET @end_time = GETDATE();
PRINT ' >> LOAD DURATION: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR(20)) + ' seconds';
PRINT '-------------------------------';
SELECT COUNT (*) FROM BRONZE.erp_px_cat_g1v2
SET @batch_end_time = GETDATE();
PRINT '===================================================';
PRINT 'LOADING BRONZE LAYER IS COMPLETED';
PRINT ' - TOTAL LOAD DURATION: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
PRINT '===================================================';
END TRY
BEGIN CATCH 
PRINT '===========================================';
PRINT 'ERROR OCCURED DURING BRONZE LAYER LOADING';
PRINT 'Error Messsage' + ERROR_MESSAGE();
PRINT 'Error Messsage' + CAST (ERROR_NUMBER() AS NVARCHAR);
PRINT 'Error Messsage' + CAST (ERROR_STATE() AS NVARCHAR);
PRINT '===========================================';
END CATCH
END
GO
EXEC BRONZE.load_BRONZE;

GO
