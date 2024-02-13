DECLARE @max_assignment_id INT = (SELECT MAX(id) FROM centre_assign.assignment) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE assignment_seq RESTART WITH ' + CAST(@max_assignment_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_centre_attachment_id INT = (SELECT MAX(id) FROM centre_assign.centre_attachment) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE centre_attachment_seq RESTART WITH ' + CAST(@max_centre_attachment_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_centre_exam_level_id INT = (SELECT MAX(id) FROM centre_assign.centre_exam_level) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE centre_exam_level_seq RESTART WITH ' + CAST(@max_centre_exam_level_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_centre_lab_id INT = (SELECT MAX(id) FROM centre_assign.centre_lab) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE centre_lab_seq RESTART WITH ' + CAST(@max_centre_lab_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_centre_status_history_id INT = (SELECT MAX(id) FROM centre_assign.centre_status_history) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE centre_status_history_seq RESTART WITH ' + CAST(@max_centre_status_history_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_centre_venue_history_id INT = (SELECT MAX(id) FROM centre_assign.centre_venue_history) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE centre_venue_history_seq RESTART WITH ' + CAST(@max_centre_venue_history_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_centre_version_id INT = (SELECT MAX(id) FROM centre_assign.centre_version) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE centre_version_seq RESTART WITH ' + CAST(@max_centre_version_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_exam_centre_id INT = (SELECT MAX(id) FROM centre_assign.exam_centre) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE exam_centre_seq RESTART WITH ' + CAST(@max_exam_centre_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


DECLARE @max_table_name_id INT = (SELECT MAX(id) FROM centre_assign.table_name) + 100;
DECLARE @sql NVARCHAR(MAX);
SET @sql = 'ALTER SEQUENCE table_name_seq RESTART WITH ' + CAST(@max_table_name_id AS NVARCHAR(MAX));
EXEC sp_executesql @sql;


