INSERT INTO CRVS_IDS (CREATED_AT, STUDENT_ID, STATUS)
SELECT SYSTIMESTAMP, r.id, 0
FROM STD_REGISTRATION_INFO r
         JOIN INSTITUTES i ON r.EIIN = i.EIIN
         LEFT JOIN CRVS_IDS c ON r.ID = c.STUDENT_ID
WHERE c.id IS NULL
ORDER BY i.division_id, i.district_id, i.thana_id, i.eiin;
COMMIT;


SELECT count(r.ID)
FROM STD_REGISTRATION_INFO r
         JOIN INSTITUTES i ON r.EIIN = i.EIIN
         LEFT JOIN CRVS_IDS c ON r.ID = c.STUDENT_ID
WHERE c.id IS NULL;

update CRVS_IDS
set STATUS  = 0,
    MESSAGE = null,
    JOB_ID  = null
where STATUS != 0;
commit;

select count(c.id)
from CRVS_IDS c
where (c.STATUS != 1 or c.JOB_ID is null or c.MESSAGE is not null)
  and STUDENT_ID in (select id from STD_REGISTRATION_INFO where STD_CRVS_ID is not null)
/
select c.id
from CRVS_IDS c
         join STD_REGISTRATION_INFO r on r.id = c.STUDENT_ID
where r.STD_CRVS_ID is not null
  and (c.STATUS != 1 or c.MESSAGE is not null or c.JOB_ID is not null)