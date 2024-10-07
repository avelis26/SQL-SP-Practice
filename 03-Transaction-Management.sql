/* Goal: Implement transactions to ensure data integrity.
        Example: Write a procedure that transfers money between accounts, using transactions to commit/rollback changes.
        Practice:
            START TRANSACTION, COMMIT, ROLLBACK.
            Handling concurrent operations with locks or isolation levels.
            Error recovery using transactions.
*/


USE [AdventureWorks2019];
GO

CREATE OR ALTER PROCEDURE [GetEmployeeSickLeaveDetails]
AS
BEGIN
	SELECT 
		 p.[FirstName]
		,p.[LastName]
		,e.[SickLeaveHours]
	FROM 
		   [HumanResources].[Employee] AS e
	JOIN 
		   [Person].[Person] AS p ON e.[BusinessEntityID] = p.[BusinessEntityID]
	ORDER BY 
		 p.[LastName], p.[FirstName];
END;
GO

EXEC	   [dbo].[GetEmployeeSickLeaveDetails]