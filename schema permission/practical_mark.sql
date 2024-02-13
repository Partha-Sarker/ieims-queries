ALTER AUTHORIZATION ON SCHEMA::[practical_mark] TO [dbo];
ALTER AUTHORIZATION ON SCHEMA::[practical_mark_batchjob] TO [dbo];
DROP USER IF EXISTS [practical_mark_user]
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'practical_mark_login')
BEGIN
    DROP LOGIN [practical_mark_login];
END

CREATE LOGIN practical_mark_login WITH PASSWORD=N'T5."r|4F!}hvMbKwJ5,=c:a}6'
Create User practical_mark_user For LOGIN practical_mark_login
ALTER AUTHORIZATION ON SCHEMA::[practical_mark] TO [practical_mark_user];
ALTER AUTHORIZATION ON SCHEMA::[practical_mark_batchjob] TO [practical_mark_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO practical_mark_user
ALTER USER practical_mark_user WITH DEFAULT_SCHEMA = practical_mark