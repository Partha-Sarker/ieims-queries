declare @remainingEiins table
                        (
                            eiin varchar(10)
                        )

insert into @remainingEiins(eiin)
    (select distinct rs.eiin
     from centre_assign.registration_summary rs
              left join centre_assign.institute_allocation ia on rs.eiin = ia.eiin and rs.exam_id = ia.exam_id
     where rs.exam_id = 1053
       and ia.id is null)

select *
from @remainingEiins

declare @maxInstituteAllocationId int = (select max(id)
                                         from centre_assign.institute_allocation)

insert into centre_assign.institute_allocation
(id, exam_id, institute_name, eiin, number_of_students, is_govt, is_cadet, revision, created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @maxInstituteAllocationId,
       1053,
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
where rs.eiin in (select eiin from @remainingEiins)
group by rs.eiin, i.name, i.is_govt, i.is_cadet


select ia.id, a.id
from centre_assign.institute_allocation ia
         left join centre_assign.assignment a on ia.id = a.institute_allocation_id
where ia.exam_id = 1053

declare @remainingEiins table
                        (
                            eiin varchar(10)
                        )
insert into @remainingEiins (eiin)
values ('108465'),
       ('107868'),
       ('108062'),
       ('108975'),
       ('108221'),
       ('108198'),
       ('133995'),
       ('135273'),
       ('135631'),
       ('108060')

select * from skeleton.[cas-deb].
