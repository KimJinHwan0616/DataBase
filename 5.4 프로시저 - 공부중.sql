-- ## PL/SQL : 오라클 SQL 언어 ##
-- 선언부 / 실행부/ 예외처리부
-- 파이참에서 ctrl+F8로 DMBS_OUTPUT 출력 기능 활성화 !!

-- select 문 사용할 때,
-- 검색된 행의 수가 반드시 '하나' ( group, order by 사용 불가 )

-- 프로시저 1 ( declare : 익명 )
-- declare  # 선언부 (변수, 매개변수 설정)
-- begin    # 실행부
--
-- dbms_output.PUT_LINE(A: 속성);     # 출력
-- end;

-- 도서 총 가격, 평균 가격, 최대/최소 가격 출력하는 익명 프로시저 작성
declare
    sum_price number;
    avg_price number(10,1);
    max_price number;
    min_price number;
begin
    select sum(PRICE), avg(PRICE), max(PRICE), min(PRICE)
    into sum_price, avg_price, max_price, min_price from BOOKS;    -- into 중요

    DBMS_OUTPUT.PUT_LINE(sum_price ||','|| avg_price || ',' || max_price || ',' || min_price);
end;

-- 프로시저 2 ( procedure : 저장 )
-- create or replace procedure 이름(in/out/inout 매개변수)    # 선언부 (변수, 매개변수 설정)
-- is       # 실행부
-- begin
--
-- dbms_output.PUT_LINE(A: 속성);     # 출력
-- end;

-- exec 이름;  # 저장 프로시저 호출1 ( INTELLIJ 또는 PYCHARM 실행 불가!! )
-- begin    # 저장 프로시저 호출2
--     이름();
-- end;

-- 회원정보(아이디, 비번, 이름, 이메일)를 입력하는 저장 프로시저
create or replace procedure Member (
    id in varchar(100)
    passwo in Member.p
);

-- 사용자 정의 함수 ( function )
-- create or replace function 이름(매개변수)     # 선언부 (변수, 매개변수 설정)
-- return   # 실행부
-- is
-- begin
-- return
-- end;

-- select 이름 from dual;     # 호출


-- 3개의 정수를 입력 받아 더하고, 그 결과를 반환하는 함수 프로시저
create or replace function add_int(x, y, z)


-- 도서번호 입력시 상세 도서정보를 출력하는 함수 작성
-- showbookinfo(bookid)



-- 함수 실행 방법 2 --> ?? 나중에 다시하나보네

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

-- 함수가 아니라 프로시져이므로 실행불가!

-- intellij나 pycharm에서는 불가!
-- exec sayHello2;


-- 회원정보(아이디, 비번, 이름, 이메일)를 입력하는 프로시져 생성


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

    -- 커서 정의 : select문을 실행한 후 결과를 저장해 둠

    -- 커서를 호출하여 rs변수에 저장해두고
    -- 반복처리를 통해 행별로 값을 읽어 결과 출력

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


-- 트리거 작성
-- create or replace trigger 이름
-- 이벤트 정의 테이블명
-- 이벤트 발생시 처리코드



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


-- 상품이 입고되는 경우 재고량을 변화시키는 트리거 작성

-- 계층형 구조 작성하기
-- 부모, 자식간의 관계를 깊이가 존재하는 트리형태로 표현
-- 보통 카테고리를 분류나 조직도에 많이 사용

-- select 컬럼들 from 테이블 [where 조건]
-- start with 최상위조건
-- connected by 계층조건

-- 사원과 상사의 관계를 계층형 구조로 나타내기




