select count(INSTITUTE_ID)
from INSTITUTES
where UID_GENERATE_STATUS = 2
/
select count(INSTITUTE_ID)
from INSTITUTES
where DIVISION_ID in (20, 10, 30, 40, 45, 50, 55, 60)
  and UID_GENERATE_STATUS = 0
  and stop is null
  and INSTITUTE_TYPE_ID in (1, 2, 3, 4, 5)
/
update INSTITUTES
set UID_GENERATE_STATUS = 0,
    STOP                = null
where EIIN in (select distinct EIIN
               from STD_REGISTRATION_INFO
               WHERE UID_STATUS = 0
                 and IS_EIGHTEEN = 0
                 and "UID" IS NULL
                 and TAB_STATUS >= 2
                 and DOB > ADD_MONTHS(SYSDATE, -12 * 18)
                 and ORG_NAME_ENGLISH is not null
                 and ORG_NAME_BANGLA is not null
                 and MOTHER_NID != FATHER_NID)
  and DIVISION_ID in (20, 10, 30, 40, 45, 50, 55, 60)
  and INSTITUTE_TYPE_ID in (1, 2, 3, 4, 5);
commit;
/
select count(ID), SYSDATE
from STD_REGISTRATION_INFO
WHERE UID_STATUS = 0
  and IS_EIGHTEEN = 0
  and "UID" IS NULL
  and TAB_STATUS >= 2
  and DOB > ADD_MONTHS(SYSDATE, -12 * 18)
  and ORG_NAME_ENGLISH is not null
  and ORG_NAME_BANGLA is not null
  and MOTHER_NID != FATHER_NID
/

Select MESSAGE, count(MESSAGE)
from ARC_ORG_VERIFICATIONS
WHERE CREATED_AT >= to_timestamp('2024-05-29', 'YYYY-MM-DD')
group by MESSAGE
ORDER BY count(MESSAGE) DESC
/

Select count(ID), SYSDATE
from ARC_ORG_VERIFICATIONS
WHERE CREATED_AT >= to_timestamp('2024-05-29', 'YYYY-MM-DD')
/
