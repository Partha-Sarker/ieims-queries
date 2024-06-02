select count(id)
from STD_REGISTRATION_INFO
WHERE CREATED_AT >= to_timestamp('2024-05-25', 'YYYY-MM-DD')
  and CREATED_AT < to_timestamp('2024-05-26', 'YYYY-MM-DD')
/

select count(id)
from STD_REGISTRATION_INFO
WHERE CREATED_AT >= to_timestamp('2024-05-26', 'YYYY-MM-DD')