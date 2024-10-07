/* Goal: Create a simple stored procedure that accepts input parameters and returns a result.
        Example: Write a procedure to retrieve a list of persons and the city they live in.
        Practice:
            Basic IN parameters.
            Simple SELECT queries.
            RETURN or OUT parameters.
*/
/*
PersonType = IN EM SP SC VC GC
*/
USE AdventureWorks2019;

GO

CREATE OR ALTER PROCEDURE GetPersonAndCity
	@PersonType1 varchar(3),
	@PersonType2 varchar(3) = '',
	@PersonType3 varchar(3) = '',
	@PersonType4 varchar(3) = ''
AS
BEGIN
	SELECT
		p.[FirstName],
		p.[LastName],
		a.[City],
		p.[PersonType]
	FROM [AdventureWorks2019].[Person].[Person] AS p
	JOIN [AdventureWorks2019].[Person].[Address] AS a
	ON a.[AddressID] = p.[BusinessEntityID]
	WHERE p.[PersonType] IN ( @PersonType1, @PersonType2, @PersonType3 );
  
	SELECT COUNT(*) AS PersonCount
	FROM [AdventureWorks2019].[Person].[Person] AS p
	WHERE p.[PersonType] IN ( @PersonType1, @PersonType2, @PersonType3 );
END;

GO

EXEC [dbo].[GetPersonAndCity] @PersonType1 = 'EM', @PersonType2 = 'SC', @PersonType3 = 'IN';
