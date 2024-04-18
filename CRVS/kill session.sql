BEGIN
    FOR r IN (select sid, serial# from v$session where username = 'CRVSDEV')
        LOOP
            BEGIN
                EXECUTE IMMEDIATE 'alter system kill session ''' || r.sid || ',' || r.serial# || ''' immediate';
            EXCEPTION
                WHEN OTHERS THEN
                    NULL;
            END;
        END LOOP;
END;


SELECT sid, serial#, status, username FROM v$session where username = 'CRVSDEV';
--
-- SELECT 'ALTER SYSTEM KILL SESSION ''' || sid || ',' || serial# || ''' IMMEDIATE;'
-- FROM v$session
-- where username = 'CRVSDEV';
--
-- ALTER SYSTEM KILL SESSION '10,45180' IMMEDIATE;
-- ALTER SYSTEM KILL SESSION '134,52566' IMMEDIATE;
-- ALTER SYSTEM KILL SESSION '136,54037' IMMEDIATE;
-- ALTER SYSTEM KILL SESSION '253,17178' IMMEDIATE;
-- ALTER SYSTEM KILL SESSION '260,33425' IMMEDIATE;
-- ALTER SYSTEM KILL SESSION '374,59666' IMMEDIATE;
-- ALTER SYSTEM KILL SESSION '503,64989' IMMEDIATE;

