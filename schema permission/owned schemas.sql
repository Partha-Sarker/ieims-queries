DECLARE @UserName NVARCHAR(255) = 'boardreg_user';

SELECT s.name AS SchemaName
FROM sys.schemas s
INNER JOIN sys.database_principals dp ON s.principal_id = dp.principal_id
WHERE dp.name = @UserName;