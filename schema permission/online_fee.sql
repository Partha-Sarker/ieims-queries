ALTER AUTHORIZATION ON SCHEMA::[online_fee] TO [dbo];
DROP USER IF EXISTS [online_fee_user]
DROP LOGIN [online_fee_login];
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'online_fee_login')
BEGIN
    DROP LOGIN [online_fee_login];
END

CREATE LOGIN online_fee_login WITH PASSWORD=N')0{n+Km?Vo[A>8W"]o%OzzE3t'
Create User online_fee_user For LOGIN online_fee_login
ALTER AUTHORIZATION ON SCHEMA::[online_fee] TO [online_fee_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO online_fee_user
ALTER USER online_fee_user WITH DEFAULT_SCHEMA = online_fee