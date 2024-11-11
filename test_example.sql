create database test;

use test;

create table member(
	m_id varchar(15) primary key,
    m_name varchar (10) not null,
    m_age int null,
    m_grade varchar(10),
    m_job varchar(10),
    m_point int default 0
);

insert into member values('apple','정소화',20,'gold','학생',1000);
insert into member values('banana','김선우',25,'vip','간호사',2500);
insert into member values('carrot','고명석',28,'gold','교사',4500);
insert into member values('orange','김용욱',22,'silver','학생',0);
insert into member values('melon','성원용',35,'gold','회사원',5000);
insert into member values('peach','오형준',null,'silver','의사',300);
insert into member values('pear','채광주',31,'silver','회사원',500);

select * from member;

create table product(
	p_id varchar(4) primary key,
    p_name varchar(20),
    p_stock int,
    p_price int,
    p_maker varchar(10)
);

insert into product values('p01','그냥만두',5000,4500,'대한식품');
insert into product values('p02','매운쫄면',2500,5500,'민국푸드');
insert into product values('p03','쿵떡파이',3600,2600,'한빛제과');
insert into product values('p04','맛난초콜릿',1250,2500,'한빛제과');
insert into product values('p05','얼큰라면',2200,1200,'대한식품');
insert into product values('p06','통통우동',1000,1550,'민국푸드');
insert into product values('p07','달콤비스킷',1650,1500,'한빛제과');

select * from product;

create table orderTable(
	o_id varchar(4) primary key,
    o_member varchar(15),
    o_product varchar(4),
    o_stock int,
    o_ship varchar(20),
    o_date DATE,
    foreign key(o_member) references member(m_id),
    foreign key(o_product) references product(p_id)
);

insert into orderTable values('o01','apple','p03',10,'서울시 마포구','2019-01-01');
insert into orderTable values('o02','melon','p01',5,'인천시 계양구','2019-01-10');
insert into orderTable values('o03','banana','p06',45,'경기도 부천시','2019-01-11');
insert into orderTable values('o04','carrot','p02',8,'부산시 금정구','2019-02-01');
insert into orderTable values('o05','melon','p06',36,'경기도 용인시','2019-02-20');
insert into orderTable values('o06','banana','p01',19,'충청북도 보은군','2019-03-02');
insert into orderTable values('o07','apple','p03',22,'서울시 영등포구','2019-03-15');
insert into orderTable values('o08','pear','p02',50,'강원도 춘천시','2019-04-10');
insert into orderTable values('o09','banana','p04',15,'전라남도 목포시','2019-04-11');
insert into orderTable values('o10','carrot','p03',20,'경기도 안양시','2019-05-22');

select * from orderTable;

-- 예제 7-10
select m_id '고객아이디', m_name '고객이름', m_grade '고객등급' from member;
-- 예제 7-11
select * from member;

select p_maker as '제조업체' from product;


-- 예제 7-15 
-- distinct 와 group by 둘 다 같은 결과를 출력하지만 단순한 중복없는 고유값은 distinct가 맞다.
select distinct p_maker '제조업체' from product;
select p_maker '제조업체' from product
	group by p_maker;
    
-- 예제 7-17
select p_name, p_price+500 '제품단가' from product;    
    
-- 예제 7-18
select p_name, p_stock, p_price
	from product
    where p_maker='한빛제과';

-- 예제 7-19
select o_product, o_stock, o_date
	from orderTable
    where o_member='apple' and o_stock>=15;
    
select o_product, o_stock, o_date, o_member
	from orderTable
	where o_member='apple' or o_stock>=15;

select p_name, p_price, p_maker
	from product
    where p_price between 2000 and 3000;

-- ============== insert ====================

insert into member(m_id, m_name, m_age, m_grade, m_job, m_point) values('strawberry', '최유경', 30, 'vip', '공무원', 100);

select * from member;

insert into member(m_id, m_name, m_age, m_grade, m_point) values('tomato', '정은심', 36, 'gold', 4000);

-- =============== update ================
update product 
	set p_name='통큰파이'
    where p_id='p03';
    
update product
	set p_price = p_price * 1.1;

select * from product;

update orderTable
	set o_stock=5
    where o_member in (select m_id
						from member
						where m_name='정소화');
    
select * from orderTable;

-- ========= delete ================

delete from orderTable
	where o_date='2019-05-22';

select * from orderTable;

delete from orderTable
	where o_member in (select m_id
							from member
							where m_name='정소화');
                            
select * from orderTable;

delete from orderTable;

