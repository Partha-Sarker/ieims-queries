insert into skeleton.iig.temp_ieims_id_sequence(id, year, board_code, last_sequence, revision, created_by)
select row_number() over (ORDER BY year, board_code), cast(concat('20', year) as int), board_code, 1, 1, 1
from iig.edu_id
where year >= 14
  and year <= 26
group by year, board_code


truncate table skeleton.iig.temp_ieims_id_sequence

create table iig.temp_ieims_id_sequence_old
(
    id            int        not null
        constraint PK_IEIMS_ID_SEQUENCE_OLD
            primary key,
    board_code    varchar(6) not null,
    year          int        not null,
    last_sequence int        not null,
    created_at    datetime,
    updated_at    datetime,
    revision      int,
    created_by    bigint     not null,
    updated_by    bigint,
    constraint uk_board_code_year_OLD
        unique (board_code, year)
)
go