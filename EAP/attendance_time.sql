update examiner_assignment.exam_role_assignment
set first_meeting_attendance_status = s.first_appointment
from examiner_assignment.exam_role_assignment era
         join examiner_assignment.schedule_detail sd on sd.subject_paper_code = era.subject_paper_code
         join examiner_assignment.schedule s on sd.schedule_id = s.id and s.exam_code = era.exam_code
where era.first_meeting_attendance_status = 'PRESENT'


update examiner_assignment.exam_role_assignment
set second_meeting_attendance_status = era.updated_at
from examiner_assignment.exam_role_assignment era
where era.second_meeting_attendance_status = 'PRESENT'