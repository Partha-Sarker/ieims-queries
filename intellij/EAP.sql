update exam_role_assignment
set first_meeting_attendance_status = 'PRESENT',
    appointment_status              = 'CONFIRMED'
where exam_role = 'HEAD_EXAMINER'


select sd.*
from schedule s
         join schedule_detail sd on s.id = sd.schedule_id
         join exam_paper ep on ep.exam_code = s.exam_code and ep.subject_paper_code = sd.subject_paper_code
where ep.id = 1000

select exam_role, first_meeting_attendance_status, count(*)
from exam_role_assignment era
group by exam_role, first_meeting_attendance_status

select era.*
from exam_role_assignment era
         join exam_paper ep
              on ep.subject_paper_code = era.subject_paper_code
                     and (ep.version_code is null and era.version_code is null) or
                 (ep.version_code = era.version_code)
                     and ep.exam_code = era.exam_code
where ep.id = 1002

update exam_role_assignment
set appointment_status              = 'FINALIZED',
    first_meeting_attendance_status = null
from exam_role_assignment era
         join exam_paper ep
              on ep.subject_paper_code = era.subject_paper_code
                     and (ep.version_code is null and era.version_code is null) or
                 (ep.version_code = era.version_code)
                     and ep.exam_code = era.exam_code
where ep.id = 1002


select * from examiner_script_quota esq where CONVERT(DATE, esq.applied_on) = CONVERT(DATE, GETDATE())

select GETDATE()
