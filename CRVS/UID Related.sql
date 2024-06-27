select count(INSTITUTE_ID)
from INSTITUTES
where UID_GENERATE_STATUS = 2
/
select count(INSTITUTE_ID)
from INSTITUTES
where DIVISION_ID in (20, 10, 30, 40, 45, 50, 55, 60)
  and UID_GENERATE_STATUS = 0
  and INSTITUTE_TYPE_ID in (1, 2, 3, 4, 5)
/
select distinct EIIN
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
DECLARE
  CURSOR eiin_cursor IS
    SELECT DISTINCT EIIN
    FROM STD_REGISTRATION_INFO
    WHERE UID_STATUS = 0
      AND IS_EIGHTEEN = 0
      AND "UID" IS NULL
      AND TAB_STATUS >= 2
      AND DOB > ADD_MONTHS(SYSDATE, -12 * 18)
      AND ORG_NAME_ENGLISH IS NOT NULL
      AND ORG_NAME_BANGLA IS NOT NULL
      AND MOTHER_NID != FATHER_NID;
BEGIN
  FOR eiin_record IN eiin_cursor LOOP
    UPDATE INSTITUTES
    SET UID_GENERATE_STATUS = 0,
        STOP = NULL
    WHERE EIIN = eiin_record.EIIN
      AND DIVISION_ID IN (20, 10, 30, 40, 45, 50, 55, 60)
      AND INSTITUTE_TYPE_ID IN (1, 2, 3, 4, 5);
  END LOOP;
  COMMIT;
END;

/
select count(ID) students, count(distinct EIIN) institutes, SYSDATE
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
WHERE CREATED_AT >= to_timestamp('2024-06-05', 'YYYY-MM-DD')
group by MESSAGE
ORDER BY count(MESSAGE) DESC
/

Select count(ID), SYSDATE
from ARC_ORG_VERIFICATIONS
WHERE CREATED_AT >= to_timestamp('2024-06-05', 'YYYY-MM-DD')
/


update INSTITUTES
set UID_GENERATE_STATUS = 1
where UID_GENERATE_STATUS = 0
  and EIIN not in (select distinct EIIN
                   from STD_REGISTRATION_INFO
                   WHERE UID_STATUS = 0
                     and IS_EIGHTEEN = 0
                     and "UID" IS NULL
                     and TAB_STATUS >= 2
                     and DOB > ADD_MONTHS(SYSDATE, -12 * 18)
                     and ORG_NAME_ENGLISH is not null
                     and ORG_NAME_BANGLA is not null
                     and MOTHER_NID != FATHER_NID);
commit;

select count(INSTITUTE_ID)
from INSTITUTES
where UID_GENERATE_STATUS = 0
/