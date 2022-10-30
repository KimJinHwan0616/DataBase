-- 직무 아이디별 평균연봉을 조회하라. (직무 아이디 내림차순 정렬) ●●
select JOB_ID , avg(SALARY) 평균연봉 from EMPLOYEES
group by JOB_ID
order by JOB_ID desc; -- group by에 바로 desc를 하면 안되고 order by를 추가로 해줘야되는구나!!

-- 모든 사원들의 사원번호, 이름(FIRST_NAME, LAST_NAME), 부서번호 그리고 부서명을 조회하라.
select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
from EMPLOYEES inner join DEPARTMENTS
using (department_id); -- 상사번호,부서번호 2개가 겹치는데 부서번호만 알고싶으므로 부서번호만 적용하면되는군

-- 모든 부서의 부서명과 도시명을 조회하라.
select DEPARTMENT_NAME, CITY from DEPARTMENTS inner join LOCATIONS
using(location_id);

-- 모든 사원들의 사원번호, 부서명, 직무명을 조회하라. ●●
select EMPLOYEE_ID, DEPARTMENT_NAME, JOB_TITLE from JOBS inner join EMPLOYEES
using(job_id) inner join DEPARTMENTS
using(department_id);

-- 6인 미만의 사원이 근무하는 부서의 이름을 조회하라. ●●
select DEPARTMENT_NAME from DEPARTMENTS inner join EMPLOYEES
using(department_id)
group by DEPARTMENT_NAME
having count(EMPLOYEE_ID) < 6;
-- 집계함수를 조건절에선 사용할 수 없음 -> Having을 이용해야함 -> 그룹별로 정렬을 시켜야되는군


-- 4인 미만의 사원이 근무하는 부서의 평균연봉과 부서명을 조회하라.
select DEPARTMENT_NAME, round(avg(SALARY)) 평균연봉  from DEPARTMENTS inner join EMPLOYEES
using(department_id)
group by DEPARTMENT_NAME
having count(EMPLOYEE_ID) < 4;
-- 집계함수를 조건절에선 사용할 수 없음 -> Having을 이용해야함 -> 그룹별로 정렬을 시켜야되는군

-- IT 부서의 연봉 총합을 조회하라.
select sum(salary) 연봉총합 from EMPLOYEES
where JOB_ID like '%IT%';

-- 대륙명(REGIONS)별 도시의 개수를 조회하라.
select REGION_NAME, count(city) from REGIONS inner join COUNTRIES
using(region_id) inner join locations
using(country_id)
group by REGION_NAME;

-- 도시가 없는 대륙이 존재! ●●
select REGION_NAME, count(CITY)
from REGIONS full outer join COUNTRIES
using (region_id) full outer join LOCATIONS
using(country_id)
where city is not null
group by REGION_NAME;

select REGION_NAME, count(CITY)
from REGIONS full outer join COUNTRIES
using (region_id) full outer join LOCATIONS
using(country_id)
where city is null
group by REGION_NAME;


-- 도시명 별 부서의 개수를 조회하라.
select city, count(DEPARTMENT_ID) from DEPARTMENTS inner join LOCATIONS
using(location_id)
group by CITY;

-- 부서가 존재하지 않는 도시를 조회하라. ●●
select distinct CITY from DEPARTMENTS full outer join LOCATIONS -- right 가능
using(location_id)
where department_id is null;

-- 사원이 존재하지 않는 국가를 조회하라.  ●●
select distinct COUNTRY_NAME
from EMPLOYEES full outer join DEPARTMENTS using (department_id)
full outer join LOCATIONS using (location_id)
full outer join COUNTRIES using (country_id)
where EMPLOYEE_ID is null;

-- 부서장으로 있는 사원의 모든 정보와 부서명을 조회하라. ●●
select EMPLOYEES.*, DEPARTMENT_NAME from EMPLOYEES inner join DEPARTMENTS
on EMPLOYEES.EMPLOYEE_ID = DEPARTMENTS.MANAGER_ID;

-- 다른 사원의 상사인 사원의 모든 정보를 조회하라. ●●
select e2.MANAGER_ID, e2. FIRST_NAME, -- 상사정보
       e1.EMPLOYEE_ID, e1. FIRST_NAME -- 사원정보
from EMPLOYEES e1 inner join EMPLOYEES e2
on e1.EMPLOYEE_ID = e2.MANAGER_ID;

-- 이름(FIRST_NAME)이 C로 시작하고
-- s로 끝나는 사원의 부서명, 직무명, 도시명, 국가명, 대륙명을 조회하라.
select DEPARTMENT_NAME, JOB_TITLE, CITY, COUNTRY_NAME, REGION_NAME from REGIONS
    inner join COUNTRIES using (region_id)
    inner join LOCATIONS using (country_id)
    inner join DEPARTMENTS using (location_id)
    inner join EMPLOYEES using (department_id)
    inner join jobs using (job_id)
where FIRST_NAME like 'C%s';

-- 직무를 전환한 이력(job_history)이 없는 사원의 모든 정보를 조회하라. ( 2가지 ) ●●
-- 1 ( 상관질의문 )
select distinct EMPLOYEE_ID from JOB_HISTORY;
-- 101 ~ 201 : 직무전환이력 있는 사원번호

select * from EMPLOYEES
where EMPLOYEE_ID not in ( select distinct EMPLOYEE_ID from JOB_HISTORY );

-- 2 ( 외부JOIN )
select * from EMPLOYEES e full outer join JOB_HISTORY j
on e.EMPLOYEE_ID = j.EMPLOYEE_ID
where j.EMPLOYEE_ID is null; -- 외부조인은 using을 사용할 수 없는거 같군

-- 150번 사원보다 빨리 입사한 사원 중 가장 최신에 입사한 사원의 모든 정보를 조회하라.
select HIRE_DATE from EMPLOYEES
where EMPLOYEE_ID = 150; -- 2005-01-30 : 150번 사원 입사날짜

select * from EMPLOYEES
where HIRE_DATE < ( select HIRE_DATE from EMPLOYEES
where EMPLOYEE_ID = 150 )
order by HIRE_DATE desc
fetch first 1 rows only;

-- 150번 사원보다 늦게 입사한 사원 중 150번 사원보다 더 많은 연봉을 받는 사원을 조회하라.
select SALARY from EMPLOYEES
where EMPLOYEE_ID = 150; -- 10000원 : 150번 사원의 연봉

select FIRST_NAME, HIRE_DATE, SALARY from EMPLOYEES
where  HIRE_DATE > ( select HIRE_DATE from EMPLOYEES
where EMPLOYEE_ID = 150 ) and SALARY > ( select SALARY from EMPLOYEES
where EMPLOYEE_ID = 150 ) ; -- 10000원이상 왜 조회가안되냐 오류인가?? 10000넣으면 나오긴함

-- 자신의 상사가 자신 보다 늦게 입사한 사원의 모든 정보를 조회하라. ●●
select e1.EMPLOYEE_ID, e1.HIRE_DATE, e1.MANAGER_ID, -- 사원입사정보
       e2.EMPLOYEE_ID, e2.HIRE_DATE -- 상사입사정보
from EMPLOYEES e1 inner join EMPLOYEES e2
on e1.MANAGER_ID = e2.EMPLOYEE_ID
where e1.HIRE_DATE < e2.HIRE_DATE
order by e1.HIRE_DATE;

-- 직무의 종류가 가장 많은 부서의 이름을 조회하라. ●●
select JOB_ID, count(JOB_ID) 직무수 from JOBS inner join EMPLOYEES
using(job_id) inner join DEPARTMENTS
using(department_id)
group by JOB_ID
order by 직무수 desc
fetch next 1 rows only;

-- 담당 직무의 최대 연봉을 받고 있는 사원들의 모든 정보를 조회하라. ( ★ ) ●●
select job_id, max(SALARY) from EMPLOYEES
group by JOB_ID; -- 담당 직무별 최대 연봉

select * from EMPLOYEES
where (JOB_ID, SALARY) in ( select job_id, max(SALARY) from EMPLOYEES
group by JOB_ID );

-- 부서와 직무별 최대연봉, 최소연봉, 사원수를 조회하라. ●●
select DEPARTMENT_NAME, JOB_TITLE,
       max(SALARY), min(SALARY), count(EMPLOYEE_ID) from JOBS inner join EMPLOYEES
using(job_id) inner join DEPARTMENTS
using(department_id)
group by DEPARTMENT_NAME, JOB_TITLE;

-- 사원수가 가장 많은 도시에서 근무하는 모든 사원들의 부서별 및 직무별 평균 연봉을 조회하라. ●●
create or replace view "사원수가 가장 많은 도시"
as
    select CITY, count(EMPLOYEE_ID) 사원수 from LOCATIONS inner join DEPARTMENTS
    using(location_id) inner join EMPLOYEES
    using(department_id)
group by CITY
order by 사원수 desc
fetch first 1 rows only; -- south san francisco : 사원수가 가장 많은 도시

select city from "사원수가 가장 많은 도시";

select DEPARTMENT_ID, JOB_ID, avg(SALARY) from LOCATIONS inner join DEPARTMENTS
using(location_id) inner join EMPLOYEES
using(department_id) inner join JOBS
using(job_id)
where city = ( select city from "사원수가 가장 많은 도시" )
group by DEPARTMENT_ID, JOB_ID;

-- 입사일이 가장 오래된 사원을 조회하라.
select * from EMPLOYEES
where HIRE_DATE = (select min(HIRE_DATE) from EMPLOYEES ) ;

-- 입사일이 가장 최근인 사원을 조회하라.
select * from EMPLOYEES
where HIRE_DATE = (select max(HIRE_DATE) from EMPLOYEES ) ;

-- 가장 최근에 입사한 사원과 가장 오래전에 입사한 사원의 일차를 계산해 조회하라.
select max(HIRE_DATE), min(HIRE_DATE),
       to_date(max(HIRE_DATE)) - to_date(min(HIRE_DATE)) 일차
from EMPLOYEES; -- hire_date가 지금 varchar로 나와있음

-- 가장 최근에 입사한 사원과 가장 오래전에 입사한 사원의 시간차를 계산해 조회하라.
select max(HIRE_DATE), min(HIRE_DATE),
       (to_date(max(HIRE_DATE)) - to_date(min(HIRE_DATE))) * 24 시간차
from EMPLOYEES; -- hire_date가 지금 varchar로 나와있음

-- 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력 ●●
select min(SALARY) from EMPLOYEES
where DEPARTMENT_ID = 100;

select DEPARTMENT_ID from EMPLOYEES
group by DEPARTMENT_ID
having min(SALARY) > ( select min(SALARY) from EMPLOYEES
where DEPARTMENT_ID = 100 );

-- 업무별로 최소 급여를 받는 사원의 모든 정보 출력 ●●
-- 단, 업무별로 정렬
select JOB_ID, min(SALARY) from EMPLOYEES
group by JOB_ID; -- 정보가 2개 이상이군

select * from EMPLOYEES
where (JOB_ID, SALARY) in ( select JOB_ID, min(SALARY) from EMPLOYEES
group by JOB_ID );

-- 가장 많은 사원이 속해 있는 부서 번호와 사원수를 출력 ( 부속질의문 OR fetch )
-- 부속질의문
select max(count(EMPLOYEE_ID)) from EMPLOYEES
group by DEPARTMENT_ID; -- 가장 많은 사원이 속해 있는 부서의 사원수

select DEPARTMENT_ID, count(EMPLOYEE_ID) 사원수 from EMPLOYEES
group by DEPARTMENT_ID
having count(EMPLOYEE_ID) = ( select max(count(EMPLOYEE_ID)) from EMPLOYEES
group by DEPARTMENT_ID );

-- fetch
select DEPARTMENT_ID, count(EMPLOYEE_ID) 사원수 from EMPLOYEES
group by DEPARTMENT_ID
order by 사원수 desc
fetch first 1 rows only;

-- 사원번호가 123인 사원의 직업과 같고 사원번호가 192인 사원의 급여보다 많은 사원의
-- 사원번호, 이름, 직업, 급여를 출력
select JOB_ID from EMPLOYEES
where EMPLOYEE_ID = 123; -- ST_MAN : 사원번호가 123인 사원의 직업

select SALARY from EMPLOYEES
where EMPLOYEE_ID = 192; -- 4000 : 사원번호가 192인 사원의 급여

select EMPLOYEE_ID, FIRST_NAME, JOB_ID, SALARY from EMPLOYEES
where JOB_ID = ( select JOB_ID from EMPLOYEES
where EMPLOYEE_ID = 123 ) and SALARY > ( select SALARY from EMPLOYEES
where EMPLOYEE_ID = 192 );

-- 50번 부서의 최소 급여 보다 많은 급여를 받는
-- 사원의 사원번호, 이름, 급여, 부서번호를 출력 ( 단, 50번은 제외 )
select min(SALARY) from EMPLOYEES
where DEPARTMENT_ID = 50; -- 2100 : 50번 부서의 최소 급여

select EMPLOYEE_ID, FIRST_NAME, SALARY, DEPARTMENT_ID from EMPLOYEES
where SALARY > ( select min(SALARY) from EMPLOYEES
where DEPARTMENT_ID = 50 ) and DEPARTMENT_ID <> 50;
