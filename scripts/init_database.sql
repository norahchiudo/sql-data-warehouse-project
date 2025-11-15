/*
====================================================
Creating Database and Schemas
====================================================
This Script creates a new database named 'DataWarehouse' after checking if it already exists
*/

USE master;
GO
IF EXISTS ( SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse' )
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse
GO
