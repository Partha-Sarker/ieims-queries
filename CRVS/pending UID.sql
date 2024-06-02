select count(distinct i.INSTITUTE_ID)
from STD_REGISTRATION_INFO r
         join INSTITUTES i on i.EIIN = r.EIIN
WHERE ORG_NAME_ENGLISH is not null
  and ORG_NAME_BANGLA is not null
  and IS_EIGHTEEN = 0
  and DOB > ADD_MONTHS(SYSDATE, -12 * 18)
  and TAB_STATUS >= 2
  and UID_STATUS = 0
  and "UID" IS NULL
  and (MOTHER_NID_STATUS = 1 OR FATHER_NID_STATUS = 1)
  and MOTHER_NID != FATHER_NID
  and INSTITUTE_TYPE_ID in (1, 2, 3, 4, 5)
  and stop is null
