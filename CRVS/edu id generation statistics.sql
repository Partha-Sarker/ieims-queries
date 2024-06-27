select count(id), sysdate
from CRVS_IDS
where STATUS = 0
/

select eiaj.ID, count(ci.id)
from EDU_ID_ALLOCATION_JOB eiaj
         join CRVS_IDS ci on eiaj.ID = ci.JOB_ID
where eiaj.STATUS = 'PENDING'
  and ci.STATUS != 0
group by eiaj.ID
/

select ci.status, count(ci.id), sysdate
from EDU_ID_ALLOCATION_JOB eiaj
         join CRVS_IDS ci on eiaj.ID = ci.JOB_ID
where eiaj.STATUS = 'PENDING'
  and ci.STATUS != 0
group by ci.STATUS
/

select ci.status, ci.message, count(ci.id), sysdate
from EDU_ID_ALLOCATION_JOB eiaj
         join CRVS_IDS ci on eiaj.ID = ci.JOB_ID
where eiaj.STATUS = 'PENDING'
group by ci.STATUS, ci.MESSAGE
order by count(ci.id) desc
/

SELECT count(id), sysdate
from STD_REGISTRATION_INFO
where STD_CRVS_ID is not null
/
SELECT STATUS, MESSAGE, count(ID)
from CRVS_IDS
group by STATUS, MESSAGE
ORDER BY count(ID) DESC
/
SELECT count(ID)
from CRVS_IDS
where CREATED_AT = to_timestamp('2024-06-05', 'YYYY-MM-DD')
/
select eiaj.STATUS, count(ci.id)
from EDU_ID_ALLOCATION_JOB eiaj
         join CRVS_IDS ci on eiaj.ID = ci.JOB_ID
group by eiaj.STATUS
/
select count(ID)
from CRVS_IDS
where STATUS in (0, 2)
   or MESSAGE in (
                  'fullNameEnglish: must not be empty',
                  'fatherNameEnglish: must not be empty',
                  'motherNameEnglish: must not be empty',
                  'fullNameEnglish: must not be empty; fatherNameEnglish: must not be empty',
                  'fatherNameEnglish: must not be empty; fullNameEnglish: must not be empty',
                  'Edu ID sequence not found for the year : 2023',
                  'Edu ID sequence not found for the year : 2022',
                  'Third party module is not accessible. Connection refused from  unknown module',
                  'fullNameEnglish: size must be between 3 and 150',
                  'fatherDeathDate: must be a past date'
    )
/
select count(id), sysdate from CRVS_IDS where STATUS = 0