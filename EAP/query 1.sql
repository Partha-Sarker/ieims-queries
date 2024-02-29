select era.exam_role,
       CASE
           WHEN s.last_code_for_slot1 is null or era.code <= s.last_code_for_slot1 THEN 'slot 1'
           ELSE 'slot 2'
           END,
       count(distinct era.id), sum(sdb.no_of_scripts_distributed)
from examiner_assignment.exam_role_assignment era
         join examiner_assignment.schedule_detail sd on sd.subject_paper_code = era.subject_paper_code
         join examiner_assignment.schedule s on sd.schedule_id = s.id
         left join examiner_assignment.script_distribution sdb on era.id = sdb.exam_role_assignment_id
where era.subject_paper_code = '101'
  and era.appointment_status in ('FINALIZED', 'CONFIRMED')
group by era.exam_role,
         CASE
             WHEN s.last_code_for_slot1 is null or era.code <= s.last_code_for_slot1 THEN 'slot 1'
             ELSE 'slot 2'
             END;

