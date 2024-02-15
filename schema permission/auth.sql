ALTER AUTHORIZATION ON SCHEMA::[auth] TO [dbo];
DROP USER IF EXISTS [auth_user]

IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'auth_login')
BEGIN
    CREATE LOGIN auth_login WITH PASSWORD=N'ML$qHz/r%GC\XbEAN*RZKlG5>'
END
Create User auth_user For LOGIN auth_login
ALTER AUTHORIZATION ON SCHEMA::[auth] TO [auth_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO auth_user
ALTER USER auth_user WITH DEFAULT_SCHEMA = auth