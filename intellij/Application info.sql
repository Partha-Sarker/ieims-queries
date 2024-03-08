select a.id as                id,
       applicant_id,
       a.overall_status       status,
       application_form_id,
       afc.name               application_name,
       receiver_post.name     first_receiver_post,
       approver_post.name     final_approver_post,
       receiver_employee.name first_receiver_name,
       approver_employee.name final_approver_name
from application a
         join application_form af on a.application_form_id = af.id
         join application_form_config afc on af.application_form_config_id = afc.id
         left join post approver_post on af.approver_id = approver_post.id
         left join post receiver_post on af.recipient_id = receiver_post.id
         left join employee approver_employee on approver_post.id = approver_employee.post_id
         left join employee receiver_employee on receiver_post.id = receiver_employee.post_id

select af.id,
       af.fee                 fee,
       afc.name               application_name,
       receiver_post.name     first_receiver_post,
       approver_post.name     final_approver_post,
       receiver_employee.name first_receiver_name,
       approver_employee.name final_approver_name
from application_form af
         join application_form_config afc on af.application_form_config_id = afc.id
         left join post approver_post on af.approver_id = approver_post.id
         left join post receiver_post on af.recipient_id = receiver_post.id
         left join employee approver_employee on approver_post.id = approver_employee.post_id
         left join employee receiver_employee on receiver_post.id = receiver_employee.post_id
where afc.applicant_group = 'PUBLIC'