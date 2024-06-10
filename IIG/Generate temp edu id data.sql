-- CREATE TABLE skeleton.iig.edu_id
-- (
--     year       int,
--     board_code VARCHAR(6),
--     random_id  int
-- );

insert into skeleton.iig.edu_id
select substring(ieims_id, 1, 2) as year,
       substring(ieims_id, 3, 2) as board_code,
       substring(ieims_id, 5, 6) as random_id
from global.iig.student
where substring(ieims_id, 1, 2) >= '14'
  and substring(ieims_id, 1, 2) <= '26'
  and substring(ieims_id, 3, 2) in
      ('30', '40', '20', '10', '14', '16', '21', '11', '12', '13', '15', '17', '18', '19')

select count(id)
from iig.student
where substring(student.registration_no, 1, 1) = '0'
   or substring(student.registration_no, 3, 2) not in
      ('30', '40', '20', '10', '14', '16', '13', '21', '12', '11', '15', '17', '18', '19')

select *
from iig.student
where student.registration_no < '1200000000'
  and registration_no > '1100000000'

truncate table iig.edu_id

select count(*) from iig.edu_id