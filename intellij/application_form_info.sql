select distinct e.id
from application_form af
         join employee e
              on af.approver_id = e.post_id or af.recipient_id = e.post_id

select af.id,
       fee,
       applicant_group,
       af.name,
       recipient.id,
       approver.id,
       recipient.user_id,
       approver.user_id,
       e_nothi_required
from application_form af
         join employee recipient on af.recipient_id = recipient.post_id
         join employee approver on af.approver_id = approver.post_id
where e_nothi_required = 1

select distinct recipient.user_id,
                approver.user_id
from application_form af
         join employee recipient on af.recipient_id = recipient.post_id
         join employee approver on af.approver_id = approver.post_id

update application_form
set recipient_id = 1,
    approver_id  = 3
where approver_id = recipient_id
   or recipient_id = 2
   or approver_id = 2


update employee
set user_id = 301
where user_id = 300
update employee
set user_id = 300
where user_id = 18
update employee
set user_id = 18
where user_id = 301


update application_form
set approver_id = 2
where id in (39, 40)

select e.id, e.name, p.department_id, user_id
from employee e
         join post p on e.post_id = p.id
where user_id in (5, 13, 18)    