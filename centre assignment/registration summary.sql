declare @examId int = (select id
                       from centre_assign.exam
                       where exam_level_code = 'HSC_OR_EQUIVALENT'
                       order by year desc
                       offset 0 rows fetch next 1 rows only)
declare @maxId  int = (select max(id)
                       from centre_assign.registration_summary)

insert into centre_assign.registration_summary
(id, exam_id, eiin, curriculum_version_code, curriculum_version_name,
 curriculum_group_code, curriculum_group_name, gender, count,
 revision, created_at, created_by)
select @maxId + ROW_NUMBER() OVER (ORDER BY (SELECT 1)),
       @examId,
       r.eiin,
       r.version_code,
       cv.name,
       r.group_code,
       cg.name,
       s.gender,
       count(r.id),
       0,
       getdate(),
       1
from deb.boardreg.registration r
         inner join deb.boardreg.student s on r.student_id = s.id
         inner join [global].masterdata.curriculum_version cv on r.version_code = cv.code
         inner join [global].masterdata.curriculum_group cg on r.group_code = cg.code
where r.session_code = 'HSC_2022_2023'
group by r.eiin, r.version_code, cv.name, r.group_code, cg.name, s.gender
order by r.eiin, r.version_code, cv.name, r.group_code, cg.name, s.gender