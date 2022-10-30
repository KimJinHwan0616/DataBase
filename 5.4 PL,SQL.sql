-- --------------------------------------------------------------------
-- PL/SQL
-- 데이터베이스 응용프로그램 개발에 사용하는 오라클의 SQL 전용언어
-- SQL문으로 처리하기 어려운 문제를 해결
-- 기존의 SQL문으로는 반복/비교/오류 처리 불가능
-- SQL문 자체를 보안상의 이유로 캡슐화하기 어려움
-- Oracle : PL/SQL          Microsoft : T-SQL

-- create procedure/function 명령으로 생성
-- 생성된 프로시져나 함수는 execute 명령으로 실행함
-- 오류 발생시 show errors 명령으로 확인

-- 익명 프로시져 : declare 문으로 시작
-- 저장 프로시져 : create procedure 문으로 시작
-- 사용자 정의 함수 : create function 문으로 시작

-- PL/SQL 의 구조 : 선언부/실행부/예외처리부

-- 익명 프로시져 : 프로시져 이름 없음
-- pycharm에서 ctrl+F8로 DMBS_OUTPUT 출력 기능 활성화 필요
begin   -- PL/SQL 블럭 시작 의미 (실행부)
        dbms_output.PUT_LINE('hello, World!!');
end;    -- PL/SQL 블럭 끝 의미


declare         -- 선언부 (변수,상수 정의)
    msg varchar(100);
    vNAME varchar(10);
    vAge number;
begin           -- 실행부
    msg := 'Hello, World, again!!';         -- 변수에 값 대입
    vNAME := '송혜교';         -- 변수에 값 대입
    vAge := 35;         -- 변수에 값 대입

    dbms_output.PUT_LINE(msg);
    dbms_output.PUT_LINE(vNAME);
    dbms_output.PUT_LINE(vAge);

    dbms_output.PUT_LINE(vNAME || '/' ||vAge);       -- 값을 붙여서 출력
end;

-- 테이블 조회 익명 프로시져
-- 1번 도서를 조회해서 결과 표시 (단, 결과는 반드시 1행 존재해야함)
declare
    vbkname varchar(100);
begin
    -- select 컬럼명 into 변수명
    select bookname into vbkname from BOOKS
    where BOOKID = 1;

    dbms_output.PUT_LINE((vbkname));
end;

-- 도서 총 가격, 평균 가격, 최대/최소 가격을
-- 출력하는 익명 프로시져 작성

declare
    sumprice number ;
    avgprice number(10,1);
    maxprice number ;
    minprice number ;
begin
    -- select 컬럼명 into 변수명
    select sum(PRICE), avg(PRICE), max(PRICE), min(PRICE)
    into sumprice , avgprice, maxprice, minprice from BOOKS;

    dbms_output.PUT_LINE(sumprice || ',' || avgprice
    || ',' || maxprice || ',' || minprice);
end;

-- 도서번호를 하나 입력받아 그 번호에 해당하는 도서 제목과 출판사 출력
declare
             -- vbookid varchar(10) := '&bookid';
    vbookid varchar(10);
    vbkname varchar(100);
    vpublish varchar(100);
begin
    select bookname, PUBLISHER
    into vbkname, vpublish
            -- from BOOKS where BOOKID = vbookid;
    from BOOKS where bookid = :vbookid;

    dbms_output.PUT_LINE(vbkname || ',' || vpublish);
end;

-- sqldeveloper에서 실행해보기 ( 여기서는안됨 )
set serveroutput on
accept bookid prompt '도서번호를 입력하세요'

declare
    vbookid varchar(10) := '&bookid';
    vbkname varchar(100);
    vpublish varchar(100);
begin
    select bookname, PUBLISHER
    into vbkname, vpublish
    from BOOKS where BOOKID = vbookid;

    dbms_output.PUT_LINE(vbkname || ',' || vpublish);
end;

-- PL/SQL에서 select 문 사용시 주의사항
-- 검색된 행의 수가 '하나'여야 한다는 것
-- 검색 결과는 into 절을 이용해서 변수에 저장해야 함
-- order by 절은 사용불가

-- 변수에 저장된 값은 dbms_output.put_line()을
-- 이용해서 출력 가능
-- 검색된 결과가 작거나(no_data_found)
-- 많으면(too_many_rows) 오류 발생!

-- 프로시져 procedure
-- 익명 프로시져는 선언부에 정의하고 실행부에서 호출되어 실행
-- 실행할때 마다 컴파일되어야 하므로 속도가 느림
-- 다른 PL/SQL에서 호출해서 사용 불가 : 코드 재사용 불가

-- 익명 프로시져의 주 용도는 코드 실행 후 테스트 목적
-- 한번 실행하고나면 메모리에서 없어지는 휘발성 코드
-- 실행한 코드를 데이터베이스 내에 남겨
-- 재사용을 가능하게 하려면 함수나 프로시져를 작성

-- 사용자 정의 함수
-- 오라클은 내장함수를 통해 다양한 기능을 제공
-- 사용자가 임의로 코드를 작성해서 함수를 만들수 있음
-- 함수는 매개변수(입력값)를 받아 뭔가를 처리하고
-- 그 결과를 반환하는 데이터베이스 객체

-- create or replace function [-] (매개변수,...)
-- return 데이터유형;
-- is
-- 함수 몸체 블록

-- 간단한 인사말을 출력하는 sayHello 함수
create or replace function sayHello
    return varchar
is
begin
    return ('Hello, World!!');
end;

select sayHello() from dual;

-- 3개의 정수를 입력받아 더하고, 그 결과를 반환하는 함수
-- addPlus(x, y, z)
create or replace function addPlus(x number,y number,z number)
    return number
is
begin
    return (x+y+z);
end;

select addPlus(10,15,25) from dual;

-- 도서번호 입력시 상세 도서정보를 출력하는 함수 작성
-- showbookinfo(bookid)
create or replace function showbookinfo(bkid number)
    return varchar
is
    bkname varchar(100);
    pubname varchar(100);
    price number;
begin
    select  BOOKNAME, PUBLISHER, PRICE
    into bkname, pubname, price from BOOKS
    where BOOKID = bkid;

    return (bkname || ',' || pubname || ',' || price);
end;

select showbookinfo(1) from dual;

-- 함수 실행 방법 2 --> ?? 나중에 다시하나보네
variable info varchar(100); -- 1회용 변수 선언
exec :info := showbookinfo(1); -- 함수를 실행하고 결과를 변수에 저장


-- 저장 프로시져
-- PL/SQL 블록 외부에 선언해서 데이터베이스에 저장
-- PL/SQL 블록을 별도로 작성하므로 프로그램이 단순-모듈화
-- 서버 부하도 줄이고, 네트워크 트래픽도 감소-효율성
-- PL/SQL, 트리거, 각종 응용프로그램등에서 호출가능-재사용성
-- 프로그램 관리가 용이 - 유지보수성

-- CREATE OR REPLACE PROCEDURE 이름(IN/OUT/INOUT 매개변수목록)
-- IS
-- BEGIN
-- END;

-- 매개변수 : 입력/출력/겸용 전용 매개변수를 정의
-- 매개변수 유형을 정의하지 않으면 기본적으로 IN으로 설정
-- OUT 매개변수는 프로시져 내에서 코드를 실행한 후 결과를
-- 매개변수에 저장해서 프로시져 외부에서 참조할 수 있게 함


-- 매개변수 기본값 지정
-- 프로시져 실행시 반드시 매개변수의 갯수에 맞춰
-- 값을 전달해서 실행해야 함
-- 만약, 매개변수를 하나라도 누락하면 오류발생

-- 하지만, 매개변수에 기본값을 지정하면
-- 프로시져 실행시 해당 매개변수는 값을 전달 X



create or replace procedure sayHello2
is
begin
        dbms_output.PUT_LINE('Hello, World!!');
end;

-- 함수가 아니라 프로시져이므로 실행불가!
select sayHello2 from dual;

-- intellij나 pycharm에서는 불가!
-- exec sayHello2;

begin
    sayHello2();
end;

-- 회원정보(아이디, 비번, 이름, 이메일)를 입력하는 프로시져 생성
create or replace procedure  newMember(
    puserid IN varchar,
    ppasswd IN MEMBER.PASSWORD%type,
    pname IN MEMBER.NAME%type,
    pemail IN MEMBER.EMAIL%rowtype
)
is
begin
    insert into member (USERID, PASSWORD, NAME, EMAIL)
    values (puserid, ppasswd, pname, pemail);

    DBMS_OUTPUT.PUT_LINE('입력완료!!');
end; -- 왜 빨간색줄이뜨지??


begin
    NEWMEMBER('abc','987',
        '123','456')
end;

-- 커서 cursor
-- 이전 예제에서 select 문의 실행결과를 하나만 처리했었음
-- 한편, 오라클에서는 select 문의 실행결과로 복수행이
-- 반환되는 경우, cursor로 처리하도록 지원

-- 커서는 질의결과로 얻어진 복수행 집합 중
-- 각 행의 위치를 의미 : 결과집합에서 하나의 행을 읽어옴

-- 커서에는 암시적implicit/명시적explicit 커서가 존재
-- 일반적으로 암시적 커서는 단일행을 결과로 반환
-- 여러 행을 결과로 반환하는 SQL문에는 명시적 커서가 사용

-- cursor [이름] open  fetch  close 형식으로 커서를 정의
-- 정의된 커서는 for  loop  end loop 문으로 처리 : 결과출력
-- 커서의 속성을 제공하는 특수한 명령 지원 : %rowcount, %notfound, %isopen

-- 부서번호에 따라 사원들의 성, 직책을 조회하는 프로시져
create or replace procedure show_deptid(
    pdeptid EMP.DEPTID%type
)
is
    -- 커서 정의 : select문을 실행한 후 결과를 저장해 둠
    cursor cs_dept(pdeptno EMP.DEPTID%type)
    is
        select LNAME, JOBID from EMP
            where DEPTID = pdeptno;
begin
    -- 커서를 호출하여 rs변수에 저장해두고
    -- 반복처리를 통해 행별로 값을 읽어 결과 출력
    for rs in cs_dept(pdeptid)
    loop
        DBMS_OUTPUT.PUT_LINE(rs.LNAME || ',' || rs.JOBID);
        end loop;
end;


begin
    SHOW_DEPTID(50);
end;

-- 트리거 trigger
-- 테이블에 어떤 이벤트가 발생할때 실행되는 특수한 프로그램
-- 실행 주체는 개발자가 아니고 데이터베이스 임
-- 즉, 수동으로는 실행불가, 시스템에 의해 자동실행후 처리
-- 이벤트 : insert, update, delete, create, alter, drop 등
--

-- 성적테이블에 새로운 값이 입력되면 '입력!' 이라고 출력
-- 성적테이블에 기존 값이 수정되면 '수정!' 이라고 출력
-- 성적테이블에 값이 삭제되면 '삭제!' 라고 출력

-- 성적테이블 (이름,국어,영어,수학,총점,평균)
create table SUNGJUK (
    name varchar(10),
    kor number,
    eng number,
    mat number,
    tot number,
    avg number(5,1)
);

insert into SUNGJUK values ('헤교',99,96,95,297,99);
select * from SUNGJUK;

-- 트리거 작성
-- create or replace trigger 이름
-- 이벤트 정의 테이블명
-- 이벤트 발생시 처리코드
create or replace trigger check_sungjuk
after insert or update or delete on sungjuk
begin
    CASE
        WHEN inserting then dbms_output.PUT_LINE('입력');
        WHEN updating then dbms_output.PUT_LINE('수정');
        WHEN deleting then dbms_output.PUT_LINE('삭제');
        END CASE;
end;


insert into SUNGJUK values ('수지',99,96,95,297,99);
update SUNGJUK set avg = 99.3 where name = '수지';
delete from SUNGJUK where name = '수지';

-- 트리거의 종류
-- 문장 트리거 : 트리거 이벤트에 의해 단 한번만 실행
--              각 컬럼의 값을 제어할 수 없음
-- 행 트리거 : 컬럼의 각 행에 이벤트가 발생할 때마다 실행
--              각 컬럼의 값을 제어할 수 있음 (:new, :old)
--              트리거에 for each row 라는 문장 추가

-- 'is mutating, trigger/function may not see it' 오류발생시
-- 주로 행 트리거 사용시 종종 보는 오류
-- 해결책 : 행 트리거를 문장 트리거로 변경 - for each row 제거

-- 성적테이블에 데이터가 생성되면 생성이력을 남겨두는 트리거 작성
create table sj_history(
    name varchar(10),
    tot number,
    avg number(5,1),
    regdate date    default sysdate+9/24
);

create or replace trigger check_sj_history
before insert on SUNGJUK
    for each row    -- 행 기반 트리거
begin
    IF inserting THEN
        insert into sj_history (name, tot, avg)
        values (:new.name, :new.tot, :new.avg);
    END IF;
end;

insert into SUNGJUK values ('지현',85,75,65,215,85.5);
select * from sj_history;

-- 상품이 입고되는 경우 재고량을 변화시키는 트리거 작성
create table product_history (
    pcode varchar(5),       -- 상품코드
    pname varchar(20),      -- 상품명
    amount number           -- 입고량
);

create table pstock(
    pcode varchar(5),       -- 상품코드
    stock number           -- 재고량
);

insert into pstock values ('A1298', 100);

create or replace trigger stock_changing
after insert on product_history
for each row
begin
        update pstock set stock = stock + :new.amount
        where pcode = :new.pcode ;
end;
select * from pstock;

insert into product_history values ('A1298', '컴퓨터', 50);
select * from pstock;

-- 계층형 구조 작성하기
-- 부모, 자식간의 관계를 깊이가 존재하는 트리형태로 표현
-- 보통 카테고리를 분류나 조직도에 많이 사용

-- select 컬럼들 from 테이블 [where 조건]
-- start with 최상위조건
-- connected by 계층조건

-- 사원과 상사의 관계를 계층형 구조로 나타내기
select FNAME, EMPID, level, MGRID from EMP -- level 컬럼은 가상컬럼
start with MGRID is not null -- mgrid가 null이 아닌 대상
connect by prior EMPID = MGRID; -- mgrid를 기준으로 empid를 나열

select empid, DEPTID, JOBID, level,
       lpad(' ', 3*LEVEL) || fname from emp
start with MGRID is not null -- 상사번호가 null인 상사를 기준으로
connect by prior EMPID = MGRID; -- 사원들을 조회

select empid, DEPTID, JOBID, level,
       lpad(' ', 3*LEVEL) || fname from emp
start with MGRID = 120 -- 상사번호가 120인 상사를 기준으로
connect by prior EMPID = MGRID; -- 사원들을 조회






