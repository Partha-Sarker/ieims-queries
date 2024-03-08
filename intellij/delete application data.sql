update application_review set parent_id = null where application_id = :applicationId
delete from application_review where application_id = :applicationId
delete from application where id = :applicationId

update application_review set parent_id = null where application_id in :applicationIds
delete from application_review where application_id in :applicationIds
delete from application where id in :applicationIds
