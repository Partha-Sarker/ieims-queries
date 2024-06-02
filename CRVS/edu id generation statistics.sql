select count(id), sysdate
from CRVS_IDS
where STATUS != 0
/

select eiaj.ID, count(ci.id)
from EDU_ID_ALLOCATION_JOB eiaj
         join CRVS_IDS ci on eiaj.ID = ci.JOB_ID
where eiaj.STATUS = 'PENDING'
and ci.STATUS != 0
group by eiaj.ID
/

SELECT count(id), sysdate from STD_REGISTRATION_INFO where STD_CRVS_ID is not null
