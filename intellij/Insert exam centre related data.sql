insert into secretary(id, name, name_bn, phone_number, email, designation, revision, created_at, created_by)
select id - 1,
       'Headmaster',
       N'প্রধান শিক্ষক',
       '01717777777',
       'headmaster@dsi.com',
       'Headmaster',
       0,
       '2022-10-19',
       0
from exam_centre
where eiin is not null

insert into secretary(id, name, name_bn, phone_number, email, designation, revision, created_at, created_by)
select id + 437,
       'Asst. Headmaster',
       N'সহকারী প্রধান শিক্ষক',
       '01717777778',
       'asstheadmaster@dsi.com',
       'Asst. Headmaster',
       0,
       '2022-10-19',
       0
from exam_centre
where eiin is not null

update exam_centre
set secretary_id            = id,
    substitute_secretary_id = id + 437
where eiin is not null

insert into centre_version(id, code, name, exam_centre_id, serial, revision, created_at, created_by)
select id - 1,
       'BANGLA',
       'Bangla',
       id,
       2,
       0,
       '2023-03-03',
       1
from exam_centre
where eiin is not null

insert into centre_version(id, code, name, exam_centre_id, serial, revision, created_at, created_by)
select id + 437,
       'ENGLISH',
       'English',
       id,
       2,
       0,
       '2023-03-03',
       1
from exam_centre
where eiin is not null

insert into centre_exam_type(id, exam_type_code, short_name, seating_capacity, exam_centre_id, valid_from,
                             exam_level_serial, revision, created_at, created_by)
select id - 1,
       'SSC',
       'SSC',
       1000,
       id,
       2010,
       2,
       0,
       '2023-03-03',
       1
from exam_centre
where eiin is not null

insert into centre_attachment(id, file_id, exam_centre_id, revision, created_at, created_by)
select id - 1,
       'centreassign/20230517/07863696-3ec2-4e23-9d04-f05a01a37428.pdf',
       id,
       0,
       '2023-03-03',
       1
from exam_centre
where eiin is not null

insert into centre_lab(id, group_code, group_name, centre_exam_type_id, serial, revision, created_at, created_by)
select id,
       'SSC_SCIENCE',
       'Science',
       id,
       2,
       0,
       '2023-03-03',
       1
from centre_exam_type


insert into centre_lab(id, group_code, group_name, centre_exam_type_id, serial, revision, created_at, created_by)
select id + 438,
       'SSC_HUMANITIES',
       'Humanities',
       id,
       3,
       0,
       '2023-03-03',
       1
from centre_exam_type


insert into centre_lab(id, group_code, group_name, centre_exam_type_id, serial, revision, created_at, created_by)
select id + 876,
       'SSC_BUSINESS_STUDIES',
       'Business Studies',
       id,
       4,
       0,
       '2023-03-03',
       1
from centre_exam_type

ALTER SEQUENCE centre_lab_seq RESTART WITH 1400;
