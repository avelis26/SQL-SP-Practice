/* Goal: Create a simple stored procedure that accepts input parameters and returns a result.
        Example: Write a procedure to retrieve a list of persons and the city they live in.
        Practice:
            Basic IN parameters.
            Simple SELECT queries.
            RETURN or OUT parameters.
*/

USE AdventureWorks2019;

GO

CREATE OR ALTER PROCEDURE GetPersonAndCity
	@PersonType varchar(3)
AS
BEGIN
	SELECT
		p.[FirstName],
		p.[LastName],
		a.[City]
	FROM [AdventureWorks2019].[Person].[Person] AS p
	JOIN [AdventureWorks2019].[Person].[Address] AS a
	ON a.[AddressID] = p.[BusinessEntityID]
	WHERE p.[PersonType] = @PersonType;
END;

GO

EXEC [dbo].[GetPersonAndCity] @PersonType = 'EM';