INSERT INTO CRVS_IDS (CREATED_AT, STUDENT_ID, STATUS)
SELECT SYSTIMESTAMP, r.id, 0
FROM STD_REGISTRATION_INFO r
         JOIN INSTITUTES i ON r.EIIN = i.EIIN
         LEFT JOIN CRVS_IDS c ON r.ID = c.STUDENT_ID
WHERE c.id IS NULL
ORDER BY i.division_id, i.district_id, i.thana_id, i.eiin;
COMMIT;


select STATUS, count(STATUS) from CRVS_IDS group by STATUS