ALTER AUTHORIZATION ON SCHEMA::[centre_daily_report] TO [dbo];
ALTER AUTHORIZATION ON SCHEMA::[centre_daily_report_batchjob] TO [dbo];
DROP USER IF EXISTS [centre_daily_report_user]
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'centre_daily_report_login')
BEGIN
    DROP LOGIN [centre_daily_report_login];
END

CREATE LOGIN centre_daily_report_login WITH PASSWORD=N'QP~wU9h?o_ClkI62-Jnh<h}VV'
Create User centre_daily_report_user For LOGIN centre_daily_report_login
ALTER AUTHORIZATION ON SCHEMA::[centre_daily_report] TO [centre_daily_report_user];
ALTER AUTHORIZATION ON SCHEMA::[centre_daily_report_batchjob] TO [centre_daily_report_user];
GRANT CREATE TABLE, CREATE VIEW, CREATE FUNCTION, CREATE PROCEDURE TO centre_daily_report_user
ALTER USER centre_daily_report_user WITH DEFAULT_SCHEMA = centre_daily_report