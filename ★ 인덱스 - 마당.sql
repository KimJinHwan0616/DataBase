-- 인덱스 : 데이터베이스 테이블에 대한 검색성능의 속도를 높여주는 역할
-- 주로 where/order by 에 사용
-- 단, 인덱스 관리를 위해 저장공간이 추가로 필요 (데이터베이스의 약 10%정도)
-- create index 인덱스_이름 on 테이블 (속성, ...)

-- 4-24
-- book 테이블의 bookname 컬럼에 인덱스 생성
create index IX_book on BOOK (BOOK_NAME);

-- 4-25
-- book 테이블의 publisher, price 컬럼에 인덱스 생성
create index IX_book2 on BOOK (BOOK_PUBLISHER, BOOK_PRICE);

-- 생성한 인덱스 ix_book를 조회
select * from USER_INDEXES
where TABLE_NAME = 'book';

-- 컬럼별 인덱스 정보 확인
select * from ALL_IND_COLUMNS
where TABLE_NAME = 'book';

-- 4-26
-- 생성한 인덱스를 재생성하기
alter index ix_book rebuild ;

-- 4-27
-- 생성한 인덱스 IX_book을 삭제
drop index ix_book;
