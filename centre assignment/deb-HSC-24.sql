-- Cleanup existing data if exists
-- declare @examId int = desired_exam_id;

delete
from centre_assign.assignment
where institute_allocation_id in (select id from centre_assign.institute_allocation where exam_id = @examId)
delete
from centre_assign.institute_allocation
where exam_id = @examId
delete
from centre_assign.registration_summary
where exam_id = @examId
delete
from centre_assign.exam_centre_allocation
where exam_id = @examId
delete
from centre_assign.exam
where id = @examId

delete
from centre_assign.centre_version
where exam_centre_id in (select ec.id
                         from centre_assign.exam_centre ec
                                  join centre_assign.centre_exam_level cel
                                       on ec.centre_exam_level_id = cel.id and
                                          cel.exam_level_code = 'HSC_OR_EQUIVALENT')

delete
from centre_assign.centre_attachment
where exam_centre_id in (select ec.id
                         from centre_assign.exam_centre ec
                                  join centre_assign.centre_exam_level cel
                                       on ec.centre_exam_level_id = cel.id and
                                          cel.exam_level_code = 'HSC_OR_EQUIVALENT')

delete
from centre_assign.exam_centre
where id in
      (select ec.id
       from centre_assign.exam_centre ec
                join centre_assign.centre_exam_level cel
                     on ec.centre_exam_level_id = cel.id and cel.exam_level_code = 'HSC_OR_EQUIVALENT')


delete
from centre_assign.secretary
where id not in (select secretary_id from centre_assign.exam_centre)
  and id not in (select substitute_secretary_id from centre_assign.exam_centre)

delete
from centre_assign.centre_lab
where
    centre_exam_level_id in (select id from centre_assign.centre_exam_level where exam_level_code = 'HSC_OR_EQUIVALENT')

delete
from centre_assign.centre_exam_level
where exam_level_code = 'HSC_OR_EQUIVALENT'


-- Insert centre exam level

declare @maxCentreExamLevelId int = (select max(id)
                                     from deb.centre_assign.centre_exam_level);

insert into centre_assign.centre_exam_level
(id, exam_level_code, name, seating_capacity, valid_from, serial, revision, created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @maxCentreExamLevelId,
       'HSC_OR_EQUIVALENT',
       'HSC or Equivalent',
       1000,
       2000,
       1,
       0,
       GETDATE(),
       1
from skeleton.[cas-deb-24].HSCCEN24 cs


-- Insert secretary
declare @maxSecretaryId int = (select max(id)
                               from deb.centre_assign.secretary);

insert into centre_assign.secretary
    (id, name, phone_number, revision, created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @maxSecretaryId,
       'Secretary',
       '01700000000',
       0,
       GETDATE(),
       1
from skeleton.[cas-deb-24].HSCCEN24 cs

-- Insert substitute secretary
declare @maxSecretaryId int = (select max(id)
                               from deb.centre_assign.secretary);

insert into centre_assign.secretary
    (id, name, phone_number, revision, created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @maxSecretaryId,
       'Substitute Secretary',
       '01700000000',
       0,
       GETDATE(),
       1
from skeleton.[cas-deb-24].HSCCEN24 cs

-- Insert exam centre

declare @maxCentreId          int = (select max(id)
                                     from deb.centre_assign.exam_centre)
declare @minCentreExamLevelId int = (select min(id)
                                     from deb.centre_assign.centre_exam_level
                                     where exam_level_code = 'HSC_OR_EQUIVALENT');
declare @minSecretaryId int = (select min(s.id)
                               from deb.centre_assign.secretary s
                                        left join centre_assign.exam_centre ec
                                                  on ec.secretary_id = s.id or ec.substitute_secretary_id = s.id
                               where s.name = 'Secretary'
                                 and ec.id is null);

declare @minSubstituteSecretaryId int = (select min(s.id)
                                         from deb.centre_assign.secretary s
                                                  left join centre_assign.exam_centre ec
                                                            on ec.secretary_id = s.id or ec.substitute_secretary_id = s.id
                                         where s.name = 'Substitute Secretary'
                                           and ec.id is null);

insert into deb.centre_assign.exam_centre
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
 centre_exam_level_id,
 secretary_id,
 substitute_secretary_id,
 revision,
 created_at,
 created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @maxCentreId,
       cs.EIIN,
       cs.CENTRE,
       C_CODE,
       1,
       GETDATE(),
       'USABLE',
       gt.code,
       gd.code,
       i.name,
       ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @minCentreExamLevelId - 1,
       ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @minSecretaryId - 1,
       ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @minSubstituteSecretaryId - 1,
       0,
       GETDATE(),
       1
from skeleton.[cas-deb-24].HSCCEN24 cs
         JOIN global.masterdata.institute i on i.eiin = cs.EIIN
         join global.masterdata.geo_thana gt on i.thana_id = gt.id
         join global.masterdata.geo_district gd on gt.geo_district_id = gd.id

-- Insert centre Bangla version
declare @maxCentreVersionId int = (select max(id)
                                   from deb.centre_assign.centre_version)

insert into centre_assign.centre_version(id, code, name, exam_centre_id, serial, revision, created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @maxCentreVersionId,
       'BANGLA',
       'Bangla',
       ec.id,
       1,
       0,
       getdate(),
       1
from skeleton.[cas-deb-24].HSCCEN24 cs
         join centre_assign.exam_centre ec on cs.C_CODE = ec.centre_code
         join centre_assign.centre_exam_level cel on ec.centre_exam_level_id = cel.id
where cel.exam_level_code = 'HSC_OR_EQUIVALENT'

-- Insert centre English version
declare @maxCentreVersionId int = (select max(id)
                                   from deb.centre_assign.centre_version)

insert into centre_assign.centre_version(id, code, name, exam_centre_id, serial, revision, created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT 1)) + @maxCentreVersionId,
       'ENGLISH',
       'English',
       ec.id,
       2,
       0,
       getdate(),
       1
from skeleton.[cas-deb-24].HSCCEN24 cs
         join centre_assign.exam_centre ec on cs.C_CODE = ec.centre_code
         join centre_assign.centre_exam_level cel on ec.centre_exam_level_id = cel.id
where cel.exam_level_code = 'HSC_OR_EQUIVALENT'


-- Insert centre labs
DECLARE @completedCount INT = 0;
DECLARE @totalCount INT = (select COUNT(1)
                           FROM centre_assign.centre_exam_level
                           WHERE exam_level_code = 'HSC_OR_EQUIVALENT');
DECLARE @centreExamLevelId INT;

DECLARE centreExamLevelCursor CURSOR FOR
    SELECT id
    FROM centre_assign.centre_exam_level
    WHERE exam_level_code = 'HSC_OR_EQUIVALENT';

OPEN centreExamLevelCursor;
FETCH NEXT FROM centreExamLevelCursor INTO @centreExamLevelId;

WHILE @@FETCH_STATUS = 0
    BEGIN
        DECLARE @maxCentreLabId INT;

        SELECT @maxCentreLabId = MAX(id)
        FROM centre_assign.centre_lab;

        INSERT INTO centre_assign.centre_lab(id, group_code, group_name, centre_exam_level_id, serial, revision,
                                             created_at, created_by)
        SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + @maxCentreLabId,
               cg.code,
               cg.name,
               @centreExamLevelId,
               cg.serial,
               0,
               GETDATE(),
               1
        FROM global.masterdata.curriculum_group cg
                 JOIN global.masterdata.exam_type et ON et.id = cg.exam_type_id
        WHERE et.code = 'HSC';

        SET @completedCount = @completedCount + 1;
        PRINT 'Completed ' + CAST(@completedCount AS VARCHAR(10)) + ' out of ' + CAST(@totalCount AS VARCHAR(10));

        FETCH NEXT FROM centreExamLevelCursor INTO @centreExamLevelId;
    END;

CLOSE centreExamLevelCursor;
DEALLOCATE centreExamLevelCursor;

-- Insert Registration summary, exam centre allocation and institute allocation

-- Create an exam in the exam table
-- Initiate/re initiate allocation process for this exam from the UI

-- Insert assignment for fully assigned institutes
declare @examId int = 1001;
declare @maxAssignmentId int = (select max(id)
                                from centre_assign.assignment)

insert into centre_assign.assignment (id, institute_allocation_id,
                                      exam_centre_allocation_id, practical_centre_allocation_id, number_of_students,
                                      revision, created_at, created_by)
select ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) + @maxAssignmentId,
       ia.id,
       eca.id,
       eca.id,
       ia.number_of_students,
       0,
       getdate(),
       1
from (select EIIN, STRING_AGG(C_CODE, '') as centre_code
      from skeleton.[cas-deb-24].HSCCOL24
      group by EIIN
      having count(distinct C_CODE) = 1) allocation
         join centre_assign.institute_allocation ia
              on allocation.EIIN = ia.eiin and ia.exam_id = @examId
         join centre_assign.exam_centre ec on ec.centre_code = allocation.centre_code
         join centre_assign.exam_centre_allocation eca on ec.id = eca.exam_centre_id and eca.exam_id = @examId
