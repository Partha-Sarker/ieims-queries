-- auto-generated definition
create table EDU_ID_ALLOCATION_JOB
(
    ID          NUMBER(11) not null
        constraint EDU_ID_ALLOCATION_JOB_ID_PK
            primary key,
    STATUS      VARCHAR2(20),
    STARTED_ON  TIMESTAMP(6),
    FINISHED_ON TIMESTAMP(6),
    TYPE        VARCHAR2(20)
)
/

create sequence EDU_ID_ALLOCATION_JOB_SEQ
/

create trigger EDU_ID_ALLOCATION_JOB_ID_TRG
    before insert
    on EDU_ID_ALLOCATION_JOB
    for each row
begin
    if :new.ID is null then
        select edu_id_allocation_job_seq.nextval into :new.ID from dual;
    end if;
end;
/

