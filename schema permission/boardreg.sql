ALTER AUTHORIZATION ON SCHEMA::[boardreg] TO [dbo];
ALTER AUTHORIZATION ON SCHEMA::[reg] TO [dbo];
ALTER AUTHORIZATION ON SCHEMA::[boardreg_batchjob] TO [dbo];
DROP USER IF EXISTS [boardreg_user]
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'boardreg_login')
BEGIN
    DROP LOGIN [boardreg_login];
END

CREATE LOGIN boardreg_login WITH PASSWORD=N'=F!)&scL]qbZgY]/f\w0iLe>d'
Create User boardreg_user For LOGIN boardreg_login
ALTER AUTHORIZATION ON SCHEMA::[boardreg] TO [boardreg_user];
ALTER AUTHORIZATION ON SCHEMA::[boardreg_batchjob] TO [boardreg_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO boardreg_user
ALTER USER boardreg_user WITH DEFAULT_SCHEMA = boardreg