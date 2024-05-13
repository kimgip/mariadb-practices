--
-- select 연습
-- 

-- 예제1: departments 테이블의 모든 데이터를 출력.
select * from departments;

-- 프로젝션(projection)
-- 예제2: employees 테이블에서 직원의 이름, 성별, 입사일을 출력
SELECT 
    first_name, gender, hire_date
FROM
    employees
LIMIT 10;

-- as(alias, 생략가능)
SELECT 
    first_name as '이름', gender '성별', hire_date '입사일'
FROM
    employees;

SELECT 
    CONCAT(first_name, ' ', last_name) '이름', gender '성별', hire_date '입사일'
FROM
    employees;

-- distinct
-- 예제4: titles 테이블에서 모든 직급의 이름 출력
select title from titles;

-- 예제5: titles 테이블에서 직급은 어떤 것들이 있는 지 직급의 이름을 한번씩만 출력
select distinct(title) from titles;

--
-- where
--

-- 비교연산자
-- 예제1: employees 테이블에서 1991년 이전에 입사한 직원의 이름, 성별, 입사일을 출력
select 
	concat(first_name, ' ', last_name) as '이름',
	gender as '성별',
    hire_date as '입사일'
from 
	employees
where 
	hire_date < '1991-01-01';
    
-- 논리연산자
-- 예제2: employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력alter
select 
	concat(first_name, ' ', last_name) as '이름',
	gender as '성별',
    hire_date as '입사일'
from 
	employees
where 
	hire_date < '1989-01-01' and gender = 'F';

-- in 연산자
-- 예제3: dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의 사원, 부서번호 출력
SELECT 
    emp_no, dept_no
FROM
    dept_emp
WHERE
    dept_no = 'd005' OR dept_no = 'd009';

SELECT 
    emp_no, dept_no
FROM
    dept_emp
WHERE
    dept_no IN ('d005' , 'd009');
    
-- like 검색
-- 예제4: employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력
SELECT 
    first_name, hire_date
FROM
    employees
WHERE
    hire_date > '1989-00-00'
        AND hire_date < '1990-00-00';

SELECT 
    first_name, hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '1989-01-01' AND '1989-12-31';

SELECT 
    first_name, hire_date
FROM
    employees
WHERE
    hire_date LIKE '1989-%';

--
-- order by
--

-- 예제1: employees 테이블에서 직원의 전체이름, 성별, 입사일을 입사일 순으로 출력
SELECT 
    CONCAT(first_name, ' ', last_name) '이름', gender '성별', hire_date '입사일'
FROM
    employees
ORDER BY hire_date ASC;
    
-- 예제2: salaries 테이블에서 2001년 월급이 가장 높은 순으로 사번, 월급순으로 출력
SELECT 
    emp_no, salary
FROM
    salaries
WHERE
    from_date LIKE '2001%'
        OR to_date LIKE '2001%'
ORDER BY salary DESC;

-- 예제3: 남자 직원의 이름, 성별, 입사일을 입사일순(선임순)으로 출력
SELECT 
    first_name, gender, hire_date
FROM
    employees
WHERE
    gender = 'm'
ORDER BY hire_date ASC;

-- 예제4: 직원의 사번, 월급을 사번(asc), 월급(desc)으로 출력
SELECT 
    emp_no, salary
FROM
    salaries
ORDER BY emp_no ASC , salary DESC;