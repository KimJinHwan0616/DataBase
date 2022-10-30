-- https://url.kr/wu6tfx
-- ------------------------------------------------------------
create table BOOK(
    book_no int,
    book_name varchar(100),
    book_publisher varchar(100),
    book_price int
);
alter table BOOK add constraint pk_book primary key (book_no);
-- alter table BOOK drop primary key; 기본키 제약조건 제거

select * from BOOK;
-- ------------------------------------------------------------
create table CUSTMOER (
    cust_no int,
    cust_name varchar(100),
    cust_addr varchar(100),
    cust_phone varchar(100)
);
alter table CUSTMOER add constraint pk_cust primary key (cust_no);

select * from CUSTMOER;
-- ------------------------------------------------------------
create table ORDERBOOK (
    order_no int,
    cust_no int,
    book_no int,
    sale_price int,
    order_date date
);

alter table ORDERBOOK add constraint pk_order primary key (order_no);
alter table ORDERBOOK add constraint fk_order
foreign key (cust_no) references CUSTMOER(cust_no);
alter table ORDERBOOK add constraint fk_book
foreign key (book_no) references BOOK(book_no);

select * from ORDERBOOK;
-- ------------------------------------------------------------
INSERT INTO BOOK VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO BOOK VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO BOOK VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO BOOK VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO BOOK VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO BOOK VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO BOOK VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO BOOK VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO BOOK VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO BOOK VALUES(10, 'Olympic Champions', 'Pearson', 13000);
INSERT INTO BOOK VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO BOOK VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

INSERT INTO CUSTMOER VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO CUSTMOER VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO CUSTMOER VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO CUSTMOER VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO CUSTMOER VALUES (5, '박세리', '대한민국 대전',  NULL);

INSERT INTO ORDERBOOK VALUES (1, 1, 1, 6000, '2014-07-01');
INSERT INTO ORDERBOOK VALUES (2, 1, 3, 21000, '2014-07-03');
INSERT INTO ORDERBOOK VALUES (3, 2, 5, 8000, '2014-07-03');
INSERT INTO ORDERBOOK VALUES (4, 3, 6, 6000, '2014-07-04');
INSERT INTO ORDERBOOK VALUES (5, 4, 7, 20000, '2014-07-05');
INSERT INTO ORDERBOOK VALUES (6, 1, 2, 12000, '2014-07-07');
INSERT INTO ORDERBOOK VALUES (7, 4, 8, 13000,  '2014-07-07');
INSERT INTO ORDERBOOK VALUES (8, 3, 10, 12000, '2014-07-08');
INSERT INTO ORDERBOOK VALUES (9, 2, 10, 7000, '2014-07-09');
INSERT INTO ORDERBOOK VALUES (10, 3, 8, 13000, '2014-07-10');

-- ------------------------------------------------------------
-- 3-28
-- 가장 비싼 도서의 이름을 조회
select book_name from BOOK
where book_price = ( select max(book_price) from BOOK );

-- 3-29
-- 도서를 구매한 적이 있는 고객의 이름을 조회 ●●
select cust_no from ORDERBOOK
where cust_no is not null; -- 1,2,3,4

select cust_name from CUSTMOER
where cust_no in ( select cust_no from ORDERBOOK
where cust_no is not null );

-- 3-30
-- 대한미디어에서 출판한 도서를 구매한 고객이름 조회
select book_no from BOOK
where book_publisher = '대한미디어'; -- 3,4

select cust_no from ORDERBOOK
where book_no in ( select book_no from BOOK
where book_publisher = '대한미디어' ); -- 1

select cust_name from CUSTMOER
where cust_no = ( select cust_no from ORDERBOOK
where book_no in ( select book_no from BOOK
where book_publisher = '대한미디어' ) ) ;

-- 3-31
-- 출판사별로 출판사의 도서 평균가격보다 비싼 도서를 조회 ●●
create or replace view BOOK1
AS
    select book_publisher, avg(book_price) 평균가격 from BOOK
group by book_publisher;
select * from BOOK1;

select book_name from BOOK inner join  BOOK1
    using(book_publisher)
where BOOK.book_price > BOOK1.평균가격 ; -- 상관부속질의

-- 3-32
-- 도서를 주문하지 않은 고객의 이름 조회 ( 차집합 )
select * from CUSTMOER
minus -- 오라클에서만 사용가능
select cust_name from CUSTMOER
where cust_no not in ( select cust_no from ORDERBOOK
where cust_no is not null );

-- 3-33
-- 주문이 있는 고객의 이름, 주소 조회 ( EXISTS 사용 ) ●●
select cust_name, cust_addr from CUSTMOER c
where exists( select * from ORDERBOOK o
    where c.cust_no = o.cust_no );

-- <연습문제> ------------------------------------------------------------
-- 1-5
-- 박지성이 구매한 도서의 출판사 수
select cust_no from CUSTMOER
where cust_name = '박지성'; -- 1 : 박지성의 고객번호

select book_no from ORDERBOOK
where cust_no = ( select cust_no from CUSTMOER
where cust_name = '박지성' ); -- 1,2,3 : 박지성이 구매한 도서번호

select count( distinct book_publisher ) 출판사수 from BOOK
where book_no in ( select book_no from ORDERBOOK
where cust_no = ( select cust_no from CUSTMOER
where cust_name = '박지성' ) );

-- 1-6
-- 박지성이 구매한 도서명, 가격, 정가와 판매가격의 차이 ●●
select book_name, book_price, book_price - sale_price  from CUSTMOER inner join  ORDERBOOK
using(cust_no) inner join BOOK
using(book_no)
where cust_name = '박지성';

-- 1-7
-- 박지성이 구매하지 않은 도서의 이름
select book_name from BOOK
where book_no not in ( select book_no from ORDERBOOK
where cust_no = ( select cust_no from CUSTMOER
where cust_name = '박지성' ) );

-- 2-8
-- 주문을 한번도 하지 않은 고객 조회 ( 하의질의문 )
select distinct cust_no from ORDERBOOK
where book_no is not null; -- 1,2,3,4 주문한 고객의 고객번호

select cust_name from CUSTMOER
where cust_no not in ( select distinct cust_no from ORDERBOOK
where book_no is not null );

-- 2-9
-- 주문 금액의 평균금액과 총금액 조회
select avg(sale_price), sum(sale_price) from ORDERBOOK;

-- 2-10
-- 고객이름과 고객별 주문금액 조회
select cust_name, sum(sale_price) from CUSTMOER inner join  ORDERBOOK
using(cust_no)
group by cust_name;

-- 2-11
-- 고객이름과 주문한 도서목록 조회
select cust_name, book_name from CUSTMOER inner join  ORDERBOOK
using(cust_no) inner join  BOOK
using(book_no);

-- 2-12
-- 도서의 가격과 판매가격의 차이가 가장 큰 주문 조회 ●●
select order_no, max ( book_price - sale_price ) from BOOK inner join  ORDERBOOK
using(book_no);

-- 2-13
-- 도서 평균 판매액보다 고객의 평균구매액이 높은 고객이름 조회 ●●
select avg(sale_price) from ORDERBOOK; -- 도서 평균 판매액

select cust_name from BOOK inner join  ORDERBOOK
using(book_no) inner join  CUSTMOER
using(cust_no)
group by cust_name
having avg(sale_price) > ( select avg(sale_price) from ORDERBOOK );

-- <연습문제> ------------------------------------------------------------
-- 1-1
-- 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
select cust_no from CUSTMOER
where cust_name = '박지성'; -- 1 : 박지성의 고객번호

select book_no from ORDERBOOK
where cust_no = ( select cust_no from CUSTMOER
where cust_name = '박지성' ) ; -- 1,2,3 : 박지성이 구매한 도서번호

select book_publisher from BOOK
where book_no in ( select book_no from ORDERBOOK
where cust_no = ( select cust_no from CUSTMOER
where cust_name = '박지성' )  ); -- 굿스포츠, 대한미디어, 나무수 : 박지성이 구매한 도서의 출판사

select cust_name from ORDERBOOK inner join CUSTMOER
using(cust_no) inner join  BOOK
using(book_no)
where book_publisher in ( select book_publisher from BOOK
where book_no in ( select book_no from ORDERBOOK
where cust_no = ( select cust_no from CUSTMOER
where cust_name = '박지성' )  ) )
and cust_name <> '박지성';

-- 1-2
-- 서로 다른 출판사에서 도서를 구매한 고객이름 조회 ●●
select cust_name from CUSTMOER inner join  ORDERBOOK
using(cust_no) inner join  BOOK
using(book_no)
group by cust_name
having count( distinct book_publisher ) >= 2;

-- 1-3
-- 전체 고객의 30% 이상이 구매한 도서 조회 ●●
select count(cust_no) * 0.3 from CUSTMOER; -- 1.5명 : 전체 고객의 30%

select book_name from CUSTMOER inner join  ORDERBOOK
using(cust_no) inner join  BOOK
using(book_no)
group by book_name
having count(cust_no) >= (select count(cust_no) * 0.3 from CUSTMOER);
