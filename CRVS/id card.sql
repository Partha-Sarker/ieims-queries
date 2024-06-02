select r.id,
       PERMANENTDISTTICTID,
       PERMANENTTHANAID,
       PERMANENT_CITY_CORPORATION,
       PERMANENTUNIONID,
       PERMANENTAREAID,
       PERMANENT_ADDRESS,
       PERMANENTHOUSEHOLDNO,
       PERMANENT_POST_OFFICE,
       PERMANENTPOSTCODE

from STD_REGISTRATION_INFO r
         join STD_CURRENT_ACADEMIC_INFO a on a.SRI_ID = r.id
where r.EIIN = 100007
  and FATHERNAME_BANGLA is not null
  and MOTHERNAME_BANGLA is not null
  and BIN_BRN is not null
  and (r.STATUS = 1 or TEMP_STATUS = 1)
  and a.ACADEMIC_YEAR = 2024
  and PERMANENTHOUSEHOLDNO is not null
  and BLOOD_GROUP is not null
  and r."UID" is not null
  and r.STD_CRVS_ID is not null
