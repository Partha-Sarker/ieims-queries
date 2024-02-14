DECLARE @UserDBCredential TABLE
(
    db_name VARCHAR(100),
    password NVARCHAR(100)
);

-- Insert data into the table variable
INSERT INTO @UserDBCredential (db_name, password)
VALUES
    ('boardreg', N'=F!)&scL]qbZgY]/f\w0iLe>d'),
    ('boardffu', N'd#G&LXYx<<g8\C>fgFlK3b:HR'),
    ('centre_assign', N'=E8\h,5\n4rM!2t(46''''D^/FMD'),
    ('centre_daily_report', N'QP~wU9h?o_ClkI62-Jnh<h}VV'),
    ('examiner_assignment', N'rx@VVFP<i*12+[4:G/fj1rrFl'),
    ('online_application', N'WxDgU&U7p|w.^H$idr5jI#;@F'),
    ('online_fee', N')0{n+Km?Vo[A>8W"]o%OzzE3t'),
    ('practical_mark', N'T5."r|4F!}hvMbKwJ5,=c:a}6'),
    ('smspushpull', N'&RBvgh:%#x/(>FrD4Us_N6ybh')
;

DECLARE @CurrentDBName VARCHAR(100);
DECLARE @CurrentPassword NVARCHAR(100);

-- Declare a cursor to iterate through the table variable
DECLARE db_cursor CURSOR FOR
SELECT db_name, password FROM @UserDBCredential;

-- Open the cursor
OPEN db_cursor;

-- Fetch the first row
FETCH NEXT FROM db_cursor INTO @CurrentDBName, @CurrentPassword;

-- Loop through the rows
WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @SqlScript NVARCHAR(MAX) = '
        ALTER AUTHORIZATION ON SCHEMA::[' + @CurrentDBName + '] TO [dbo];
        IF EXISTS(SELECT 1 FROM sys.schemas WHERE name = ''' + @CurrentDBName + '_batchjob'')
        BEGIN
           ALTER AUTHORIZATION ON SCHEMA::[' + @CurrentDBName + '_batchjob] TO [dbo];
        END
        DROP USER IF EXISTS [' + @CurrentDBName + '_user];

        IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = ''' + @CurrentDBName + '_login'')
        BEGIN
           CREATE LOGIN ' + @CurrentDBName + '_login WITH PASSWORD=N''' + @CurrentPassword + ''';
        END
        CREATE USER ' + @CurrentDBName + '_user FOR LOGIN ' + @CurrentDBName + '_login;
        ALTER AUTHORIZATION ON SCHEMA::[' + @CurrentDBName + '] TO [' + @CurrentDBName + '_user];
        IF EXISTS(SELECT 1 FROM sys.schemas WHERE name = ''' + @CurrentDBName + '_batchjob'')
        BEGIN
            ALTER AUTHORIZATION ON SCHEMA::[' + @CurrentDBName + '_batchjob] TO [' + @CurrentDBName + '_user];
        END
        GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO ' + @CurrentDBName + '_user;
        ALTER USER ' + @CurrentDBName + '_user WITH DEFAULT_SCHEMA = ' + @CurrentDBName + ';';

    BEGIN TRY
        EXEC sp_executesql @SqlScript;
        PRINT 'Successfully permitted user and login for DB Name: '
                  + @CurrentDBName + '; with password Password: ' + @CurrentPassword;
    END TRY
    BEGIN CATCH
        PRINT 'Failed to permit user and login for DB Name: '
                  + @CurrentDBName + '; with password Password: ' + @CurrentPassword + ': Error: ' + ERROR_MESSAGE();
    END catch

    -- Fetch the next row
    FETCH NEXT FROM db_cursor INTO @CurrentDBName, @CurrentPassword;
END;

-- Close and deallocate the cursor
CLOSE db_cursor;
DEALLOCATE db_cursor;

