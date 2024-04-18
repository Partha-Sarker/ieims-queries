select era.id, era.exam_role, era.code, tp.teacher_name, era.appointment_status
from examiner_assignment.exam_role_assignment era
join examiner_assignment.teacher_profile tp on era.teacher_profile_id = tp.id
where era.subject_paper_code = '110' and era.appointment_status = 'FINALIZED'


select exam_role_assignment_id, exam_paper_id, distributed_on, era.code, tp.teacher_name, era.appointment_status, sd.no_of_scripts_distributed, era.first_meeting_attendance_status, era.second_meeting_attendance_status, sd.no_of_scripts_distributed
from examiner_assignment.script_distribution sd
         join examiner_assignment.exam_role_assignment era on sd.exam_role_assignment_id = era.id
join examiner_assignment.teacher_profile tp on era.teacher_profile_id = tp.id
where era.subject_paper_code = '110' and era.appointment_status IN ('CONFIRMED', 'FINALIZED') order by era.code

