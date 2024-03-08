-- ----------------------------
-- View structure for BY_GEO_WISE_STUDENTS
-- ----------------------------
CREATE OR REPLACE VIEW "CRVSPROD"."BY_GEO_WISE_STUDENTS" AS SELECT
		inst.DIVISION_ID,
		div.DIVISION_NAME,
		inst.DISTRICT_ID,
		dist.DISTRICT_NAME,
		inst.THANA_ID,
		tha.THANA_NAME,
		sri.EIIN,
		sri.FATHER_NID,
		sri.MOTHER_NID,
		sri.GUARDIAN_NID,
		sri.FATHER_UBRN,
		sri.MOTHER_UBRN,
		sri.FM_NID_FOUND_STATUS,
		sri.TEMP_STATUS,
		sri.STATUS,
		TO_CHAR(sri.CREATED_AT, 'YYYY-MM-DD') entry_date


FROM STD_REGISTRATION_INFO sri
JOIN INSTITUTES inst on inst.EIIN = sri.EIIN
JOIN DIVISIONS div ON div.DIVISION_ID = inst.DIVISION_ID
JOIN DISTRICTS dist ON dist.DISTRICT_ID = inst.DISTRICT_ID
JOIN THANAS tha ON tha.THANA_ID = inst.THANA_ID;

CREATE OR REPLACE VIEW "CRVSPROD"."BY_GEO_AND_DATE_WISE_TOTAL_FMG_INFO" AS SELECT
                main_table.ENTRY_DATE,
                main_table.DIVISION_ID,
                main_table.DIVISION_NAME,
                main_table.DISTRICT_ID,
                main_table.DISTRICT_NAME,
                main_table.THANA_ID,
                main_table.THANA_NAME,
                (
                    SELECT
                        COUNT(DDTEE.EIIN)
                    FROM by_geo_wise_students DDTEE
                    WHERE DDTEE.ENTRY_DATE = main_table.ENTRY_DATE
                    AND DDTEE.DIVISION_ID = main_table.DIVISION_ID
                    AND DDTEE.DISTRICT_ID = main_table.DISTRICT_ID
                    AND DDTEE.THANA_ID = main_table.THANA_ID
                ) TOTAL_SUBMITTED,
                (
                    SELECT
                        COUNT(DDTEE.EIIN)
                    FROM by_geo_wise_students DDTEE
                    WHERE DDTEE.FATHER_NID IS NOT NULL
                    AND DDTEE.MOTHER_NID IS NOT NULL
                    AND DDTEE.ENTRY_DATE = main_table.ENTRY_DATE
                    AND DDTEE.DIVISION_ID = main_table.DIVISION_ID
                    AND DDTEE.DISTRICT_ID = main_table.DISTRICT_ID
                    AND DDTEE.THANA_ID = main_table.THANA_ID
                ) FATHER_MOTHER_NID,
                (
                    SELECT
                        COUNT(DDTEE.EIIN)
                    FROM by_geo_wise_students DDTEE
                    WHERE DDTEE.FATHER_NID IS NOT NULL
                    AND DDTEE.ENTRY_DATE = main_table.ENTRY_DATE
                    AND DDTEE.DIVISION_ID = main_table.DIVISION_ID
                    AND DDTEE.DISTRICT_ID = main_table.DISTRICT_ID
                    AND DDTEE.THANA_ID = main_table.THANA_ID
                ) FATHER_NID,
                (
                    SELECT
                        COUNT(DDTEE.EIIN)
                    FROM by_geo_wise_students DDTEE
                    WHERE DDTEE.MOTHER_NID IS NOT NULL
                    AND DDTEE.ENTRY_DATE = main_table.ENTRY_DATE
                    AND DDTEE.DIVISION_ID = main_table.DIVISION_ID
                    AND DDTEE.DISTRICT_ID = main_table.DISTRICT_ID
                    AND DDTEE.THANA_ID = main_table.THANA_ID
                ) MOTHER_NID,
                (
                    SELECT
                        COUNT(DDTEE.EIIN)
                    FROM by_geo_wise_students DDTEE
                    WHERE DDTEE.GUARDIAN_NID IS NOT NULL
                    AND DDTEE.ENTRY_DATE = main_table.ENTRY_DATE
                    AND DDTEE.DIVISION_ID = main_table.DIVISION_ID
                    AND DDTEE.DISTRICT_ID = main_table.DISTRICT_ID
                    AND DDTEE.THANA_ID = main_table.THANA_ID
                ) GUARDIAN_NID,

                (
                    SELECT
                        COUNT(DDTEE.EIIN)
                    FROM by_geo_wise_students DDTEE
                    WHERE DDTEE.FATHER_UBRN IS NOT NULL
                    AND DDTEE.MOTHER_UBRN IS NOT NULL
                    AND DDTEE.ENTRY_DATE = main_table.ENTRY_DATE
                    AND DDTEE.DIVISION_ID = main_table.DIVISION_ID
                    AND DDTEE.DISTRICT_ID = main_table.DISTRICT_ID
                    AND DDTEE.THANA_ID = main_table.THANA_ID
                ) FATHER_MOTHER_BRN,
                (
                    SELECT
                        COUNT(DDTEE.EIIN)
                    FROM by_geo_wise_students DDTEE
                    WHERE DDTEE.FATHER_UBRN IS NOT NULL
                    AND DDTEE.ENTRY_DATE = main_table.ENTRY_DATE
                    AND DDTEE.DIVISION_ID = main_table.DIVISION_ID
                    AND DDTEE.DISTRICT_ID = main_table.DISTRICT_ID
                    AND DDTEE.THANA_ID = main_table.THANA_ID
                ) FATHER_BRN,
                (
                    SELECT
                        COUNT(DDTEE.EIIN)
                    FROM by_geo_wise_students DDTEE
                    WHERE DDTEE.MOTHER_UBRN IS NOT NULL
                    AND DDTEE.ENTRY_DATE = main_table.ENTRY_DATE
                    AND DDTEE.DIVISION_ID = main_table.DIVISION_ID
                    AND DDTEE.DISTRICT_ID = main_table.DISTRICT_ID
                    AND DDTEE.THANA_ID = main_table.THANA_ID
                ) MOTHER_BRN

            FROM by_geo_wise_students main_table
            GROUP BY main_table.DIVISION_ID,
            main_table.DIVISION_NAME,
            main_table.DISTRICT_ID,
            main_table.DISTRICT_NAME,
            main_table.THANA_ID,
            main_table.THANA_NAME,
            main_table.ENTRY_DATE;

-- ----------------------------
-- View structure for ENTERED_STUDENT
-- ----------------------------
CREATE OR REPLACE VIEW "CRVSPROD"."ENTERED_STUDENT" AS SELECT e.eiin,e.institute_name_new,
                 cOUNT (a.BIN_BRN) student21
        FROM STD_REGISTRATION_INFO a,
             divisions b,
             districts c,
             thanas d,
             institutes e
       WHERE     A.EIIN = E.EIIN(+)
             AND e.division_id = B.DIVISION_ID
             AND E.DISTRICT_ID = C.DISTRICT_ID
             AND E.THANA_ID = D.THANA_ID
    GROUP BY  e.eiin,e.institute_name_new;

-- ----------------------------
-- View structure for INSTITUTE_USERS
-- ----------------------------
CREATE OR REPLACE VIEW "CRVSPROD"."INSTITUTE_USERS" AS (SELECT INSTITUTES_USER.EIIN as EIIN , INSTITUTES_USER.EMAIL as USERNAME, INSTITUTES_USER.PASSWORD,INSTITUTES_USER.ID AS ID,INSTITUTES_USER.USER_ROLES
    FROM INSTITUTES_USER)
    union all
    (SELECT INSTITUTES.EIIN,INSTITUTES.EIIN AS USERNAME,INSTITUTES.PASSWORD ,INSTITUTES.INSTITUTE_ID AS ID,INSTITUTES.USER_ROLES FROM INSTITUTES);

-- ----------------------------
-- View structure for THANAWISE_ENTRY
-- ----------------------------
CREATE OR REPLACE VIEW "CRVSPROD"."THANAWISE_ENTRY" AS (  SELECT c.division_name,
             d.district_name,
             e.thana_name,
             SUM (NVL (b.total_students, 0)) student20,
             SUM (NVL (a.student21, 0)) student21
        FROM ENTERED_STUDENT a,
             institutes b,
             divisions c,
             districts d,
             thanas e
       WHERE     b.eiin = a.eiin(+)
             AND b.division_id = c.DIVISION_ID(+)
             AND b.DISTRICT_ID = d.DISTRICT_ID(+)
             AND b.THANA_ID = e.THANA_ID(+)
    GROUP BY c.division_name, d.district_name, e.thana_name);

-- ----------------------------
-- View structure for UIDLIST
-- ----------------------------
CREATE OR REPLACE VIEW "CRVSPROD"."UIDLIST" AS SELECT c.division_name,
           d.district_name,
           e.thana_name,
           A.EIIN,
           F.INSTITUTE_NAME_NEW,
           A."UID",
           A.BIN_BRN,
           A.FULLNAME_BANGLA,
           A.FULLNAME_ENGLISH,
           A.MOTHERNAME_BANGLA,
           A.MOTHERNAME_ENGLISH,
           A.FATHERNAME_BANGLA,
           A.FATHERNAME_ENGLISH,
					 o.CREATED_AT
      FROM STD_REGISTRATION_INFO A,
           institutes b,
           divisions c,
           districts d,
           thanas e,
					 ARC_ORG_VERIFICATIONS o,
           INSTITUTES F
     WHERE     A."UID" <> '107'
           AND b.eiin = a.eiin(+)
           AND A.EIIN=F.EIIN
           AND b.division_id = c.DIVISION_ID(+)
           AND b.DISTRICT_ID = d.DISTRICT_ID(+)
           AND b.THANA_ID = e.THANA_ID(+)
					 AND o.RES_UBRN = A.BIN_BRN
			ORDER BY o.id DESC;

-- ----------------------------
-- View structure for UPZILAWISE_BIIL_PAYMENT
-- ----------------------------
CREATE OR REPLACE VIEW "CRVSPROD"."UPZILAWISE_BIIL_PAYMENT" AS (SELECT "INSTITUTE_USERS"."EIIN",
           "INSTITUTES"."INSTITUTE_NAME_NEW",
           "INSTITUTE_USERS"."ID",
           "INSTITUTE_USERS"."USER_ROLES",
           "DIVISIONS"."DIVISION_NAME",
           "DISTRICTS"."DISTRICT_NAME",
           "THANAS"."THANA_NAME",
           (SELECT COUNT (in_reg_info.ID)
              FROM    STD_CURRENT_ACADEMIC_INFO in_curr_info
                   JOIN
                      STD_REGISTRATION_INFO in_reg_info
                   ON in_reg_info.id = in_curr_info.SRI_ID
             WHERE     in_reg_info.EIIN = institute_users.eiin
                   AND in_reg_info.created_by = institute_users.id
                   AND in_curr_info.ACADEMIC_YEAR = 2021
                   AND TO_CHAR (in_reg_info.CREATED_AT, 'YYYY-MM-DD') BETWEEN '2022-01-01'
                                                                          AND '2022-05-31')
              AS total_entry,
           (CASE
               WHEN institute_users.user_roles = 2
               THEN
                  (SELECT name || ' ( ' || id || ' ) '
                     FROM institutes_user
                    WHERE eiin = institute_users.eiin
                          AND id = institute_users.id                                       FETCH FIRST 1 ROWS ONLY
) ELSE 'Head of the Institution-Admin (' || institute_users.id || ' )'
END
) AS entry_user_name
FROM
"INSTITUTE_USERS"
INNER JOIN "INSTITUTES" ON "INSTITUTES"."EIIN" = "INSTITUTE_USERS"."EIIN"
INNER JOIN "DIVISIONS" ON "DIVISIONS"."DIVISION_ID" = "INSTITUTES"."DIVISION_ID"
INNER JOIN "DISTRICTS" ON "DISTRICTS"."DISTRICT_ID" = "INSTITUTES"."DISTRICT_ID"
INNER JOIN "THANAS" ON "THANAS"."THANA_ID" = "INSTITUTES"."THANA_ID");