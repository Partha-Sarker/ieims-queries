ALTER AUTHORIZATION ON SCHEMA::[boardffu] TO [dbo];
ALTER AUTHORIZATION ON SCHEMA::[boardffu_batchjob] TO [dbo];
DROP USER IF EXISTS [boardffu_user]
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'boardffu_login')
BEGIN
    DROP LOGIN [boardffu_login];
END

CREATE LOGIN boardffu_login WITH PASSWORD=N'd#G&LXYx<<g8\C>fgFlK3b:HR'
Create User boardffu_user For LOGIN boardffu_login
ALTER AUTHORIZATION ON SCHEMA::[boardffu] TO [boardffu_user];
ALTER AUTHORIZATION ON SCHEMA::[boardffu_batchjob] TO [boardffu_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO boardffu_user
ALTER USER boardffu_user WITH DEFAULT_SCHEMA = boardffu