ALTER AUTHORIZATION ON SCHEMA::[masterdata] TO [dbo];
DROP USER IF EXISTS [masterdata_user]
DROP LOGIN [masterdata_login];

CREATE LOGIN masterdata_login WITH PASSWORD=N'03]TU$4U(({-n8!h}x/q!1''e)'
Create User masterdata_user For LOGIN masterdata_login
ALTER AUTHORIZATION ON SCHEMA::[masterdata] TO [masterdata_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO masterdata_user
ALTER USER masterdata_user WITH DEFAULT_SCHEMA = masterdata