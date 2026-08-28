/*
==================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==================================================================
This stored procedure loads data into the 'bronze' schema from external CSV Files.
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the 'BULK INSERT' command to load data from csv files to bronze tables.
Parameters:
None
This stored procedure does not accept any parameteres or return any values.
Usage example:
Exec BRONZE.load_BRONZE;
===================================================================
*/


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
