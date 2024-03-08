update application_form
set fee          = 0,
    recipient_id = 1,
    approver_id  = 4
where id = 31
   or name = N'উচ্চমাধ্যমিক এডহক কমিটি অনুমোদন প্রসঙ্গে'

update application_form
set fee          = 0,
    recipient_id = 4,
    approver_id  = 1
where id = 32
   or name = N'উচ্চমাধ্যমিক পর্যায়ে স্বীকৃতি নবায়নের'

update application_form
set fee           = 0,
    recipient_id  = 1,
    approver_id   = 4
where id = 34
   or name = N'উচ্চমাধ্যমিক পর্যায়ের গভার্ণিং বডি অনুমোদন'

update employee
set name = 'Syed Mhamudul Hasan'
where user_id = 5

update employee
set name = 'Tasfik Rahman'
where user_id = 18

select e.id as employee_id, e.name, e.user_id, post_id, p.name post_name, d.name department_name
from employee e
         join post p on e.post_id = p.id
         join department d on p.department_id = d.id
where user_id in (5, 18)

update application_form set fee = 0