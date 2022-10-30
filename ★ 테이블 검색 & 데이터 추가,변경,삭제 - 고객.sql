insert into Customers
values ('apple', '정소화', 20, 'gold', '학생', 1000);
insert into Customers
values ('banana', '김선우', 25, 'vip', '간호사', 2500);
insert into Customers
values ('carrot', '고명석', 28, 'gold', '교사', 4500);
insert into Customers
values ('orange', '김용욱', 22, 'silver', '학생', 0);
insert into Customers
values ('melon', '성원용', 35, 'gold', '회사원', 5000);
insert into Customers
values ('peach', '오형준', null, 'silver', '의사', 300);-- 'null'이 아니라 null로 입력해야하는구나!!
insert into Customers
values ('pear', '채광주', 31, 'silver', '회사원', 500);

--
insert into Products
values ('p01', '그냥만두', 5000, 4500, '대한식품');
insert into Products
values ('p02', '매운쫄면', 2500, 5500, '민국푸드');
insert into Products
values ('p03', '쿵떡파이', 3600, 2600, '한빛제과');
insert into Products
values ('p04', '맛난초콜릿', 1250, 2500, '한빛제과');
insert into Products
values ('p05', '얼큰라면', 2200, 1200,'대한식품');
insert into Products
values ('p06', '통통우동', 1000, 1550,'민국푸드');
insert into Products
values ('p07', '달콤비스킷', 1650, 1500,'한빛제과');

--

insert into Orders
values ('o01', 'apple', 'p03', 10, '서울시 마포구', '2022-01-01');
insert into Orders
values ('o02', 'melon', 'p01', 5, '인천시 계양구', '2022-01-10');
insert into Orders
values ('o03', 'banana', 'p06', 45, '경기도 부천시', '2022-01-11');
insert into Orders
values ('o04', 'carrot', 'p02', 8, '부산시 금정구', '2022-02-01');
insert into Orders
values ('o05', 'melon', 'p06', 36, '경기도 용인시', '2022-02-20');
insert into Orders
values ('o06', 'banana', 'p01', 19, '충청북도 보은군', '2022-03-02');
insert into Orders
values ('o07', 'apple', 'p03', 22, '서울시 영등포구', '2022-03-15');
insert into Orders
values ('o08', 'pear', 'p02', 50, '강원도 춘천시', '2022-04-10');
insert into Orders
values ('o09', 'banana', 'p04', 15, '전라남도 목포시', '2022-04-11');
insert into Orders
values ('o10', 'carrot', 'p03', 20, '경기도 안양시', '2022-05-22');

-- <데이터 검색> ------------------------------------
-- [기본] ------------------------------------
-- 예 7-10
-- 고객 테이블에서 고객아이디, 고객이름, 등급 속성을 검색하라
select cust_id, cust_name, cust_grade from Customers;

-- 예 7-11,12
-- 고객 테이블에 존재하는 모든 속성을 검색하라
select * from Customers;

-- 예 7-13, 14
-- 제품 테이블에서 제조업체를 검색하라
select prod_maker from Products;

-- 예 7-15
-- 제품 테이블에서 제조업체 속성을 중복 없이 검색하라
select distinct prod_maker from Products;

-- [산술] ------------------------------------
-- 예 7-17
-- 제품 테이블에서 제품명, 단가를 검색하되, 단가에 500원을 더해 '조정단가' 라는 새 이름으로 출력하라
select prod_name, prod_price + 500 조정단가 from Products;

-- [조건] ------------------------------------
-- 예 7-18
-- 제품 테이블에서 한빛제과가 제조한 제품의 제품명, 재고량, 단가를 검색하라
select prod_name, prod_stock, prod_price from Products
where prod_maker = '한빛제과';

-- 예 7-19
-- 주문 테이블에서 apple 고객이 15개 이상 주문한 주문제품, 수량, 주문일자를 검색하라
select ord_name, ord_amount, ord_date from Orders
where ord_cust = 'apple' and ord_amount >= 15;

-- 예 7-20
-- 주문 테이블에서 apple 고객이 주문했거나 15개 이상 주문된 제품의
-- 주문제품, 수량, 주문일자, 주문고객을 검색해라

select ord_name, ord_amount, ord_date, ord_cust from Orders
where ord_cust = 'apple' or ord_amount >= 15;

-- 예 7-21
-- 제품 테이블에서 단가가 2000원 이상이면서 3000원 이하인 제품의
-- 제품명, 단가, 제조업체를 검색해라

select prod_name, prod_price, prod_maker from Products
where prod_price between 2000 and 3000;

-- [키워드] ------------------------------------

-- 예 7-22
-- 고객 테이블에서 성이 김 씨인 고객의 고객이름, 나이, 등급, 적립금을 검색해라
select cust_name, cust_age, cust_grade, cust_milege from Customers
where cust_name like '김%';

-- 예 7-23
-- 고객 테이블에서 고객아이디가 5자인 고객의 고객아이디, 고객이름, 등급을 검색하라
select cust_id, cust_name, cust_grade from Customers
where cust_id like '_____';
-- 또는
select cust_id, cust_name, cust_grade from Customers
where length(cust_id)=5; -- 뒤에가서 함수 배움

-- [NULL] ------------------------------------
-- 예 7-24
-- 고객 테이블에서 나이가 아직 입력되지 않은 고객의 고객이름을 검색하라
select cust_name from Customers
where cust_age is null;

-- 예 7-25
-- 고객 테이블에서 이미 나이가 입력된 고객의 고객이름을 검색하라
select cust_name from Customers
where cust_age is not null;

-- [정렬] ------------------------------------
-- 예 7-26
-- 고객 테이블에서 고객이름, 등급, 나이를 검색하되
-- 나이를 기준으로 내림차순(desc)으로 정렬하라
select cust_name, cust_grade, cust_age from Customers
order by cust_age desc; -- 오라클에서는 제대로 작동함 마리아만 반대로됬음

-- 예 7-27 ( ★★ )
-- 주문 테이블에서 수량이 10개 이상인 주문의
-- 주문고객, 주문제품, 수량, 주문일자를 검색해라
-- ( 단, 주문제품은 오름차순, 수량은 내림차순으로 정렬해라 )

select ord_cust, ord_name, ord_amount, ord_date from Orders
where ord_amount >= 10
order by ord_name, ord_amount desc;

-- [집계함수] ------------------------------------
-- 예 7-28
-- 제품 테이블에서 모든 제품의 단가 평균을 검색해라
select avg(prod_price ) from Products;

-- 예 7-29
-- 한빛제과에서 제조한 제품의 재고량 합계를 제품 테이블에서 검색해라
select sum(prod_stock) from Products
where prod_maker = '한빛제과';

-- 예 7-30
-- 고객 테이블에 고객이 몇 명 등록되어 있는지 검색해라
-- 1. 고객아이디 속성을 이용해 계산 ( 추천 )
select count(cust_id) from Customers ;
-- 2. 나이 속성을 이용해 계산 -> null 이 포함되어있어서 잘못세는경우가 많음
select count(cust_age) from Customers ;
-- 3. *를 이용해 계산 ( 비추천 )
select count(*) from Customers ;

-- 예 7-31
-- 제품 테이블에서 제조업체의 수를 검색하라
select count(distinct prod_maker) from Products;

-- [그룹!!별!!] ------------------------------------
-- 예 7-32
-- 주문 테이블에서 주문제품별 수량의 합계를 검색해라
select ord_name 주문제품, sum(ord_amount) 총주문수량 from Orders
group by 주문제품;

-- 예 7-33
-- 제품 테이블에서 제조업체별로 제조한 제품수와 제품 중 가장비싼단가를 검색하되,
-- 제품의 개수는 '제품수' 라는 이름으로 출력하고
-- 가장비싼단가는 '최고가'라는 이름으로 출력해라
SELECT prod_maker 제조업체, count(prod_no) 제품수, max(prod_price) 가장비싼단가
FROM Products
group by prod_maker;

-- 예 7-34
-- 제품 테이블에서 제품을 3개 이상 제조한 제조업체 별로 제품수와
-- 제품 중 가장비싼단가를 검색해라
select prod_maker, count(prod_no), max(prod_price)
from Products
group by prod_maker
having count(prod_no) >= 3;

-- 예 7-35
-- 고객 테이블에서 적립금평균이 1000원 이상인 등급에 대해
-- 등급별 고객수와 적립금평균을 검색해라
select cust_grade 등급, count(cust_id) 고객수, round(avg(cust_milege)) 적립금평균
from Customers
group by cust_grade
having 적립금평균 >= 1000;

-- 예 7-36 ●●
-- 주문 테이블에서 각 주문고객이 주문한 제품의 총주문수량을 주문제품별로 검색해라
select ord_name 주문제품, ord_cust 주문고객, sum(ord_amount) 총주문수량 from Orders
group by ord_name, ord_cust;

-- [내부 JOIN] ------------------------------------
-- 예 7-37 ●●
-- banana 고객이 주문한 제품의 이름을 검색해라 ( 3가지 )
select * from Products, Orders; -- 서로 다른 테이블에 중복되는 목록 먼저확인

-- 1
select prod_name from Orders, Products
where Products.prod_no = Orders.ord_name
and ord_cust = 'banana'; -- 2번,3번을 잘 알아두기
-- 2
select prod_name from Orders o inner join Products p
on o.ord_name = p.prod_no -- 서로 다른 테이블에서 서로 다른 속성 이름일 때 사용하자
where ord_cust = 'banana';
-- 3
select prod_name from Orders o inner join Products p
using (ord_name) -- 서로 다른 테이블에서 서로 같은 속성 이름일 때 사용하자
where ord_cust = 'banana';

-- 예 7-38
-- 나이가 30세 이상인 고객이 주문한 제품번호, 주문일자를 검색해라
select * from Customers, Orders;

select ord_name 제품번호, ord_date 주문일자 from Customers c inner join Orders o
on c.cust_id = o.ord_cust
where cust_age >= 30;

-- 예 7-39
-- 고명석 고객이 주문한 제품의 제품명을 검색해라
select * from Orders, Products, Customers;

select prod_name from Orders o inner join Products p
on o.ord_name = p.prod_no inner join Customers c
on o.ord_cust = c.cust_id
where cust_name = '고명석';

-- [외부 JOIN] ------------------------------------
-- 단, 마리아DB에서는 외부 JOIN 지원하지않음 / 다른거부터 일단하자
-- 주문하지 않은 고객도 포함해서 고객이름, 주문제품, 주문일자를 검색 ●●

-- [부속질의문] ------------------------------------
-- 예 7-40
-- 달콤비스킷을 생산한 제조업체가 만든 제품들의 제품명과 단가를 검색하라
select prod_maker 제조업체 from Products
where prod_name = '달콤비스킷'; -- 한빛제과


select prod_name 제품명, prod_price 단가 from Products
where prod_maker = ( select prod_maker 제조업체 from Products
where prod_name = '달콤비스킷' );

-- 예 7-41 ●●
-- 적립금이 가장 많은 고객의 고객이름, 적립금을 검색하라
select max(cust_milege) from Customers; -- 5000

select cust_name 고객이름, cust_milege 적립금 from Customers
where cust_milege = ( select max(cust_milege) from Customers );

-- 예 7-42
-- banana 고객이 주문한 제품의 제품명, 제조업체를 검색하라
select ord_name from Orders
where ord_cust = 'banana'; -- p6, p1, p4

select prod_name 제품명, prod_maker 제조업체 from Products
where prod_no in ( select ord_name from Orders
where ord_cust = 'banana');

-- 예 7-43
-- banana 고객이 주문하지 않은 제품의 제품명, 제조업체를 검색하라
select prod_name 제품명, prod_maker 제조업체 from Products
where prod_no not in ( select ord_name from Orders
where ord_cust = 'banana');

-- 예 7-44 ●●
-- 대한식품이 제조한 모든 제품의 단가보다 비싼 제품의 제품명, 단가, 제조업체 검색하라
select prod_price from Products
where prod_maker = '대한식품'; -- 4500, 1200


select prod_name 제품명, prod_price 단가, prod_maker 제조업체 from Products
where prod_price > all ( select prod_price from Products -- ALL을 이용하여 2개값을 다 포함!!
where prod_maker = '대한식품' );

-- 예 7-45
-- 2022년 3월 15일에 제품을 주문한 고객이름 검색하라 ( 2가지 )
-- 1 부속질의문
select ord_cust from Orders
where ord_date = '2022-03-15'; -- apple

select cust_name 고객이름 from Customers
where cust_id = ( select ord_cust from Orders
where ord_date = '2022-03-15' );

-- 2 exsit문 ( 나중에 심화로 보기 ) ●●
select cust_name 고객이름 from Customers c
where exists(select * from Orders o
                where ord_date = '2022-03-15'
                and c.cust_id = o.ord_cust);

-- 예 7-46
-- 2022년 3월 15일에 제품을 주문하지 않은 고객의 고객이름 검색하라 ( 2가지 )
-- 1
select cust_name 고객이름 from Customers
where cust_id not in ( select ord_cust from Orders
where ord_date = '2022-03-15' );

-- 2
select cust_name 고객이름 from Customers c
where not exists(select * from Orders o
                where ord_date = '2022-03-15'
                and c.cust_id = o.ord_cust);

-- <데이터 추가(부속질의문)> ------------------------------------
-- 한빛제과에서 제조한 제품명, 재고량, 단가를 제품 테이블에서 검색하여
-- 한빛제품이라는 테이블에 추가 ●●

select prod_name, prod_stock, prod_price from Products
where prod_maker = '한빛제과';

create table 한빛제품 (
    prod_name   varchar(100),
    prod_stock  int,
    prod_price int
);

insert into 한빛제품
select prod_name, prod_stock, prod_price from Products
where prod_maker = '한빛제과';


select * from  한빛제품;

-- <데이터 변경> ------------------------------------
-- ★★ 실행하기전에 'tx: 수동'으로 해놓고 하기 ★★
-- 예 7-49 ●●
-- 제품 테이블에서 제품번호가 p03인 제품의 제품명을 통큰파이로 수정해라
update Products
set prod_name = '통큰파이'
where prod_no = 'p03'; -- 롤백 누르기

select * from Products;

-- 예 7-50 ●●
-- 제품 테이블에 있는 모든 제품의 단가를 10% 인상해라
update Products
set prod_price = prod_price * 1.1; -- 롤백 누르기

select * from Products;

-- 예 7-51
-- 정소화 고객이 주문한 제품의 제품수량을 5개로 수정해라
select cust_id from Customers
where cust_name = '정소화';

update Orders
set ord_amount = 5
where ord_cust = ( select cust_id from Customers
where cust_name = '정소화' ); -- 롤백 누르기

select * from Orders;

-- <데이터 삭제> ------------------------------------
-- ★★ 실행하기전에 'tx: 수동'으로 해놓고 하기 ★★
-- 예 7-52
-- 주문 테이블에서 주문일자가 2022년 5월 22일인 주문 내역을 삭제하라
delete from Orders
where ord_date = '2022-05-22'; -- 롤백 누르기

select * from Orders;

-- 예 7-53
-- 정소화 고객이 주문한 내역을 주문 테이블에서 삭제해라
select cust_id from Customers
where cust_name = '정소화'; -- apple

delete from Orders
where ord_cust = ( select cust_id from Customers
where cust_name = '정소화' ); -- 롤백 누르기

select * from Orders;

-- 예 7-54
-- 주문 테이블에 존재하는 모든 데이터 제거해라
delete from Orders; -- 롤백 누르기
