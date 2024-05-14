-- 테이블간 조인(JOIN) SQL 문제입니다.

-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select a.emp_no, first_name, salary from employees a, salaries b where a.emp_no = b.emp_no and b.to_date='9999-01-01' order by salary desc;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
SELECT 
    a.emp_no, a.first_name, b.title
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01'
ORDER BY first_name;

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.
SELECT 
    a.emp_no, first_name, dept_name
FROM
    employees a,
    dept_emp b,
    departments c
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND b.to_date = '9999-01-01'
ORDER BY first_name;

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
SELECT 
    a.emp_no, first_name, salary, title, dept_name
FROM
    employees a,
    dept_emp b,
    departments c,
    salaries d,
    titles e
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND a.emp_no = d.emp_no
        AND a.emp_no = e.emp_no
        AND b.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND e.to_date = '9999-01-01'
ORDER BY a.first_name;

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
select a.emp_no, concat(first_name, ' ', last_name) from employees a join titles b on a.emp_no = b.emp_no where b.title = 'technique leader' and b.to_date != '9999-01-01';

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
SELECT 
    last_name, dept_name, title
FROM
    employees a
        JOIN
    dept_emp b ON a.emp_no = b.emp_no
        JOIN
    departments c ON b.dept_no = c.dept_no
        JOIN
    titles d ON a.emp_no = d.emp_no
WHERE
    last_name LIKE 'S%';

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
SELECT 
    a.emp_no, first_name, salary, title
FROM
	employees c
		JOIN
    salaries a ON c.emp_no = a.emp_no
        JOIN
    titles b ON a.emp_no = b.emp_no
WHERE
    a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
        AND b.title = 'engineer'
        AND a.salary >= 40000
ORDER BY salary DESC;

-- 문제8.
-- 현재 평균급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
SELECT 
    title 직책, AVG(salary) 급여
FROM
    titles a,
    salaries b
WHERE
    a.emp_no = b.emp_no
		AND a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY title
HAVING AVG(salary) > 50000
ORDER BY 급여 DESC;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
SELECT 
    dept_name, AVG(salary)
FROM
    salaries a
        JOIN
    dept_emp b ON a.emp_no = b.emp_no
        JOIN
    departments c ON b.dept_no = c.dept_no
WHERE
    a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY AVG(salary) DESC;

-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select title, avg(salary) from titles a join salaries b on a.emp_no = b.emp_no where a.to_date = '9999-01-01' and b.to_date = '9999-01-01' group by title order by avg(salary) desc;