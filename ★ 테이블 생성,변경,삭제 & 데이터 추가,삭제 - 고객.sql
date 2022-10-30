-- https://url.kr/uho2lb

-- <테이블 생성> ------------------------------------

-- 예 7-1
-- 고객 테이블은 고객아이디, 고객이름, 나이, 등급, 직업, 적립금 속성으로 구성되고,
-- 고객아이디 속성이 기본키다. 고객이름과 등급 속성은 값을 반드시 입력해야하고,
-- 적립금 속성은 값을 입력하지 않으면 0이 기본으로 입력되도록 고객 테이블을 생성하라
create table Customers(
    cust_id varchar(100) primary key, -- 고객아이디
    cust_name varchar(100) not null, -- 고객이름
    cust_age int, -- 나이
    cust_grade varchar(100) not null, -- 등급
    cust_job varchar(100), -- 직업
    cust_milege int default 0 -- 적립금
);
-- 예 7-2
-- 제품 테이블은 제품번호, 제품명, 재고량, 단가, 제조업체 속성으로 구성되고,
-- 제품번호 속성이 기본키다. 재고량이 항상 0개 이상 10,000개 이하를 유지하도록
-- 제품 테이블을 생성하라
create table Products(
    prod_no varchar(100) primary key, -- 제품번호(영어+숫자)
    prod_name varchar(100), -- 제품명
    prod_stock int, -- 재고량 / check를 이용한 제약조건 공부하기 (수업에선 안배움)
    prod_price int, -- 단가
    prod_maker varchar(100) -- 제조업체
);

-- 예 7-3
-- 주문 테이블은 주문번호, 주문고객, 주문제품, 수량, 배송지, 주문일자 속성으로 구성되고
-- 주문번호 속성이 기본키다. 주문고객 속성이 고객 테이블의 고객아이디 속성을 참고하는 외래키이고,
-- 주문제품 속성이 제품 테이블의 제품번호 속성을 참조하는 왜래키가 되도록 주문 테이블을 생성하라
create table Orders(
    ord_no varchar(100) primary key, -- 주문번호
    ord_cust varchar(100), -- 주문고객
    ord_name varchar(100), -- 주문제품
    ord_amount int, -- 수량
    ord_addr varchar(100), -- 배송지
    ord_date date, -- 배송일자
    foreign key (ord_cust)
    references Customers(cust_id),
    foreign key (ord_name)
    references Products(prod_no)
);

-- 예 7-4
-- 배송업체 테이블은 업체번호, 업체명, 주소, 전화번호 속성으로 구성되고,
-- 업체번호 속성이 기본키다. 배송업체 테이블을 생성해보자.

create table deliverys (
    del_no int primary key ,
    del_name varchar(100),
    del_addr varchar(100),
    del_tellephone varchar(100)
);

-- <테이블 변경> ------------------------------------

-- 예 7-5
-- 고객 테이블에 가입날짜 속성을 추가해라
alter table Customers add cust_date datetime;

-- 예 7-6
-- 고객 테이블에 추가한 가입날짜 속성을 삭제해라
alter table Customers drop column cust_date;

-- 예 7-7
-- 고객 테이블에 20세 이상의 고객만 가입이 할 수 있다는 데이터 무결성 제약조건을 추가해라
alter table Customers add constraint ck_cust_age check(cust_age >= 20);

-- 예 7-8
-- 고객 테이블에 추가한 20세 이상의 고객만 가입이 할 수 있다는 데이터 무결성 제약조건을 삭제해라
alter table Customers drop constraint ck_cust_age;

-- <테이블 삭제> ------------------------------------
-- 예 7-9
-- 배송업체 테이블을 삭제해라
drop table deliverys;

-- <데이터 삽입> ------------------------------------
-- 예 7-47
-- 고객 테이블에 고객아이디 strawberry, 고객이름 최유경,
-- 나이가 30세, 등급이 vip, 직업이 공무원, 적립금이 100원인
-- 고객정보를 삽입하라 ( 2가지 )
insert into Customers
values ('strawberry', '최유경', 30, 'vip', '공무원', 100); -- (★★)

insert into Customers ( cust_id, cust_name, cust_age, cust_grade, cust_job, cust_milege)
values ('strawberry', '최유경', 30, 'vip', '공무원', 100);

-- 예 7-48
-- 고객 테이블에 고객아이디 tomato, 고객이름 정은심,
-- 나이가 36세, 등급이 gold, 직업은 모르고, 적립금이 4000원인
-- 고객정보를 삽입하라
insert into Customers
values ('tomato', '정은심', 36, 'gold', null, 4000);

-- <데이터 삭제> ------------------------------------
-- 예 7-47, 7-48에 추가된 데이터를 삭제하라
delete from Customers
where cust_id = 'strawberry'; -- 컬럼중에 아무거나 하나만 써도 다 날라가는군

delete from Customers
where cust_name = '정은심'; -- 컬럼중에 아무거나 하나만 써도 다 날라가는군
