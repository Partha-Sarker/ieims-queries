drop table CRVS_IDS
/


create table CRVS_IDS
(
    ID         NUMBER(19) not null
        constraint CRVS_IDS_ID_PK
            primary key,
    CREATED_AT TIMESTAMP(6),
    UPDATED_AT TIMESTAMP(6),
    STATUS     NUMBER(1),
    MESSAGE    VARCHAR2(200),
    STUDENT_ID NUMBER(19) not null
        constraint FK_CRVS_IDS_STUDENT
            references STD_REGISTRATION_INFO,
    JOB_ID     NUMBER
        constraint FK_CRVS_IDS_JOB
            references EDU_ID_ALLOCATION_JOB
)
/

comment on column CRVS_IDS.STATUS is '0 => processing, 1 => successful, 2 => failed, 3 => exclude (need manual intervention)'
/

create unique index CRVS_IDS_STUENT_ID_INDEX
    on CRVS_IDS (STUDENT_ID)
/

alter table CRVS_IDS
    add constraint UK_STUDEN_ID
        unique (STUDENT_ID)
/

create trigger CRVS_IDS_ID_TRG
    before insert
    on CRVS_IDS
    for each row
begin
            if :new.ID is null then
                select crvs_ids_id_seq.nextval into :new.ID from dual;
            end if;
            end;
/

