delete from assignment where institute_allocation_id in (select id from institute_allocation where exam_id = :examId)
delete from institute_allocation where exam_id = :examId
delete from registration_summary where exam_id = :examId
delete from exam_centre_allocation where exam_id = :examId
delete from exam where id = :examId