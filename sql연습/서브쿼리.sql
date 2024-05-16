--
-- subquery
--

--
-- 1) select 절, insert into t1 values(...)
--

--
-- *2) from 절의 서브쿼리
--
select now() as n, sysdate() as s, 3 + 1 as r from dual;

select n, s, r from (select now() as n, sysdate() as s, 3+1 as r from dual) a;

--
-- *3) where 절의 서브쿼리
-- 

-- 예제) 현재, Fai Bale이 근무하는 부서에서 근무하는 다른 직원의 사번과 이름을 출력하세요.
SELECT 
    *
FROM
    employees a,
    dept_emp b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND CONCAT(a.first_name, ' ', a.last_name) = 'Fai Bale';

-- 'd004'

SELECT 
    a.emp_no, a.first_name
FROM
    employees a,
    dept_emp b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.dept_no = 'd004';

-- 서브쿼리가 필요한 이유 : 데이터베이스의 일관성

SELECT 
    a.emp_no, a.first_name
FROM
    employees a,
    dept_emp b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND b.dept_no = (SELECT 
            b.dept_no
        FROM
            employees a,
            dept_emp b
        WHERE
            a.emp_no = b.emp_no
                AND b.to_date = '9999-01-01'
                AND CONCAT(a.first_name, ' ', a.last_name) = 'Fai Bale');

-- 3-1) 단일행 연산자: =, >, <, >=, <=, <>, !=
-- 실습문제1) 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름과 급여를 출력하세요.
SELECT 
    first_name, salary
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
		AND b.to_date = '9999-01-01' 
        AND salary < (SELECT AVG(salary) FROM salaries WHERE to_date = '9999-01-01')
ORDER BY salary DESC;

-- 실습문제2) 현재, 직책별 평균급여 중 가장 작은 직책의 직책이름과 평균급여를 출력해보새요.
-- sol1: subquery
SELECT 
    title, AVG(salary)
FROM
    titles a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY title
HAVING AVG(salary) = (SELECT 
        MIN(avg_salary)
    FROM
        (SELECT 
            title, AVG(salary) AS avg_salary
        FROM
            titles a, salaries b
        WHERE
            a.emp_no = b.emp_no
                AND a.to_date = '9999-01-01'
                AND b.to_date = '9999-01-01'
        GROUP BY title) a);

-- sol2: top-k(limit)
SELECT 
    title, AVG(salary) AS avg_salary
FROM
    titles a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY title
ORDER BY avg_salary ASC
LIMIT 0, 1;

-- 3-2) 복수행 연산자: in, not in, 비교연산자 + any, 비교연산자 + all

-- any 사용법
-- 1. =any: in
-- 2. >any, >=any: 최소값
-- 3. <any, <=any: 최대값
-- 4. <>any, !=any: not in

-- all 사용법
-- 1. =all: (x)
-- 2. >all, >=all: 최대값
-- 3. <all, <=all: 최소값
-- 4. <>all, !=all

-- 실습문제3) 현재, 급여가 50,000 이상인 직원의 이름과 급여를 출력하세요.
-- sol1) join
-- sol2) subquery: where(in)
SELECT 
    a.first_name, b.salary
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
        AND (a.emp_no , b.salary) IN (SELECT 
											emp_no, salary
										FROM
											salaries
										WHERE
											to_date = '9999-01-01'
												AND salary > 50000);
-- sol2) subquery: where(=any)

-- 실습문제4) 현재, 각 부서별 최고 급여를 받고 있는 직원의 부서와 이름, 월급을 출력하세요.
-- sol1) where절 subquery(in)
SELECT 
    dept_name, first_name, salary
FROM
    departments a,
    dept_emp b,
    employees c,
    salaries d
WHERE
    a.dept_no = b.dept_no
        AND b.emp_no = c.emp_no
        AND c.emp_no = d.emp_no
        AND b.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND (a.dept_no , d.salary) IN (SELECT 
            a.dept_no, MAX(b.salary)
        FROM
            dept_emp a,
            salaries b
        WHERE
            a.emp_no = b.emp_no
                AND a.to_date = '9999-01-01'
                AND b.to_date = '9999-01-01'
        GROUP BY a.dept_no);

-- sol2) from절 subquery & join
SELECT 
    dept_name, first_name, max_salary
FROM
    departments a,
    dept_emp b,
    employees c,
    (SELECT 
        a.dept_no, MAX(b.salary) AS max_salary
    FROM
        dept_emp a, salaries b
    WHERE
        a.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01'
    GROUP BY a.dept_no) d,
    salaries e
WHERE
    a.dept_no = b.dept_no
        AND b.emp_no = c.emp_no
        AND b.dept_no = d.dept_no
        AND b.emp_no = e.emp_no
        AND b.to_date = '9999-01-01'
        AND e.to_date = '9999-01-01'
        AND e.salary = max_salary;
