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