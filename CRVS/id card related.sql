-- update STD_REGISTRATION_INFO
-- set ID_CARD_PATH = null
-- where ID_CARD_PATH is not null;
--
-- update INSTITUTES
-- set INS_ID_CARD_GENERATE_STATUS = 0,
--     STD_ID_CARD_GENERATE_STATUS = 0
-- where INS_ID_CARD_GENERATE_STATUS != 0;
-- commit;

select count(id)
from STD_REGISTRATION_INFO
where ID_CARD_PATH is not null;

select count(INSTITUTE_ID)
from INSTITUTES
where INS_ID_CARD_GENERATE_STATUS = 1;

select r.dob,
       r.fullname_english,
       r.fullname_bangla,
       r.std_profile_image,
       r.fathername_bangla,
       r.mothername_bangla,
       r.std_crvs_id,
       r."UID",
       r.image_folder_path,
       r.bin_brn,
       r.guardian_name,
       r.mother_mobile_no,
       r.father_mobile_no,
       r.guardian_mobile,
       r.id,
       c.std_class_id,

       r.blood_group,
       d.district_name_bn,
       t.thana_nameb,
       r.permanenthouseholdno,
       r.permanent_address,
       r.permanent_post_office,
       r.permanent_address,
       r.father_nid,
       r.mother_nid,
       r.fathername_english,
       r.mothername_english
from STD_CURRENT_ACADEMIC_INFO c
         join
     (SELECT sri_id, Max(academic_year) AS year
      FROM std_current_academic_info cai
      WHERE cai.EIIN = 108181
      GROUP BY sri_id) latest_c
     ON c.sri_id = latest_c.sri_id
         AND c.academic_year = latest_c.year
         join STD_REGISTRATION_INFO r
              on r.id = c.SRI_ID and r.STD_CRVS_ID is not null and r.ID_CARD_PATH is null
         left join districts d on d.district_id = r.permanentdisttictid
         left join thanas t on t.thana_id = r.permanentthanaid
order by r.id;
/
select div.DIVISION_NAME,
       dis.DISTRICT_NAME,
       dis.DISTRICT_NAME_BN,
       dis.DISTRICT_ID,
       count(i.INSTITUTE_ID)
from INSTITUTES i
         join DIVISIONS div on i.DIVISION_ID = div.DIVISION_ID
         join DISTRICTS dis on dis.DIVISION_ID = div.DIVISION_ID and i.DISTRICT_ID = dis.DISTRICT_ID
group by div.DIVISION_NAME, dis.DISTRICT_ID, dis.DISTRICT_NAME, DISTRICT_NAME_BN
order by div.DIVISION_NAME, dis.DISTRICT_NAME
/
select div.DIVISION_NAME,
       dis.DISTRICT_NAME,
       dis.DISTRICT_ID,
       t.THANA_NAME,
       t.THANA_NAMEB,
       t.THANA_ID,
       count(i.INSTITUTE_ID)
from INSTITUTES i
         join DIVISIONS div on i.DIVISION_ID = div.DIVISION_ID
         join DISTRICTS dis on dis.DIVISION_ID = div.DIVISION_ID and i.DISTRICT_ID = dis.DISTRICT_ID
         join THANAS t on t.DISTRICT_ID = dis.DISTRICT_ID and i.THANA_ID = t.THANA_ID
group by div.DIVISION_NAME, dis.DISTRICT_ID, dis.DISTRICT_NAME, t.THANA_NAME, t.THANA_NAMEB, t.THANA_ID
order by div.DIVISION_NAME, dis.DISTRICT_NAME, t.THANA_NAME
/

/
-- update STD_REGISTRATION_INFO
-- set ID_CARD_PATH = null
-- where id in (select id
--              from STD_REGISTRATION_INFO r
--                       join INSTITUTES i on i.EIIN = r.EIIN and
--                                            i.DIVISION_ID != 10
--              where r.ID_CARD_PATH is not null);
-- commit;
--
-- update INSTITUTES
-- set INS_ID_CARD_GENERATE_STATUS = 0
-- where DIVISION_ID != 10
--   and INS_ID_CARD_GENERATE_STATUS = 1;
-- commit;

select count(INSTITUTE_ID)
from INSTITUTES
where DISTRICT_ID = 1006
  and INS_ID_CARD_GENERATE_STATUS = 1;
/
WITH selected_records AS (
    SELECT id, ID_CARD_PATH
    FROM STD_REGISTRATION_INFO r
    JOIN INSTITUTES i ON i.EIIN = r.EIIN
    WHERE i.DISTRICT_ID = 3093
)

SELECT COUNT(*)
FROM selected_records
WHERE ID_CARD_PATH IS NOT NULL;
/
select count(id), sysdate
from STD_REGISTRATION_INFO
where ID_CARD_PATH is not null
/
select div.DIVISION_NAME,
       dis.DISTRICT_NAME,
       dis.DISTRICT_NAME_BN,
       dis.DISTRICT_ID,
       count(1)                                                         as total,
       SUM(CASE WHEN INS_ID_CARD_GENERATE_STATUS = 1 THEN 1 ELSE 0 END) as completed
from INSTITUTES i
         join DIVISIONS div on i.DIVISION_ID = div.DIVISION_ID and div.DIVISION_ID = 30 and
                               DISTRICT_ID in (3059, 3067, 3068, 3082, 3086, 3093)
         join DISTRICTS dis on i.DISTRICT_ID = dis.DISTRICT_ID and dis.DIVISION_ID = div.DIVISION_ID
group by div.DIVISION_ID, div.DIVISION_NAME, dis.DISTRICT_ID, dis.DISTRICT_NAME, dis.DISTRICT_NAME_BN
order by div.DIVISION_NAME, dis.DISTRICT_NAME
/
select count(id)
from STD_REGISTRATION_INFO
where ID_CARD_PATH is not null
/
select d.DIVISION_NAME,
       d.DIVISION_ID,
       count(1)                                                    as total,
       SUM(CASE WHEN r.ID_CARD_PATH is not null THEN 1 ELSE 0 END) as completed
from DIVISIONS d
         join INSTITUTES i on i.DIVISION_ID = d.DIVISION_ID and d.DIVISION_ID in (20, 30)
         join STD_REGISTRATION_INFO r on i.EIIN = r.EIIN and r.STD_CRVS_ID is not null
group by d.DIVISION_NAME, d.DIVISION_ID
order by d.DIVISION_NAME;
/
select t.THANA_NAME,
       t.THANA_ID,
       count(1)                                                         as total,
       SUM(CASE WHEN INS_ID_CARD_GENERATE_STATUS = 1 THEN 1 ELSE 0 END) as completed
from THANAS t
         join INSTITUTES i on i.THANA_ID = t.THANA_ID
    and t.DISTRICT_ID = 3093
group by t.THANA_NAME, t.THANA_ID
having count(1) != SUM(CASE WHEN INS_ID_CARD_GENERATE_STATUS = 1 THEN 1 ELSE 0 END)
order by t.THANA_NAME
/
select t.THANA_NAME,
       t.THANA_ID,
       count(1)                                                         as total,
       SUM(CASE WHEN INS_ID_CARD_GENERATE_STATUS = 1 THEN 1 ELSE 0 END) as completed
from THANAS t
         join INSTITUTES i on i.THANA_ID = t.THANA_ID
    and t.DISTRICT_ID = 3093
join STD_REGISTRATION_INFO r on r.EIIN = i.EIIN
group by t.THANA_NAME, t.THANA_ID
having count(1) != SUM(CASE WHEN INS_ID_CARD_GENERATE_STATUS = 1 THEN 1 ELSE 0 END)
order by t.THANA_NAME;


26378
14328
14404
12627
