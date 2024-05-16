-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(*) from salaries where to_date='9999-01-01' and salary > (select avg(salary) from salaries where to_date='9999-01-01');

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select a.emp_no, first_name, salary 
from dept_emp a, employees b, salaries c, 
(select dept_no, avg(salary) as avg_salary from dept_emp a join salaries b on a.emp_no=b.emp_no where a.to_date='9999-01-01' and b.to_date='9999-01-01' group by a.dept_no) e 
where a.emp_no = b.emp_no and b.emp_no = c.emp_no and a.dept_no = e.dept_no
and a.to_date = '9999-01-01' and c.to_date = '9999-01-01'
and salary > avg_salary;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select a.emp_no, a.first_name, manager_name, dept_name from employees a, (select a.first_name as manager_name , dept_no from employees a join dept_manager b on a.emp_no = b.emp_no where to_date='9999-01-01') b, dept_emp c, departments d
where d.dept_no = c.dept_no and c.dept_no = b.dept_no and c.emp_no = a.emp_no
and c.to_date='9999-01-01';

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select a.emp_no, first_name, title, salary from employees a, titles b, salaries c, dept_emp d
where a.emp_no = b.emp_no and a.emp_no = c.emp_no and a.emp_no = d.emp_no
and b.to_date='9999-01-01' and c.to_date='9999-01-01' and d.to_date='9999-01-01'
and d.dept_no = (select dept_no from dept_emp a join salaries b on a.emp_no=b.emp_no where a.to_date='9999-01-01' and b.to_date='9999-01-01' group by a.dept_no order by avg(salary) desc limit 0, 1)
order by salary desc;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
select dept_name from dept_emp a join salaries b on a.emp_no=b.emp_no join departments c on a.dept_no=c.dept_no where a.to_date='9999-01-01' and b.to_date='9999-01-01' group by a.dept_no order by avg(salary) desc limit 0, 1;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select title from titles a join salaries b on a.emp_no=b.emp_no where a.to_date='9999-01-01' and b.to_date='9999-01-01' group by a.title order by avg(salary) desc limit 0, 1;

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
select dept_name, a.first_name, b.salary, d.first_name, d.salary from employees a join salaries b on a.emp_no=b.emp_no join dept_emp c on a.emp_no=c.emp_no join departments e on e.dept_no=c.dept_no
join (select dept_no, first_name, salary from dept_manager a join salaries b on a.emp_no = b.emp_no join employees c on a.emp_no = c.emp_no where a.to_date='9999-01-01' and b.to_date = '9999-01-01') d on c.dept_no=d.dept_no
where b.to_date='9999-01-01' and c.to_date='9999-01-01'
and b.salary > d.salary;