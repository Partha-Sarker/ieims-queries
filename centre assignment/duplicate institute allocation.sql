select ia.eiin, ia.id, count(ia.id), STRING_AGG(CONCAT(exam_centre_allocation_id, '', ''), ', ')
from centre_assign.assignment a
         join centre_assign.institute_allocation ia on a.institute_allocation_id = ia.id
where child_separation_type_id is null
  and parent_id is null
  and exam_centre_allocation_id is not null
  and ia.exam_id = 1053
group by ia.id, ia.eiin
having count(ia.id) > 1


select eca.id, ec.id, ec.centre_code, ec.eiin, ec.name, ec.institute_name, cel.exam_level_code
from centre_assign.exam_centre ec
         join centre_assign.exam_centre_allocation eca on ec.id = eca.exam_centre_id and eca.exam_id = 1053
join centre_assign.centre_exam_level cel on ec.centre_exam_level_id = cel.id
where eca.id in ('18380', '18395')

select ec.id, ec.centre_code, ec.name, ec.eiin, ec.institute_name, cel.exam_level_code
from centre_assign.exam_centre ec
         join centre_assign.centre_exam_level cel on ec.centre_exam_level_id = cel.id
where centre_code = '583'

select eca.id
from centre_assign.exam_centre_allocation eca
         join centre_assign.exam_centre on eca.exam_centre_id = exam_centre.id
where exam_id = 1053 and centre_code = :centreCode