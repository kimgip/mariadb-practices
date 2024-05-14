-- outer join

-- insert into dept values(null, '총무');
-- insert into dept values(null, '개발');
-- insert into dept values(null, '영업');
-- insert into dept values(null, '기획');

select * from dept;

-- insert into emp values(null, '둘리', 1);
-- insert into emp values(null, '마이콜', 2);
-- insert into emp values(null, '또치', 3);
-- insert into emp values(null, '길동', null);

select * from emp;

-- inner join
SELECT 
    a.name, b.name
FROM
    emp a
        JOIN
    dept b ON a.dept_no = b.no;

-- left (outer) join
SELECT 
    a.name '이름', ifnull(b.name, '없음') '부서'
FROM
    emp a
        LEFT JOIN
    dept b ON a.dept_no = b.no;
    
-- right (outer) join
SELECT 
    ifnull(a.name, '없음') '이름', b.name '부서'
FROM
    emp a
        RIGHT JOIN
    dept b ON a.dept_no = b.no;

-- full (outer) join
-- mariadb 지원 안함