DECLARE @exam_id int = 1001
DECLARE @offset  int = 153

-- Exam Centre
insert into centre_assign.exam_centre
(id,
 eiin,
 name,
 centre_code,
 approved_by,
 approval_date,
 status,
 thana_code,
 district_code,
 institute_name,
 revision,
 created_at,
 created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + 1000,
       cs.EIIN,
       cs.CENTRE,
       C_CODE,
       1,
       GETDATE(),
       'USABLE',
       gt.code,
       gd.code,
       i.name,
       0,
       GETDATE(),
       1
from skeleton.[seb-cas].cent_ssc cs
         join global.masterdata.institute i on i.eiin = cs.EIIN
         join global.masterdata.geo_thana gt on i.thana_id = gt.id
         join global.masterdata.geo_district gd on gt.geo_district_id = gd.id

-- Secretary and substitute secretary

insert into centre_assign.secretary
(id, name, phone_number, email, designation, revision, created_at, created_by)
select ec.id,
       'Headmaster',
       '01717777777',
       'headmaster@dsi.com',
       'Headmaster',
       0,
       '2022-10-19',
       0
from centre_assign.exam_centre ec
where ec.eiin != 'default'

insert into centre_assign.secretary
(id, name, phone_number, email, designation, revision, created_at, created_by)
select id + @offset,
       'Asst. Headmaster',
       '01717777778',
       'asstheadmaster@dsi.com',
       'Asst. Headmaster',
       0,
       '2022-10-19',
       0
from centre_assign.exam_centre ec
where ec.eiin != 'default'

update centre_assign.exam_centre
set secretary_id            = id,
    substitute_secretary_id = id + @offset
where exam_centre.eiin != 'default'

-- Centre version

insert into centre_assign.centre_version(id, code, name, exam_centre_id, serial, revision, created_at, created_by)
select id,
       'BANGLA',
       'Bangla',
       id,
       2,
       0,
       '2023-03-03',
       1
from centre_assign.exam_centre
where exam_centre.eiin != 'default'

insert into centre_assign.centre_version(id, code, name, exam_centre_id, serial, revision, created_at, created_by)
select id + @offset,
       'ENGLISH',
       'English',
       id,
       2,
       0,
       '2023-03-03',
       1
from centre_assign.exam_centre
where exam_centre.eiin != 'default'

-- Centre exam level

insert into centre_assign.centre_exam_level
(id, exam_level_code, name, seating_capacity, valid_from,
 serial, revision, created_at, created_by)
select id,
       'SSC_OR_EQUIVALENT',
       'SSC or Equivalent',
       1000,
       2010,
       2,
       0,
       '2023-03-03',
       1
from centre_assign.exam_centre
where exam_centre.eiin != 'default'

update centre_assign.exam_centre
set centre_exam_level_id = exam_centre.id
where exam_centre.eiin != 'default'

-- Centre lab

insert into centre_assign.centre_lab(id, group_code, group_name, centre_exam_level_id, serial, revision, created_at,
                                     created_by)
select id,
       'SSC_SCIENCE',
       'Science',
       id,
       2,
       0,
       '2023-03-03',
       1
from centre_assign.centre_exam_level


insert into centre_assign.centre_lab(id, group_code, group_name, centre_exam_level_id, serial, revision, created_at,
                                     created_by)
select id + @offset,
       'SSC_HUMANITIES',
       'Humanities',
       id,
       3,
       0,
       '2023-03-03',
       1
from centre_assign.centre_exam_level


insert into centre_assign.centre_lab(id, group_code, group_name, centre_exam_level_id, serial, revision, created_at,
                                     created_by)
select id + @offset + @offset,
       'SSC_BUSINESS_STUDIES',
       'Business Studies',
       id,
       4,
       0,
       '2023-03-03',
       1
from centre_assign.centre_exam_level

-- Centre attachment

insert into centre_assign.centre_attachment(id, file_id, exam_centre_id, revision, created_at, created_by)
select id,
       'test',
       id,
       0,
       '2023-03-03',
       1
from centre_assign.exam_centre
where exam_centre.eiin != 'default'

-- Exam centre allocation

insert into centre_assign.exam_centre_allocation(id, exam_id, exam_centre_id, revision, created_at, created_by)
select id,
       @exam_id,
       id,
       0,
       '2023-03-03',
       1
from centre_assign.exam_centre
where exam_centre.eiin != 'default'

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
from skeleton.[seb-cas].sylhet_school ss
         join centre_assign.exam_centre ec on ec.centre_code = ss.C_CODE
         join centre_assign.institute_allocation ia on ia.eiin = ss.EIIN
         join centre_assign.exam_centre_allocation eca on ec.id = eca.exam_centre_id