ALTER AUTHORIZATION ON SCHEMA::[examiner_assignment] TO [dbo];
DROP USER IF EXISTS [examiner_assignment_user]
DROP LOGIN [examiner_assignment_login];
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'examiner_assignment_login')
BEGIN
    DROP LOGIN [examiner_assignment_login];
END

CREATE LOGIN examiner_assignment_login WITH PASSWORD=N'rx@VVFP<i*12+[4:G/fj1rrFl'
Create User examiner_assignment_user For LOGIN examiner_assignment_login
ALTER AUTHORIZATION ON SCHEMA::[examiner_assignment] TO [examiner_assignment_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO examiner_assignment_user
ALTER USER examiner_assignment_user WITH DEFAULT_SCHEMA = examiner_assignment