-- ## 오라클 함수2 ## : 집계, 순위, 순서
-- select 함수(속성) over (partition by 속성 order by 속성)
-- from 테이블

-- <집계> (max, min, avg, sum, count) -----------------------------------
-- 부서별 사원 최대/최소/평균연봉, 연봉합계, 사원수 조회
select DEPARTMENT_ID,
    max(SALARY) over (partition by DEPARTMENT_ID order by SALARY) 최대연봉,
    min(SALARY) over (partition by DEPARTMENT_ID) 최소연봉,
    round(avg(SALARY) over (partition by DEPARTMENT_ID), 0) 평균연봉,
    sum(SALARY) over (partition by DEPARTMENT_ID) 연봉합계,
    count(EMPLOYEE_ID) over (partition by DEPARTMENT_ID) 사원수
from EMPLOYEES;

-- <순위> (rank, dense_rank, row_number) -----------------------------------
-- 전체 연봉 순위와 부서별 사원 연봉 순위 조회
select FNAME, DEPTID, SAL,
        rank() over( order by SAL desc) "전체연봉순위(동률O)",
        dense_rank() over( order by SAL desc) "전체연봉순위(동률O)",
        row_number() over( order by SAL desc) "전체연봉순위(동률X)",
        rank() over(partition by DEPTID order by SAL desc) 부서별연봉순위
from emp;

-- <순서> (lag, lead) -----------------------------------
-- 현재 회원 기준 이전 회원과의 마일리지 차이 계산후 조회
select CUST_NAME, CUST_MILEGE,
       lag(CUST_MILEGE) over (order by CUST_ID) 이전마일리지값,
       CUST_MILEGE - lag(CUST_MILEGE) over (order by CUST_ID) 이전마일리지차이
from CUSTOMERS;

select * from CUSTOMERS;

-- 현재 회원 기준 이후 회원과의 마일리지 차이 계산후 조회
select CUST_NAME, CUST_MILEGE,
       lead(CUST_MILEGE) over (order by CUST_ID) 이후마일리지값,
        CUST_MILEGE - lead(CUST_MILEGE) over (order by CUST_ID) 이후마일리지차이
from CUSTOMERS;

-- ## 오라클 함수3 ## : rollup, cube
-- rollup(속성1, 속성2, ...) : 속성1로 집계된 결과에서 추가로 속성2로 집계된 결과를 보여줌

-- 사원들의 부서별, 직책별 연봉 총합 조회
select DEPTID, JOBID, sum(sal) from emp
group by DEPTID, JOBID
order by DEPTID;

select DEPTID, JOBID, sum(sal) from emp
group by rollup(DEPTID, JOBID)
order by DEPTID;

-- cube(속성1, 속성2, ...) :

-- 직책별 연봉 총합
select JOBID, sum(sal) from emp
group by cube (JOBID); -- 맨위에 전체 연봉합이 표시

-- 사원들의 부서별, 직책별 연봉 총합 조회
select DEPTID, JOBID, sum(sal) from EMP
group by cube(DEPTID, JOBID);
        -- 처음엔 NULL인 값들의 연봉합이 표시
        -- 그다음엔 직책별 연봉합이 표시
        -- 마지막으로 부서별 연봉합과 부서별 직책별 연봉합이 표시

-- having절을 이용해서 부분별 소계를 표시
select DEPTID, JOBID, sum(sal) from EMP
group by cube(DEPTID, JOBID)
having grouping_id(DEPTID, JOBID) = 1; -- 부서별 총합

select DEPTID, JOBID, sum(sal) from EMP
group by cube(DEPTID, JOBID)
having grouping_id(DEPTID, JOBID) = 2; -- 직책별 총합

select DEPTID, JOBID, sum(sal) from EMP
group by cube(DEPTID, JOBID)
having grouping_id(DEPTID, JOBID) = 3; -- 연봉 총합
