ALTER AUTHORIZATION ON SCHEMA::[centre_assign] TO [dbo];
DROP USER IF EXISTS [centre_assign_user]

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'centre_assign_login')
BEGIN
    CREATE LOGIN centre_assign_login WITH PASSWORD=N'=E8\h,5\n4rM!2t(46''D^/FMD'
END
Create User centre_assign_user For LOGIN centre_assign_login
ALTER AUTHORIZATION ON SCHEMA::[centre_assign] TO [centre_assign_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO centre_assign_user
ALTER USER centre_assign_user WITH DEFAULT_SCHEMA = centre_assign