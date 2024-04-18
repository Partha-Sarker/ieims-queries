IF EXISTS (SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'online_application')
BEGIN
    ALTER AUTHORIZATION ON SCHEMA::[online_application] TO [dbo];
END
DROP USER IF EXISTS [online_application_user]
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'online_application_login')
BEGIN
    DROP LOGIN [online_application_login];
END

CREATE LOGIN online_application_login WITH PASSWORD=N'WxDgU&U7p|w.^H$idr5jI#;@F'
Create User online_application_user For LOGIN online_application_login
IF NOT EXISTS (SELECT schema_name FROM information_schema.schemata WHERE schema_name = 'online_application')
BEGIN
    EXEC('create schema online_application')
END
ALTER AUTHORIZATION ON SCHEMA::[online_application] TO [online_application_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO online_application_user
ALTER USER online_application_user WITH DEFAULT_SCHEMA = online_application