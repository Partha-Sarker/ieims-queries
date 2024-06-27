DECLARE @SchemaName NVARCHAR(100) = 'centre_assign'

DECLARE @SchemaTable TABLE
(
    table_name VARCHAR(100)
);

INSERT INTO @SchemaTable
SELECT t.name
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = @SchemaName and t.name not like '%databasechangelog%'

DECLARE @CurrentTable nvarchar(100)
DECLARE TableCursor cursor for SELECT table_name from @SchemaTable

open TableCursor
fetch next from TableCursor into @CurrentTable

WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @MaxId INT = 1000;
    DECLARE @Id int;
    DECLARE @sqlMaxId NVARCHAR(MAX) = N'SELECT @Id = MAX(id) FROM ' + @SchemaName + '.' + @CurrentTable;
    EXEC sp_executesql @sqlMaxId, N'@ID INT OUTPUT', @ID = @Id OUTPUT;

    IF @MaxId IS NOT NULL
        PRINT @Id
    BEGIN
        DECLARE @sql NVARCHAR(MAX) = N'ALTER SEQUENCE ' + @SchemaName + '.' + @CurrentTable + '_seq RESTART WITH ' + CAST(@Id + 150 AS NVARCHAR(20));
        EXEC sp_executesql @sql;
    END

    FETCH NEXT FROM TableCursor INTO @CurrentTable;
END

