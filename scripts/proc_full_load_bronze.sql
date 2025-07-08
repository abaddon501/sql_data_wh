Create or alter procedure bronze.load_bronze as
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME,
		@batch_start_time datetime, @batch_end_time datetime

	BEGIN TRY

		SET @batch_start_time = GETDATE()
		

		PRINT '=================================================';
		PRINT 'LOADING BRONZE LAYER';
		PRINT '=================================================';
		PRINT ''

		PRINT '-------------------------------------------------';
		PRINT 'LOADING CRM TABLES';
		PRINT '-------------------------------------------------';

		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\bergm\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		)

		SET @end_time = GETDATE()

		PRINT '>> LOAD DURATION: ' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'



		SET @start_time = GETDATE()


		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\bergm\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		)

		SET @end_time = GETDATE()

		PRINT '>> LOAD DURATION: ' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'



		SET @start_time = GETDATE()


		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\bergm\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		)
		SET @end_time = GETDATE()

		PRINT '>> LOAD DURATION: ' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'


		PRINT ''
		PRINT '-------------------------------------------------';
		PRINT 'LOADING ERP TABLES';
		PRINT '-------------------------------------------------';


		SET @start_time = GETDATE()
		
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\bergm\Desktop\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		)

		SET @end_time = GETDATE()

		PRINT '>> LOAD DURATION: ' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'


		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.erp_LOC_A101;
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\bergm\Desktop\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		)
		SET @end_time = GETDATE()

		PRINT '>> LOAD DURATION: ' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

		
		SET @start_time = GETDATE()

		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\bergm\Desktop\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		)

		SET @end_time = GETDATE()

		PRINT '>> LOAD DURATION: ' + cast(Datediff(second, @start_time, @end_time) as nvarchar) + ' seconds'

		PRINT ''
		SET @batch_end_time = GETDATE()
		PRINT '>> FULL LOAD COMPLETED'
		PRINT 'TOTAL DURATION: ' + cast(Datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds'
	END TRY

	BEGIN CATCH
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + error_message();
		print cast(error_number() as nvarchar)
	END CATCH;
END;


EXEC bronze.load_bronze
