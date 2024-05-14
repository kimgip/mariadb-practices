--
-- inner join
--

-- 예제1) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하세요.
SELECT 
    a.first_name, b.title
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no -- join 조건(n-1)
        AND b.to_date = '9999-01-01'; -- row 선택 조건
        
-- 예제2) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하되, 여성 엔지니어(Engineer)만 출력하세요.
SELECT 
    a.first_name, b.title
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no 				-- join 조건(n-1)
		AND a.gender = 'f' 				-- row 선택 조건1
        AND b.title = 'engineer' 		-- row 선택 조건2
        AND b.to_date = '9999-01-01';	-- row 선택 조건3

--
-- ANSI/ISO SQL1999 Join 표준문법
--

-- 1) natural join
-- 조인 대상이 되는 두 테이블에 이름이 같은 공통 컬럼이 있으면 조인 조건을 명시하지 않고 암묵적으로 조인이 된다.
SELECT 
    a.first_name, b.title
FROM
    employees a
        NATURAL JOIN
    titles b
WHERE
    b.to_date = '9999-01-01';

-- 2) join ~ using
-- natural join 문제점
select count(*) from salaries a natural join titles b where a.to_date = '9999-01-01' and b.to_date = '9999-01-01';
select count(*) from salaries a join titles b using (emp_no) where a.to_date = '9999-01-01' and b.to_date = '9999-01-01';

-- join ~ on
-- 예제) 현재, 직책별 평균 연봉을 큰 순서대로 출력하세요.
SELECT 
    title, AVG(salary)
FROM
    salaries a
        JOIN titles b ON a.emp_no = b.emp_no
WHERE
    a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(salary) DESC;

-- 실습문제1
-- 현재, 직원별 근무부서를 출력해 보세요.
-- 사번, 직원이름(first_name), 부서명 순으로 출력 하세요.
SELECT 
    a.emp_no, a.first_name, c.dept_name
FROM
    employees a,
    dept_emp b,
    departments c
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND b.to_date = '9999-01-01';

-- 실습문제2
-- 현재, 지급되고 있는 급여를 출력해 보세요.
-- 사번, 이름(first_name), 급여 순으로 출력 하세요.
SELECT 
    a.emp_no, a.first_name, b.salary
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
        AND b.to_date = '9999-01-01';
        
-- 실습문제3
-- 현재, 직책별 평균연봉과 직원수를 구하되 직원수가 100명 이상인 직책만 출력하세요.
-- projection: 직책 평균연봉 직원수
SELECT 
    title, AVG(salary), COUNT(*)
FROM
    titles a
        JOIN
    salaries b ON a.emp_no = b.emp_no
WHERE
    a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01'
GROUP BY a.title
HAVING COUNT(*) >= 100;

-- 실습문제4
-- 현재, 부서별로 직책이 Engineer인 직원들에 대해서만 평균 연봉을 구하세요.
-- projection: 부서이름 평균급여
SELECT 
    dept_name, AVG(salary)
FROM
    departments a
        JOIN
    dept_emp b ON a.dept_no = b.dept_no
        JOIN
    titles c ON b.emp_no = c.emp_no
        JOIN
    salaries d ON c.emp_no = d.emp_no
WHERE
    c.title = 'engineer'
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
GROUP BY a.dept_name;