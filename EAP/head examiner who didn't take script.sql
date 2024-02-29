declare @subjectPaperCode int = '107'

select era.code, tp.teacher_name, tp.mobile_number
from examiner_assignment.exam_role_assignment era
         left join examiner_assignment.script_distribution sd
                   on era.id = sd.exam_role_assignment_id and sd.distributed_on = convert(date, getdate())
join examiner_assignment.teacher_profile tp on era.teacher_profile_id = tp.id
where era.subject_paper_code = '107'
  and era.second_meeting_attendance_status = 'PRESENT'
  and era.exam_role = 'HEAD_EXAMINER'
and sd.id is null