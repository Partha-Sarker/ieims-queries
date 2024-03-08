update USERS
set boardCode = 'DEB'
where id in (select distinct u.id
             from USERS u
                      join USER_ROLE ur on u.id = ur.user_id
                      join ROLES r on ur.role_id = r.id
             where r.role_name in ('CENTRE_CREATOR', 'CENTRE_ASSIGNER')
                or u.username like '%ahmed%')
