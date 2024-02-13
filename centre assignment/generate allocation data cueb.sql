-- Institute allocation

insert into centre_assign.institute_allocation
(id, exam_id, institute_name, eiin, number_of_students, is_govt, is_cadet, revision, created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + 1000,
       1001,
       i.name,
       rs.eiin,
       sum(rs.count),
       i.is_cadet,
       is_govt,
       0,
       GETDATE(),
       1
from centre_assign.registration_summary rs
         join global.masterdata.institute i on i.eiin = rs.eiin
group by rs.eiin, i.name, i.is_govt, i.is_cadet

--  Allocation

insert into centre_assign.assignment
(id, institute_allocation_id, exam_centre_allocation_id, practical_centre_allocation_id, number_of_students, revision,
 created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + 1000,
       ia.id,
       eca.id as centre_id,
       eca.id as practical_centre_id,
       ia.number_of_students,
       0,
       GETDATE(),
       1
from skeleton.[cueb-cas].SSC_INST ss
         join centre_assign.exam_centre ec on ec.centre_code = ss.C_CODE
         join centre_assign.institute_allocation ia on ia.eiin = ss.EIIN
         join centre_assign.exam_centre_allocation eca on ec.id = eca.exam_centre_id


select EIIN, count(*) from skeleton.[cueb-cas].SSC_INST ss group by EIIN having count(*) > 1