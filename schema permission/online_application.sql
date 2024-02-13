ALTER AUTHORIZATION ON SCHEMA::[online_application] TO [dbo];
DROP USER IF EXISTS [online_application_user]
DROP LOGIN [online_application_login];
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'online_application_login')
BEGIN
    DROP LOGIN [online_application_login];
END

CREATE LOGIN online_application_login WITH PASSWORD=N'WxDgU&U7p|w.^H$idr5jI#;@F'
Create User online_application_user For LOGIN online_application_login
ALTER AUTHORIZATION ON SCHEMA::[online_application] TO [online_application_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO online_application_user
ALTER USER online_application_user WITH DEFAULT_SCHEMA = online_application