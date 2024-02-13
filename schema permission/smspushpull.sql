ALTER AUTHORIZATION ON SCHEMA::[smspushpull] TO [dbo];
DROP USER IF EXISTS [smspushpull_user]
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'smspushpull_login')
BEGIN
    DROP LOGIN [smspushpull_login];
END

CREATE LOGIN smspushpull_login WITH PASSWORD=N'&RBvgh:%#x/(>FrD4Us_N6ybh'
Create User smspushpull_user For LOGIN smspushpull_login
ALTER AUTHORIZATION ON SCHEMA::[smspushpull] TO [smspushpull_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO smspushpull_user
ALTER USER smspushpull_user WITH DEFAULT_SCHEMA = smspushpull