select eiin, count(id) as student_count
from registration
where session_code = 'SSC_2018_2019'
group by session_code, eiin
order by student_count desc

select session_code
from registration
group by session_code

delete from registration
where session_code = 'SSC_2018_2019'
  and eiin not in ('130699', '134139', '131213', '134114', '107875', '108628', '108968')