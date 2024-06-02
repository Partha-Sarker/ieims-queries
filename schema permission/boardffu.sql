SELECT session_id, name
FROM sys.dm_exec_sessions join sys.databases on databases.database_id = dm_exec_sessions.database_id
WHERE login_name = 'boardffu_login' and name = 'beb'

kill 615;
kill 651;
kill 724;
kill 808;
kill 1176;
kill 1257;
kill 1280;
kill 1325;
kill 1360;
kill 2301;



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