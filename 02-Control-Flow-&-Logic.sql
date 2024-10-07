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

    -- Get total number of employees in the HumanResources.Employee table
    SELECT @TotalEmployees = COUNT(*) FROM HumanResources.Employee;
    
    -- WHILE loop to iterate through each employee
    WHILE @Counter <= @TotalEmployees
    BEGIN
        -- Get the employee data one by one
        SELECT TOP 1
            @EmployeeID = BusinessEntityID,
            @SickLeaveHours = SickLeaveHours
        FROM HumanResources.Employee
        WHERE BusinessEntityID NOT IN (SELECT TOP (@Counter - 1) BusinessEntityID FROM HumanResources.Employee ORDER BY BusinessEntityID)
        ORDER BY BusinessEntityID;

        -- Update SickLeaveHours based on conditions
        IF @SickLeaveHours > 40
        BEGIN
            -- SickLeaveHours greater than 40, decrease by 5%
            UPDATE HumanResources.Employee
            SET SickLeaveHours = @SickLeaveHours * 0.95
            WHERE BusinessEntityID = @EmployeeID;
        END
        ELSE IF @SickLeaveHours < 20
        BEGIN
            -- SickLeaveHours less than 20, increase by 10%
            UPDATE HumanResources.Employee
            SET SickLeaveHours = @SickLeaveHours * 1.10
            WHERE BusinessEntityID = @EmployeeID;
        END
        ELSE
        BEGIN
            -- SickLeaveHours between 20 and 40, decrease by 2%
            UPDATE HumanResources.Employee
            SET SickLeaveHours = @SickLeaveHours * 0.98
            WHERE BusinessEntityID = @EmployeeID;
        END

        -- Increment the counter
        SET @Counter = @Counter + 1;
    END
END;
GO
