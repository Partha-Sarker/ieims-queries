Select MESSAGE, count(MESSAGE)
from ARC_ORG_VERIFICATIONS
WHERE CREATED_AT >= to_timestamp('2024-05-25', 'YYYY-MM-DD')
-- AND MESSAGE not like '%app - Connection is not%' and MESSAGE not like '%Violation of PRIMARY KEY constraint%'
group by MESSAGE
ORDER BY count(MESSAGE) DESC
/

Select count(id)
from ARC_ORG_VERIFICATIONS
WHERE CREATED_AT >= to_timestamp('2024-05-25', 'YYYY-MM-DD')
  and CREATED_AT < to_timestamp('2024-05-26', 'YYYY-MM-DD')
and MESSAGE = 'OK'
/

Select count(id)
from ARC_ORG_VERIFICATIONS
WHERE CREATED_AT >= to_timestamp('2024-05-26', 'YYYY-MM-DD')
and MESSAGE = 'OK'