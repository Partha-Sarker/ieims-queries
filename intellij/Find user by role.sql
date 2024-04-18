select au.id, au.username, au.board_code, ar.role_name, ut.name
from auth.application_role ar
         join auth.user_role ur on ur.application_role_id = ar.id
         join auth.application_user au on ur.application_user_id = au.id
        join auth.user_type ut on au.user_type_id = ut.id
where ar.role_name like '%BOARD_OFFICIAL%' and au.board_code = 'DEB'

select au.id, au.username, au.board_code, ar.role_name, ar.id as role_id
from application_role ar
         join user_role ur on ur.application_role_id = ar.id
         join application_user au on ur.application_user_id = au.id
where au.board_code like 'MEB'
