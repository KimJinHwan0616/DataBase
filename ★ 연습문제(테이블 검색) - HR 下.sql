-- 급여가 12000 이상되는 직원들의 LAST_NAME 및 급여를 조회한다.
select LAST_NAME, SALARY from EMPLOYEES
where SALARY >= 12000;

-- 사원번호가 176 인 사람의 LAST_NAME 과 부서 번호를 조회한다.
select LAST_NAME, DEPARTMENT_ID from EMPLOYEES
where EMPLOYEE_ID = 176;

-- 급여가 5000 에서 12000의 범위 이외인 사람들의 LAST_NAME 및 급여를 조회한다.
select LAST_NAME, SALARY from EMPLOYEES
where SALARY between 5000 and 12000;

-- 20 번 또는 50 번 부서에 근무하며, 급여가 5000 ~ 12,000 사이인 사원들의 LAST_NAME 및 급여을 조회한다.
select LAST_NAME, SALARY from EMPLOYEES
where DEPARTMENT_ID in (20,50) and SALARY between 5000 and 12000;

-- LAST_NAME 의 네번째 글자가 a인 사원들의 LAST_NAME 을 조회한다.
select LAST_NAME from EMPLOYEES
where LAST_NAME like '____a%';


-- LAST_NAME 에 a 또는 e 글자가 있는 사원들의 LAST_NAME 을 조회힌다.
select LAST_NAME from EMPLOYEES
where LAST_NAME like '%a%' or LAST_NAME like '%e%';


-- 급여가 2500, 3500, 7000 이 아니며 직업이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
select * from EMPLOYEES
where SALARY not in (2500, 3500, 7000) and JOB_ID in ('SA_REP', 'ST_CLERK');

-- IT 부서의 급여 총합을 조회하라.
select sum(SALARY) from EMPLOYEES
where JOB_ID like '%IT%';

-- 부서와 직무별 최대급여, 최소급여, 사원수를 조회하라.
select DEPARTMENT_ID, JOB_ID, max(SALARY), min(SALARY), count(EMPLOYEE_ID) from EMPLOYEES
group by DEPARTMENT_ID, JOB_ID;

-- 회사 전체의 최대 급여, 최소급여, 급여 총합 및 평균 급여를 조회하세요
select max(SALARY), min(SALARY), sum(SALARY), avg(SALARY) from EMPLOYEES;

-- 각 JOB_ID 별, 최대 급여, 최소 급여, 급여 총합 및 평균 급여를 정수로 포맷하여 조회하세요
select JOB_ID, max(SALARY), min(SALARY), sum(SALARY), avg(SALARY) from EMPLOYEES
group by JOB_ID;

-- 직책별 사원 총 수를 조회하세요

select JOB_ID, count(EMPLOYEE_ID) from EMPLOYEES
group by JOB_ID;

-- 매니저로 근무하는 사원들의 총 수를 조회하세요 ●●
select count(distinct MANAGER_ID) 매니저수 from EMPLOYEES; -- 매니저번호가 같으면 같은매니저로 계산하나보네..

-- 사내의 최대 급여 및 최소 급여의 차이를 조회하세요
select max(SALARY) - min(SALARY) from EMPLOYEES;
