-- # 페이지 출력1 # : 12C 버전
-- select 속성1, 속성2, ... from 테이블
-- [order by 속성] [offset 시작줄 rows] fetch next/first/last 끝줄 rows only

select * from EMPLOYEES fetch first 10 rows only;       -- 0줄 ~ 10줄 출력
select * from EMPLOYEES offset 20 rows fetch next 10 rows only;     -- 20줄 ~ 30줄 출력
select * from EMPLOYEES fetch first 1 rows only;    -- 1줄 출력 ★★

-- # 페이지 출력2 # : 나머지 버전
-- select rownum from 테이블
-- where rownum <= 끝줄;

-- 사원들 중 가장 늦게 입사한 사원의 입사 날짜 2명만 조회
select * from
(select rownum , HIRE_DATE from EMPLOYEES
order by HIRE_DATE desc)
where rownum <= 2;

-- 사원들 중 연봉이 가장 많은 사원 10명만 조회
select rownum, e.* from
(select * from EMPLOYEES
order by SALARY desc) e
where rownum <= 10;

-- 사원들 중 연봉이 많은 사원 5명만 조회
-- 단, 연봉순으로 정렬했을때 11~15위에 해당하는 사원을 대상
select * from
(select * from EMPLOYEES order by SALARY desc)
where rownum <= 15
minus
select * from
(select * from EMPLOYEES order by SALARY desc)
where rownum <= 10;
