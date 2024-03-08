delete
from user_role
where application_user_id = (select id from application_user where username = :username)
delete
from user_security_question
where application_user_id = (select id from application_user where username = :username)
delete
from application_user
where username = :username