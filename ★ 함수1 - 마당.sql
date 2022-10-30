-- https://url.kr/y75x2w
-- ## 오라클 함수1 ## : 숫자, 날짜/시간, 문자, 조건, NULL
-- select 함수() from 테이블

-- <숫자> -------------------------------------------------------------
-- 절대값
select abs(-4.5) from dual; -- dual : 오라클 기본 테이블
-- 반올림, 올림, 내림
select ceil(4.1)  from dual;
select floor(4.1) from dual;
select round(4.35, 1) from dual; -- 소수점 둘째자리에서 반올림
-- 거듭제곱 (값, 횟수)
select power(2, 2) from dual; -- 4
-- 제곱근
select sqrt(9) from dual; -- 3
-- 나머지
select mod(10, 3) from dual; -- 1

-- to_char(대상, 형식문자) : 숫자 -> 문자
-- 9는 유동 자리수, 0은 고정 자리수
select to_char(123.456, 'FM99999.99') "소수점 둘째짜리에서 반올림해서 문자변환1",
       to_char(123.456, 'FM00000.99') "소수점 둘째짜리에서 반올림해서 문자변환2",
       to_char(123456789, 'FM999,999,999') ",으로 문자변환",
       to_char(123456, 'FML999,999') "L로 원화 표시 문자변환"
from dual;

-- <날짜,시간> -------------------------------------------------------------
-- sysdate : 오라클 서버상의 시간/날짜
select sysdate from dual;

-- sysdate+9/24 : 우리나라 시간/날짜
select sysdate+9/24 from dual;

-- next_day(날짜, '요일') : 지정한 주의 요일 날짜 조회
select next_day(sysdate+9/24, '화') "화요일 날짜" from dual;

-- add_months(날짜, n) : n달 뒤 날짜 조회
select sysdate+9/24 오늘,
       add_months(sysdate+9/24, 1) "다음달",
       add_months(sysdate+9/24, -1) "이전달"
from dual;

-- last_day : 지정한 달의 마지막 날짜 조회
select last_day(sysdate+9/24) 마지막날 from dual;

-- to_char(대상, 형식문자) : 날짜 -> 문자
-- 년,월,일
select
        to_char(sysdate+9/24, 'yyyy / yyy,yy,y') "4자리 연도/4자리 연도의 마지막 3,2,1자리",
        to_char(sysdate+9/24, 'ww / q') "1년 중 주(1~52)/분기",
        to_char(sysdate+9/24, 'mm / month/ mon') "월(숫자)/월/월 약자",
        to_char(sysdate+9/24, 'dd / ddd') "1달 중 날짜(1~31) / 1년 중 날짜(1~365)",
        to_char(sysdate+9/24, 'd / day / dy') "요일 순서 / 요일 / 요일 약자",
                -- 요일 순서(1~7, 월=1)
        to_char(sysdate+9/24, 'DL') "날짜(요일O, 시간X)"
from dual;

-- 시,분,초
select
        to_char(sysdate+9/24, 'am') "오전,오후 표시",
        to_char(sysdate+9/24, 'hh / hh24') "12시간 / 24시간",
        to_char(sysdate+9/24, 'mi / ss') "분 / 초"
from dual;

-- 예
 select sysdate+9/24 "기본형식",
        to_char(sysdate+9/24, 'yyyy"년" mm"월" dd"일"') "년 월 일",
        to_char(sysdate+9/24, 'am HH24:MI:ss') "오전,오후 24시:분:초",
        to_char(add_months(sysdate+9/24, -1), 'yyyy-mm-dd') "이전달 날짜만",
        to_char(last_day(sysdate+9/24), 'yyyy/mm/dd') "마지막날 날짜만"
 from dual;


-- <문자> -------------------------------------------------------------
-- 소문자 & 대문자
select lower('HELLO, WORLD!!') 소문자,
       upper('hello, world!!') 대문자 from dual;

-- ASCII코드
select ascii(0), ascii('a') , ascii('A') from dual; -- 0,a,A 코드값 알아두기

-- ASCII코드 -> 문자
select chr(48), chr(97), chr(65) from dual; -- 0,a,A 코드값 알아두기

-- 첫 글자 대문자
select initcap('hellow, world!!') from dual;

-- 길이 ( 2가지 )
-- ■ length : 한글,영어 모두 1글자로 인식
select length('hello, world!!') from dual;
select length('안녕, 세상아!') from dual; -- 5

-- ■ lengthb : 한글만 DBMS 인코딩에 의해 2(euc-kr/win949) ~ 3(utf-8)글자로 인식
select lengthb('hello, world!!') from dual;
select lengthb('안녕, 세상아!') from dual; -- 18

-- 추출
-- substr(대상, 위치, 길이)
-- 오라클은 위치지정을 1부터 시작
select substr('hello, world!!', 8, 5) from dual;

-- 변경
-- replace(대상, 찾을문자, 바꿀문자)
select replace('hello, world!!', 'world', 'oracle') from dual;

-- 연결 ( 2가지 )
-- ■ concat : 최대 2개
select concat(' hello ', ' world ') from dual;
select concat(' hello ', ' world ', '!!') from dual; -- (X)

-- ■ || : 여러개 ( 오라클 전용 )
select ' hello ' || ' world ' || '!!' from dual;

-- 제거 ( 2가지 )
-- ■ 공백
select  ltrim('   abc123   ') 왼쪽공백제거,
        rtrim('   abc123   ') 오른쪽공백제거,
        trim('   abc123   ') 양쪽공백제거 from dual;

-- ■ 특정문자 ( 2가지 )
-- 1
select  ltrim('<=>abc123<=>', '<=>') 왼쪽문자제거,
        rtrim('<=>abc123<=>', '<=>') 오른쪽문자제거
       from dual;

-- 2
select trim (leading '0' from '00AA00') "선행문자제거",
        trim (trailing '0' from '00AA00') "후행문자제거",
        trim (both '0' from '00AA00') "선후행문자제거"
from dual;


-- 찾기 : instr(대상, 찾을문자, 찾을위치, 문자개수)
-- 위치의 시작값은 1부터
select instr('Hello, World!!', 'World') "World 위치",
       instr('Hello, World!!', 'l') "l 위치",
       instr('Hello, World!!', 'l', 8) "l을 8번째부터 찾음",
       instr('Hello, World!!', 'l', 2, 2) "l을 2번째부터 2개있는 위치 찾음"
       from dual;

-- 추가 : l,rpad(대상, 전체자리수, 추가할문자)
select lpad('oracle', 10, '#') "왼쪽 #추가",
       rpad('oracle', 10, '#') "오른쪽 #추가" ,
       lpad('oracle', 10) "왼쪽 공백추가",
       rpad('orcale', 10) "오른쪽 공백추가" from dual;

-- to_number(대상) : 문자 -> 숫자
select to_number('12345') 숫자변환 from dual;

-- cast(대상 as number) : 문자 -> 숫자
select cast('12345.67' as number) 숫자변환,
       cast('12345.67' as number(8,1)) "소수점 첫째자리까지 숫자변환"
from dual;

-- to_date(대상, 형식문자) : 문자 -> 날짜
select
       to_date('2022-05-02') "우리나라 식",
       to_date('05/02/2022', 'MM/DD/YY') "미국 식"
from dual;

-- <조건> -------------------------------------------------------------
-- CUSTOMERS 테이블에서
-- 회원등급이 vip면 '프리미엄', gold면 '우수'
-- sliver면 '우량', 그외에는 일반'이라 표시

-- decode(속성, 조건값1, 결과1, 조건값2, 결과2, ... , 결과n, 나머지결과)
select CUST_GRADE, decode(CUST_GRADE, 'vip', '프리미엄', 'gold', '우수',
    'silver', '우량', '일반') 회원등급 from CUSTOMERS;

-- case when 조건1 then 결과1
--      when 조건2 then 결과2
--              ...
--      else 나머지조건
--      end NEW_테이블_이름
select CUST_NAME, CUST_GRADE,
        case when CUST_GRADE = 'vip' then '프리미엄'
           when CUST_GRADE = 'gold' then '우수'
           when CUST_GRADE = 'silver' then '우량'
           else '일반'
        end 회원등급
from CUSTOMERS;

-- <NULL> -------------------------------------------------------------
-- NULL 값을 다른 값으로 변경
create table mybook(
    bookid number,
    price number
);
insert into mybook values (1, 10000);
insert into mybook values (2, 20000);
insert into mybook values (3, NULL);

select * from mybook;

-- NVL(속성, 값)
select price, nvl(price, 0) from mybook;

-- 4-10
-- 이름, 전화번호가 포함된 고객목록을 보이시오.
-- 단, 전화번호가 없는 고객은 '연락처없음'으로 표시한다.
select NAME,nvl(PHONE, '연락처없음') from CUSTOMER;

-- NVL(속성, 값1, 값2) : NULL X = 값1, NULL = 값2
select price, nvl2(price, 'NULL 없음', 'NULL 있음') from mybook;

-- NULLIF(속성, 값) : 속성(문자형만) = 값
select price, nullif(to_char(price), '10000') from mybook; -- 특정값을 NULL로 변경

-- coalesce(속성, 값) : 대상(숫자만) = 값
select price, coalesce(price, 0) from mybook;
