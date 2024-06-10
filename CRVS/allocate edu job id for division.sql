select c.id
from CRVS_IDS c
         join STD_REGISTRATION_INFO r on r.id = c.STUDENT_ID
         join INSTITUTES i on i.EIIN = r.EIIN
where i.DIVISION_ID = 10
  and c.STATUS = 0 and JOB_ID in (669, 670, 671, 672, 673, 674, 675, 692, 693, 694, 695, 696, 697)
fetch next 1000 rows only
/

SELECT count(c.id)
FROM CRVS_IDS c
     JOIN STD_REGISTRATION_INFO r ON r.id = c.STUDENT_ID
     JOIN INSTITUTES i ON i.EIIN = r.EIIN
WHERE i.DIVISION_ID != 10
  AND c.STATUS = 0;

/
select id from EDU_ID_ALLOCATION_JOB where STATUS = 'PENDING' order by id
/

DECLARE
  CURSOR crvs_cursor IS
    SELECT c.id
    FROM CRVS_IDS c
         JOIN STD_REGISTRATION_INFO r ON r.id = c.STUDENT_ID
         JOIN INSTITUTES i ON i.EIIN = r.EIIN
    WHERE i.DIVISION_ID != 10
      AND c.STATUS = 0;

  v_id CRVS_IDS.id%TYPE;

BEGIN
  OPEN crvs_cursor;
  LOOP
    FETCH crvs_cursor INTO v_id;
    EXIT WHEN crvs_cursor%NOTFOUND;

    delete from CRVS_IDS WHERE id = v_id;

    COMMIT; -- Commit after each update

  END LOOP;
  CLOSE crvs_cursor;
END;
/