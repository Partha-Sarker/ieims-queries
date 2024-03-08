DECLARE @SameDayDistribution
    TABLE
    (
        exam_role_assignment_id int,
        distributed_on          date,
        exam_paper_id           int,
        first_distribution_id   int,
        total_scripts           int
    );

insert into @SameDayDistribution
select exam_role_assignment_id, distributed_on, exam_paper_id, min(id), sum(no_of_scripts_distributed)
from examiner_assignment.script_distribution sd
group by exam_role_assignment_id, distributed_on, exam_paper_id
having count(*) > 1;

DECLARE db_cursor CURSOR FOR SELECT exam_role_assignment_id,
                                    distributed_on,
                                    exam_paper_id,
                                    first_distribution_id,
                                    total_scripts
                             FROM @SameDayDistribution;

OPEN db_cursor;

declare @ExamRoleAssignmentId int;
declare @DistributedOn date;
declare @ExamPaperId int;
declare @FirstDistributionId int;
declare @TotalScripts int;

FETCH NEXT FROM db_cursor INTO @ExamRoleAssignmentId, @DistributedOn, @ExamPaperId, @FirstDistributionId, @TotalScripts;

WHILE @@FETCH_STATUS = 0
    BEGIN
        update examiner_assignment.script_distribution_log
        set script_distribution_id = @FirstDistributionId
        from examiner_assignment.script_distribution_log sdl
                 join examiner_assignment.script_distribution sd on sd.id = sdl.script_distribution_id
        where sd.exam_role_assignment_id = @ExamRoleAssignmentId
          and sd.distributed_on = @DistributedOn
          and sd.exam_paper_id = @ExamPaperId

        delete
        from examiner_assignment.script_distribution
        where exam_role_assignment_id = @ExamRoleAssignmentId
          and distributed_on = @DistributedOn
          and exam_paper_id = @ExamPaperId
          and id != @FirstDistributionId

        update examiner_assignment.script_distribution set no_of_scripts_distributed = @TotalScripts where id = @FirstDistributionId

        FETCH NEXT FROM db_cursor INTO @ExamRoleAssignmentId, @DistributedOn, @ExamPaperId, @FirstDistributionId, @TotalScripts;
    END