update centre_assign.secretary
set name         = au.name,
    phone_number = au.mobile,
    email        = au.email,
    designation  = au.designation
from centre_assign.secretary s
         JOIN centre_assign.exam_centre ec on s.id = ec.secretary_id
         join centre_assign.centre_exam_level cel
              on ec.centre_exam_level_id = cel.id and cel.exam_level_code like '%SSC%'
         join global.auth.application_user au on au.eiin = ec.eiin
         join global.auth.user_role ur on ur.application_user_id = au.id and ur.application_role_id = 15


select name         = au.name,
    phone_number = au.mobile,
    email        = au.email,
    designation  = au.designation
from centre_assign.secretary s
         JOIN centre_assign.exam_centre ec on s.id = ec.secretary_id
         join centre_assign.centre_exam_level cel
              on ec.centre_exam_level_id = cel.id and cel.exam_level_code like '%SSC%'
         join global.auth.application_user au on au.eiin = ec.eiin
         join global.auth.user_role ur on ur.application_user_id = au.id and ur.application_role_id = 15