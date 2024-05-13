select version(), current_date, now() from dual;

-- 수학함수, 사칙연산도 된다.
select sin(pi()/4), 1 + 2 * 3 - 4 / 5 from dual;

-- 대소문자 구분이 없다.
sELecT VERSION(), current_DATE, NOW() From DUAL;

-- table 생성: DDL
create table pet(
	name varchar(100),
    owner varchar(50),
    species varchar(20),
    gender char(1),
    brith date,
    death date
);

-- schema 확인
describe pet;
desc pet;

-- table 삭제
drop table pet;
show tables;

-- insert: DML(C)
insert into pet values('베니', '김기쁨', 'heidgehog', 'f', '2017-06-01', null);

-- select: DML(R)
select * from pet;

-- update: DML(U)
update pet set name='베니니' where name='베니';

-- delete: DML(D)
delete from pet where name='베니니';

-- load data: mysql(CLI) 전용
load data local infile '/root/pet/.txt' into table pet;

