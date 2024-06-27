DECLARE
    l_batch_size CONSTANT PLS_INTEGER := 50000; -- Batch size
    l_rows_processed      PLS_INTEGER := 0; -- Counter for rows processed
BEGIN
    LOOP
        INSERT INTO CRVS_IDS (CREATED_AT, STUDENT_ID, STATUS)
        SELECT SYSTIMESTAMP, r.id, 0
        FROM STD_REGISTRATION_INFO r
                 JOIN INSTITUTES i ON r.EIIN = i.EIIN
                 LEFT JOIN CRVS_IDS c ON r.ID = c.STUDENT_ID
        WHERE c.id IS NULL
        ORDER BY i.division_id, i.district_id, i.thana_id, i.eiin
        OFFSET l_rows_processed ROWS FETCH NEXT l_batch_size ROWS ONLY;

        l_rows_processed := l_rows_processed + l_batch_size;

        -- Exit condition: Break the loop if no more rows were inserted
        EXIT WHEN SQL%ROWCOUNT = 0;

        COMMIT; -- Commit after each batch
    END LOOP;
END;
/

DECLARE
    CURSOR crvs_cursor IS
        SELECT r.id
        FROM STD_REGISTRATION_INFO r
                 JOIN INSTITUTES i ON i.EIIN = r.EIIN
                 left JOIN CRVS_IDS c ON r.id = c.STUDENT_ID
        WHERE c.id is null
        ORDER BY i.division_id, i.district_id, i.thana_id, i.eiin;
    v_id CRVS_IDS.id%TYPE;

BEGIN
    OPEN crvs_cursor;
    LOOP
        FETCH crvs_cursor INTO v_id;
        EXIT WHEN crvs_cursor%NOTFOUND;
        INSERT INTO CRVS_IDS (CREATED_AT, STUDENT_ID, STATUS) values (SYSTIMESTAMP, v_id, 0);
        COMMIT;

    END LOOP;
    CLOSE crvs_cursor;
END;

