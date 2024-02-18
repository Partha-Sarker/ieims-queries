declare @examCentreAllocationId int =
(select id
from centre_assign.exam_centre_allocation
where exam_id = :examId and exam_centre_id = :examCentreId)

delete from centre_assign.assignment where exam_centre_allocation_id = @examCentreAllocationId

delete from centre_assign.exam_centre_allocation where id = @examCentreAllocationId

delete
from centre_assign.centre_version
where exam_centre_id = :examCentreId
delete
from centre_assign.centre_attachment
where exam_centre_id = :examCentreId

delete
from centre_assign.exam_centre
where id = :examCentreId

delete
from centre_assign.centre_exam_level
where id not in (select centre_exam_level_id from centre_assign.exam_centre)

delete
from centre_assign.secretary
where id not in (select secretary_id from centre_assign.exam_centre)

delete
from centre_assign.secretary
where id not in (select substitute_secretary_id from centre_assign.exam_centre)



