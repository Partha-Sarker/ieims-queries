select teacher_code, exam_role
from examiner_assignment.exam_role_assignment era
         join examiner_assignment.teacher_profile tp on era.teacher_profile_id = tp.id
where appointment_status in ('CONFIRMED', 'FINALIZED')
  and exam_role IN ('EXAMINER', 'HEAD_EXAMINER')
--   and teacher_code IN (
--                        '0000001082',
--                        '0000018256',
--                        '0000019063',
--                        '0000043277',
--                        '0000044983',
--                        '0000079394'
--     )
-- and teacher_code = '0000001082'
group by teacher_code, exam_role having count(era.id) > 1