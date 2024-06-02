select r.EIIN, count(r.EIIN)
from STD_REGISTRATION_INFO r join STD_CURRENT_ACADEMIC_INFO a on a.SRI_ID = r.id
where (r.STATUS = 1 or TEMP_STATUS = 1) and a.ACADEMIC_YEAR = 2024
group by r.EIIN
having count(r.EIIN) >= 10
ORDER BY count(r.EIIN)
/

truncate table STUDENT_ID_CARD_JOBS;
commit;