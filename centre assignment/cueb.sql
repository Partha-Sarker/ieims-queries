-- Original data inconsistency

select si.EIIN as institute, si.C_CODE as given_centre, sc.C_CODE as original_centre
from skeleton.[cueb-cas].SSC_INST si
         FULL JOIN skeleton.[cueb-cas].SSC_CENT sc on si.C_CODE = sc.C_CODE
where sc.C_CODE is null


-- Missing exam centre

select c.*
from skeleton.[cueb-cas].SSC_CENT c
         left join cueb.centre_assign.exam_centre ec on ec.centre_code = c.C_CODE
         left join deb.centre_assign.centre_exam_level cel
                   on ec.centre_exam_level_id = cel.id and cel.exam_level_code like '%SSC%'
where ec.centre_code IS NULL


-- Missing institute
select *
from skeleton.[cueb-cas].SSC_INST si
         left JOIN cueb.centre_assign.institute_allocation ia on si.EIIN = ia.eiin
where ia.id is null


select ia.eiin, si.C_CODE
from cueb.centre_assign.institute_allocation ia
         left join cueb.centre_assign.assignment a on a.institute_allocation_id = ia.id
         left join skeleton.[cueb-cas].SSC_INST si on ia.eiin = si.EIIN
where a.id IS NULL