-- DDL : 데이터베이스 생성하기 (Create)
CREATE DATABASE shop_db;
use shop_db;
-- DDL : 데이터베이스 조회하기 (Read)
show databases;
-- DDL : 데이터베이스 수정하기 (Update)
-- alter database shop_db rename to shop_dd;
ALTER SCHEMA shop_db  DEFAULT CHARACTER SET utf8  DEFAULT COLLATE utf8_unicode_ci ;
-- DDL : 데이터베이스 삭제하기 (Delete)
drop database shop_db;


-- DDL : 테이블 생성 (Create)
create table member(
	member_id char(8) not null primary key,
    member_name varchar(5) not null,
    member_addr char(20)
)default charset=utf8;
-- DDL : 테이블 초회하기 (Read)
desc member;
select * from member;
-- DDL : 테이블 수정하기 (Update)

-- DDL : 테이블 삭제 (Delete)
drop table member;

create table product(
	product_name char(4) not null primary key,
    cost int not null,
    make_date date,
    company char(5),
    amount int not null
)default charset=utf8;

desc product;

select * from product;

drop table product;
-- ----------------------------------------------------------------------------------------------
-- DML 


INSERT INTO member values('tess','나훈아','경기 부천시 중동');
INSERT INTO member values('hero','임영웅','서울 은평구 증산동');
INSERT INTO member values('iyou','아이유','인천 남구 주인동');
INSERT INTO member values('jyp','박진영','경기 고양시 장항동');
select * from member, product;

insert into product values('바나나',1500,'2021-07-01','델몬트',17);
insert into product values('카스',2500,'2022-03-01','OB',3);
insert into product values('삼각김밥',800,'2023-09-01','CJ',22);
select * from product;

-- 특정 컬럼만 추출하여 전체 행을 출력. (컬럼의 순서는 바뀌어도 상관없고 바뀐 순서대로 양식을 갖춰 출력된다.)
select member_name, member_addr from member;
-- 하나 또는 복수의 행을 검색할 때(전체 행은 아님)
select * from member where member_id = 'tess';

