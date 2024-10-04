/* Goal: Create a simple stored procedure that accepts input parameters and returns a result.
        Example: Write a procedure to retrieve a list of users from a table based on a role.
        Practice:
            Basic IN parameters.
            Simple SELECT queries.
            RETURN or OUT parameters.
*/

/*
USE UserManagement;

CREATE PROCEDURE GetUsersByRole(IN userRole VARCHAR(50))
BEGIN
    SELECT id, username, email
    FROM users
    WHERE role = userRole;
END;

CALL GetUsersByRole('admin');
*/
USE master
GO
SELECT @@VERSION AS 'SQL Server Version';
