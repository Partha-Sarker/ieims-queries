select ia.eiin, std.code, ec.centre_code
from assignment a
         join institute_allocation ia on a.institute_allocation_id = ia.id
         join exam e on ia.exam_id = e.id
         join exam_centre_allocation eca on a.exam_centre_allocation_id = eca.id
         join exam_centre ec on eca.exam_centre_id = ec.id
         left join separation_type_detail std on a.separation_type_detail_id = std.id
where e.exam_level_code = 'SSC_OR_EQUIVALENT'
  and e.year = 2020

select count(eca.id)
from exam_centre_allocation eca
         join assignment a on eca.id = a.exam_centre_allocation_id
         join exam_centre ec on eca.exam_centre_id = ec.id
         join centre_exam_level cel on ec.centre_exam_level_id = cel.id
group by eca.id, cel.seating_capacity
