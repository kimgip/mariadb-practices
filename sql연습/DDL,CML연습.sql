-- DDL/DML 연습
drop table member;
create table member(
	no int not null auto_increment,
    email varchar(200) not null default '',
    password varchar(64) not null,
    name varchar(50) not null,
    department varchar(100),
    primary key(no)
);
desc member;

-- alter
alter table member add column juminbunho char(13) not null;
alter table member drop juminbunho;
alter table member add column juminbunho char(13) not null after email;
alter table member change column department dept varchar(100) not null;
alter table member add column self_intro text;
alter table member drop juminbunho;

-- insert
insert into member values(null, 'gippeum0102@gmail.com', password('1234'), '김기쁨', '개발팀', null);
insert into member(no, email, name, dept,password) values(null, 'gippeum0102@gmail.com', '김기쁨2', '개발팀2', password('1234'));
select * from member;

-- update
update member set email='gippeum0102@gmail.com', password=password('4321') where no = 2;

-- delete
delete from member where no = 2;

-- transaction*
select @@autocommit; -- 1 : 자동커밋
insert into member values(null, 'gippeum@gmail.com', password('1234'), '김기쁨2', '개발팀2', null);
select no, email from member;

-- tx begin
set autocommit = 0;
select @@autocommit; -- 0
insert into member values(null, 'gippeum3@gmail.com', password('1234'), '김기쁨3', '개발팀3', null);
select no, email from member; -- isolation : commit 하기 전까지 실제 db엔 반영되지 않음.

-- tx end
commit; -- 실제 db에 반영됨.