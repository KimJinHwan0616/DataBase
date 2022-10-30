-- 사원 테이블에서 사원 이름을 소문자로 출력하세요
select lower(FIRST_NAME) from EMPLOYEES;

-- 사원 테이블에서 사원 이름의 첫글자만 대문자로 출력하세요.
select initcap(FIRST_NAME)from EMPLOYEES;

-- 사원 테이블에서 사원 이름의 길이를 출력하세요.
select length(FIRST_NAME) from EMPLOYEES;

-- LIKE를 사용하지않고
-- 사원 테이블에서 사원이름과 이름에 A가 몇번째 있는지 출력하세요.
select FIRST_NAME, instr(FIRST_NAME, 'A') from EMPLOYEES;

-- LIKE를 사용하지않고
-- 사원 테이블에서 사원이름의 세번째 자리가 R인 사원의 정보를 출력하세요. ( 2가지 )
-- 1
select FIRST_NAME, substr(FIRST_NAME, 3, 1) from EMPLOYEES
where substr(FIRST_NAME, 3, 1) = 'r';

-- 2
select FIRST_NAME, instr(FIRST_NAME, 'r') from EMPLOYEES
where instr(FIRST_NAME, 'r') = 3;


-- LIKE를 사용하지않고
-- 사원 테이블에서 이름의 끝자리가
-- N으로 끝나는 사원의 정보를 출력하세요.

select FIRST_NAME, substr(FIRST_NAME, -1, 1) from EMPLOYEES
where substr(FIRST_NAME, -1, 1) = 'n';


-- 사원들의 급여가 평균보다 큰 경우 '평균급여이상'이라 출력하고
-- 아닌 경우 '평균급여이하' 라고 출력하세요 ( 2가지 )
select round(avg(SALARY)) 평균급여 from EMPLOYEES;
-- 1
select SALARY, round (avg(SALARY) over()) 평균급여,
       case when SALARY < round(avg(SALARY) over (  )) then '평균급여이하'
            when SALARY >= round(avg(SALARY) over (  )) then '평균급여이상'
            end 급여평가
from EMPLOYEES;

-- 2
select sal, (select round(avg(sal)) from emp) 평균급여,
       case when sal > (select round(avg(sal)) from emp) then '평균급여이상'
            when sal < (select round(avg(sal)) from emp) then '평균급여이하'
            end 급여평가
from emp;

-- 사원의 급여에 대해 평균을 계산하고
-- 정수로 변환해서 출력하세요 (cast이용)
select cast ( avg(SALARY) as number(4,0)) from EMPLOYEES;


-- 사원들을 입사일자가 빠른 순으로
-- 정렬한 뒤 본인보다 입사일자가 빠른
-- 사원의 급여를 본인의 급여와 함께 출력하세요
-- 윈도우 함수 : lag, lead 사용
select FIRST_NAME, HIRE_DATE, SALARY,
        lag(salary) over (order by hire_date) 이전사원급여,
        lead(SALARY) over (order by HIRE_DATE) 이후사원급여
from EMPLOYEES order by HIRE_DATE;


-- BETWEEN 또는 LIKE를 사용하지않고
-- 2002 년도에 입사한 직원의 이름과
-- 월급을 출력하세요.
select FIRST_NAME, HIRE_DATE from EMPLOYEES
-- where substr(HIRE_DATE, 1, 4) = '2002' ;
-- where substr(HIRE_DATE, 3, 2) = '02' ;
where substr(HIRE_DATE, 4, 1) = '2' ;


-- 사원 테이블에서 사원의 이름이
-- 5글자인 사원의 이름을 첫글자만 대문자로 출력하세요.
select initcap(FIRST_NAME) from EMPLOYEES
where length(FIRST_NAME) = 5;


-- 사원 테이블에서 이름과 입사일자
-- 그리고 현재날까지의 경과일을 산출하세요
-- (소숫점을 빼버리고 해당이름을 경과일로 바꾸세요) (datediff이용)
select FIRST_NAME, HIRE_DATE,
    floor(sysdate - to_date(HIRE_DATE)) 경과일
from EMPLOYEES;

-- 이전문제에서 경과일을 개월수로 바꿔서
-- 산출하세요. 소숫점을 빼버리고
-- 해당이름을 경과개월수로 바꾸세요
-- (timestampdiff이용 - mairaDB 지원)
-- (months_between이용 - orcle 지원)
select FIRST_NAME, HIRE_DATE,
    concat ( floor (months_between(sysdate, HIRE_DATE)) , ' 개월') 경과월
from EMPLOYEES;


-- 사원 테이블에서 입사후 6개월이
-- 지난날짜 바로 다음 일요일을 구하세요.
select FIRST_NAME, HIRE_DATE,
    add_months( HIRE_DATE, 6) "6개월후",
    next_day(add_months( HIRE_DATE, 6), '일') "6개월후 다음 일요일"
from EMPLOYEES;

-- 교육시작일이 2020-11-02인 경우,
-- 5개월(18주)이 지난후 돌아오는 첫번째 금요일이
-- 언제인지 조회하세요 (5개월(18주) : 2021-03-08)
select '2020-11-02' 교육시작일,
       next_day(add_months('2020-11-02', 5), '금')
from dual;

-- 교육시작일이 2020-11-02인 경우,
-- 131일이 지난후 돌아오는 첫번째 금요일이
-- 언제인지 조회하세요 (131일후 : 2021-03-13)
select '2020-11-02' 교육시작일,
       next_day(to_date('2020-11-02')+ 131 , '금')
from dual;

-- 사원 테이블에서 입사후
-- 첫 휴일(일요일)은 언제일지 구하세요
select FIRST_NAME, HIRE_DATE,
    next_day(HIRE_DATE, '일') 첫휴일
from EMPLOYEES;

-- 오늘날짜를 "xx년 xx월 xx일" 형식으로 출력하세요
select to_char(sysdate , 'yyyy"년" mm"월" dd"일"') 오늘날짜
from dual;


-- 지금 현재 '몇시 몇분'인지 출력하세요.
-- AWS RDS의 시간은 미국 기준
-- 한국 기준시로 변경하고 싶다면 서버설정변경(time-zone) 필요
-- 한국은 UTC 기준 9시간 추가 : KST = UTC + 9
select to_char(
    sysdate + 9/24, 'pm hh24"시" mi"분"' ) 오늘시간
from dual;


-- 이번 년도 12월 31일까지 몇일이
-- 남았는지 출력하세요. (datediff이용)
select floor(to_date('2022-12-31', 'yyyy-mm-dd') - sysdate)
from dual;


-- 사원들의 입사일에서
-- 입사 년도와 입사 달을 조회하세요
select HIRE_DATE,
       substr(HIRE_DATE, 1, 4) 입사년도,
       substr(HIRE_DATE, 6, 2) 입사달 from EMPLOYEES;

-- 9월에 입사한 사원을 조회하세요
select FIRST_NAME, HIRE_DATE from EMPLOYEES
--where instr(HIRE_DATE, '09', 6) = 6; -- 6안쓰면 2009의 09에서 걸려버림
where substr(HIRE_DATE, 7, 1) = 9;


-- 사원들의 입사일을 출력하되,
-- 요일까지 함께 조회하세요
select HIRE_DATE, to_char(to_date(HIRE_DATE), 'yyyy-mm-dd day') from EMPLOYEES;


-- 사원들의 급여를 통화 기호를 앞에 붙이고
-- 천 단위마다 콤마를 붙여서 조회하세요
-- format(값, 반올림자릿수) : 숫자에 컴마를 붙여 출력
select FIRST_NAME, SALARY,
       to_char(SALARY, '$99,999') 적용,
        to_char(SALARY*1267.18, 'L999,999,999') 환율적용 -- 추가로 심심해서 해봄
       from EMPLOYEES;


-- 사원들의 급여를 10자리로 출력하되
-- 자릿수가 남는 경우 빈칸으로 채워서 조회하세요
-- _____12345
select FIRST_NAME, SALARY,
       to_char(SALARY, '9999999999') 공백남김,
       to_char(SALARY, '0000099999') "0으로채움",
       to_char(SALARY, 'FM9999999999') "공백제거"
       from EMPLOYEES;

-- 각 사원들의 입사한 달의 마지막 날을 조회하세요 (last_day이용)
select HIRE_DATE , last_day(HIRE_DATE) from EMPLOYEES;

-- 매니저와 그 매니저를 상사로 두고 있는 사원들의 연봉의 총합을 조회
select FNAME, EMPID, MGRID, sal,
        -- sum(SAL) over() 연봉총합 ,
        sum(SAL) over(partition by mgrid ) 매니저와사원연봉총합
from emp;

-- 사원들의 연봉이 높은 순서와 직책별로 높은 순으로 조회
select FNAME, JOBID, SAL,
        --rank() over(order by SAL desc) 연봉순위,
        rank() over(partition by jobid order by sal desc) 직책별연봉순위
from emp;

select FNAME, JOBID, SAL from emp
where jobid = 'IT_PROG';

-- 사원들을 입사일자가 빠른 순으로 정렬한 뒤
-- 본인과 이전/이후 사원간의 입사일의 차이를 조회
select FNAME, HDATE,
        lag(HDATE) over(order by HDATE) 이전입사일,
        lead(HDATE) over(order by HDATE) 이후입사일,
        to_date(hdate) - lag(to_date(HDATE)) over(order by HDATE) 이전입사일차이,
        to_date(hdate) - lead(to_date(HDATE)) over(order by HDATE) 이후입사일차이
from emp
order by HDATE;

-- HR 부서에서는 신규 프로젝트의 성공으로 해당하는
-- 각 업무 자들에 대한 급여인상을 시작했다.
-- 현재 107명의 사원은 19개의 업무에 소속되어 근무 중이다. (distinct job_id)
-- 이 중 5개의 업무 자들에 대한 급여 인상이 각각 결정되었고,
-- 나머지 업무에 대해서는 인상이 동결되었다 (107행).
-- HR_REP(10%), MK_REP(12%), PR_REP(15%), SA_REP(18%), IT_PROG(20%)
select FIRST_NAME, JOB_ID, SALARY 기존연봉,
        case when JOB_ID = 'HR_REP' then SALARY * 1.1
             when JOB_ID = 'MK_REP' then SALARY * 1.2
             when JOB_ID = 'PR_REP' then SALARY * 1.15
             when JOB_ID = 'SA_REP' then SALARY * 1.18
             when JOB_ID = 'IT_PROG' then SALARY * 1.2
        else SALARY
        end 수정된연봉
from EMPLOYEES;


select FIRST_NAME, JOB_ID, SALARY 기존연봉,
        decode (JOB_ID, 'HR_REP' ,SALARY * 1.1,
                        'MK_REP' ,SALARY * 1.2,
                        'PR_REP' ,SALARY * 1.15,
                        'SA_REP' ,SALARY * 1.18,
                        'IT_PROG' ,SALARY * 1.2, SALARY) 수정된연봉
from EMPLOYEES;