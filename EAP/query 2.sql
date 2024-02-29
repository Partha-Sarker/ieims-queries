
DECLARE @examPaperId INT = 1007; -- replace with actual value
DECLARE @statuses NVARCHAR(MAX) = 'CONFIRMED,FINALIZED'; -- replace with actual values
DECLARE @lastSlot1Code INT = 2600; -- replace with actual value
DECLARE @slotNumber INT = 1; -- replace with actual value
DECLARE @secondMeetingTime DATETIME = '2024-02-28'; -- replace with actual value

-- Your SQL query goes here
SELECT
    era.exam_role AS examRole,
    era.second_meeting_attendance_status AS attendanceStatus,
    COUNT(DISTINCT era.id) AS teacherCount,
    CASE WHEN @slotNumber IS NULL OR @slotNumber = 1 THEN 1 ELSE 2 END AS slot,
    SUM(ISNULL(sd.no_of_scripts_distributed, 0)) AS scriptCount
FROM
    examiner_assignment.exam_role_assignment era
LEFT JOIN
    examiner_assignment.exam_paper ep ON ep.subject_paper_code = era.subject_paper_code
        AND ep.exam_code = era.exam_code
        AND ((ep.version_code IS NULL AND era.version_code IS NULL)
            OR (ep.version_code = era.version_code))
LEFT JOIN
    examiner_assignment.script_distribution sd ON sd.exam_role_assignment_id = era.id AND sd.distributed_on >= @secondMeetingTime
WHERE
    ep.id = @examPaperId
    AND era.appointment_status IN (SELECT value FROM STRING_SPLIT(@statuses, ','))
    AND (
        @lastSlot1Code IS NULL
        OR @slotNumber IS NULL
        OR (
            (@slotNumber = 1 AND (era.code <= @lastSlot1Code OR era.exam_role = 'HEAD_EXAMINER'))
            OR (@slotNumber = 2 AND era.code > @lastSlot1Code)
        )
    )
    AND (sd.id IS NULL OR sd.distributed_on >= @secondMeetingTime)
GROUP BY
    era.exam_role, era.second_meeting_attendance_status;
