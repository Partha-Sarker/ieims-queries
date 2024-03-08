declare @subjectPaperCode varchar(max) = '108'
declare @maxSlot1Code     varchar(max) = '2600'

declare @slot2HeadExaminer int =
    (select count(distinct era.code)
     from deb.examiner_assignment.exam_role_assignment era
              join deb.examiner_assignment.exam_role_assignment_assignees eraa
                   on era.id = eraa.head_examiner_id
              join deb.examiner_assignment.exam_role_assignment era2
                   on eraa.assignee_id = era2.id
     where era.exam_role = 'HEAD_EXAMINER'
       and era.second_meeting_attendance_status = 'PRESENT'
       and era.subject_paper_code = @subjectPaperCode
       and era2.code > @maxSlot1Code)

declare @slot2ReceivedHeadExaminer int =
    (select count(distinct sd.exam_role_assignment_id)
     from deb.examiner_assignment.exam_role_assignment era
              join deb.examiner_assignment.exam_role_assignment_assignees eraa
                   on era.id = eraa.head_examiner_id
              join deb.examiner_assignment.exam_role_assignment era2
                   on eraa.assignee_id = era2.id
              join examiner_assignment.script_distribution sd
                   on sd.exam_role_assignment_id = era.id and
                      convert(DATE, getdate()) = sd.distributed_on
     where era.exam_role = 'HEAD_EXAMINER'
       and era.second_meeting_attendance_status = 'PRESENT'
       and era.subject_paper_code = @subjectPaperCode
       and era2.code > @maxSlot1Code)

declare @slot2ExaminerCount int =
    (select count(era.id)
     from examiner_assignment.exam_role_assignment era
     where era.subject_paper_code = @subjectPaperCode
       and era.second_meeting_attendance_status = 'PRESENT'
       and era.code > @maxSlot1Code
       and era.exam_role = 'EXAMINER')

declare @slot1ExaminerCount int =
    (select count(era.id)
     from examiner_assignment.exam_role_assignment era
     where era.subject_paper_code = @subjectPaperCode
       and era.second_meeting_attendance_status = 'PRESENT'
       and era.code <= @maxSlot1Code
       and era.exam_role = 'EXAMINER')

declare @slot2ReceivedExaminer int =
    (select count(era.id)
     from examiner_assignment.exam_role_assignment era
              join examiner_assignment.script_distribution sd
                   on sd.exam_role_assignment_id = era.id and
                      convert(DATE, getdate()) = sd.distributed_on
     where era.subject_paper_code = @subjectPaperCode
       and era.second_meeting_attendance_status = 'PRESENT'
       and era.code > @maxSlot1Code
       and era.exam_role = 'EXAMINER')

declare @slot1HeadExaminer int =
    (select count(id) - @slot2HeadExaminer
     from examiner_assignment.exam_role_assignment era
     where exam_role = 'HEAD_EXAMINER'
       and subject_paper_code = @subjectPaperCode
       and second_meeting_attendance_status = 'PRESENT')

select @slot1HeadExaminer + @slot2HeadExaminer   head_examiner,
       @slot1ExaminerCount + @slot2ExaminerCount examiner,
       @slot2HeadExaminer                        slot_2_head_examiner,
       @slot2ExaminerCount                       slot_2_examiner,
       @slot2ReceivedHeadExaminer                slot_2_received_head_examiner,
       @slot2ReceivedExaminer                    slot_2_received_examiner,
       @slot1HeadExaminer                        slot_1_head_examiner,
       @slot1ExaminerCount                       slot_1_examiner