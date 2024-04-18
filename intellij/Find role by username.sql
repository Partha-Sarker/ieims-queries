select au.id, au.username, ar.role_name
from auth.application_user au
         join auth.USER_ROLE UR on au.id = UR.application_user_id
         join auth.application_role ar on UR.application_role_id = ar.id
where username like '%ssa@dhakaeducationboard.gov.bd%'
