select au.id, au.username, ar.role_name
from application_user au
         join USER_ROLE UR on au.id = UR.application_user_id
         join application_role ar on UR.application_role_id = ar.id
where username like '%ishmum%'
