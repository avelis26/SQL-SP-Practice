/* Goal: Use SQL flow control (IF, CASE, loops).
        Example: Write a procedure that iterates through a list of records and performs updates based on a condition.
        Practice:
            Use of IF/ELSE, WHILE, and LOOP.
            Conditional logic and branching.
*/


USE AdventureWorks2019;
GO

CREATE OR ALTER PROCEDURE UpdateEmployeeSickLeaveHours
AS
BEGIN
    DECLARE @EmployeeID INT, @SickLeaveHours INT;
    DECLARE @TotalEmployees INT, @Counter INT = 1;

    SELECT @TotalEmployees = COUNT(*) FROM HumanResources.Employee;
    
    WHILE @Counter <= @TotalEmployees
    BEGIN
        SELECT TOP 1
            @EmployeeID = BusinessEntityID,
            @SickLeaveHours = SickLeaveHours
        FROM HumanResources.Employee
        WHERE BusinessEntityID NOT IN (SELECT TOP (@Counter - 1) BusinessEntityID FROM HumanResources.Employee ORDER BY BusinessEntityID)
        ORDER BY BusinessEntityID;

        IF @SickLeaveHours > 40
        BEGIN
            UPDATE HumanResources.Employee
            SET SickLeaveHours = @SickLeaveHours * 0.95
            WHERE BusinessEntityID = @EmployeeID;
        END
        ELSE IF @SickLeaveHours < 20
        BEGIN
            UPDATE HumanResources.Employee
            SET SickLeaveHours = @SickLeaveHours * 1.10
            WHERE BusinessEntityID = @EmployeeID;
        END
        ELSE
        BEGIN
            UPDATE HumanResources.Employee
            SET SickLeaveHours = @SickLeaveHours * 0.98
            WHERE BusinessEntityID = @EmployeeID;
        END

        SET @Counter = @Counter + 1;
    END
END;
GO

EXEC [dbo].[UpdateEmployeeSickLeaveHours]
