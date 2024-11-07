DROP DATABASE IF EXISTS market_db; -- 만약 market_db가 존재하면 우선 삭제한다.
CREATE DATABASE market_db;

USE market_db;
CREATE TABLE member -- 회원 테이블
( mem_id  		CHAR(8) NOT NULL PRIMARY KEY, -- 사용자 아이디(PK)
  mem_name    	VARCHAR(10) NOT NULL, -- 이름
  mem_number    INT NOT NULL,  -- 인원수
  addr	  		CHAR(2) NOT NULL, -- 지역(경기,서울,경남 식으로 2글자만입력)
  phone1		CHAR(3), -- 연락처의 국번(02, 031, 055 등)
  phone2		CHAR(8), -- 연락처의 나머지 전화번호(하이픈제외)
  height    	SMALLINT,  -- 평균 키
  debut_date	DATE  -- 데뷔 일자
);
CREATE TABLE buy -- 구매 테이블
(  num 		INT AUTO_INCREMENT NOT NULL PRIMARY KEY, -- 순번(PK)
   mem_id  	CHAR(8) NOT NULL, -- 아이디(FK)
   prod_name 	CHAR(6) NOT NULL, --  제품이름
   group_name 	CHAR(4)  , -- 분류
   price     	INT  NOT NULL, -- 가격
   amount    	SMALLINT  NOT NULL, -- 수량
   FOREIGN KEY (mem_id) REFERENCES member(mem_id)
);

INSERT INTO member VALUES('TWC', '트와이스', 9, '서울', '02', '11111111', 167, '2015.10.19');
INSERT INTO member VALUES('BLK', '블랙핑크', 4, '경남', '055', '22222222', 163, '2016.08.08');
INSERT INTO member VALUES('WMN', '여자친구', 6, '경기', '031', '33333333', 166, '2015.01.15');
INSERT INTO member VALUES('OMY', '오마이걸', 7, '서울', NULL, NULL, 160, '2015.04.21');
INSERT INTO member VALUES('GRL', '소녀시대', 8, '서울', '02', '44444444', 168, '2007.08.02');
INSERT INTO member VALUES('ITZ', '잇지', 5, '경남', NULL, NULL, 167, '2019.02.12');
INSERT INTO member VALUES('RED', '레드벨벳', 4, '경북', '054', '55555555', 161, '2014.08.01');
INSERT INTO member VALUES('APN', '에이핑크', 6, '경기', '031', '77777777', 164, '2011.02.10');
INSERT INTO member VALUES('SPC', '우주소녀', 13, '서울', '02', '88888888', 162, '2016.02.25');
INSERT INTO member VALUES('MMU', '마마무', 4, '전남', '061', '99999999', 165, '2014.06.19');

INSERT INTO buy VALUES(NULL, 'BLK', '지갑', NULL, 30, 2);
INSERT INTO buy VALUES(NULL, 'BLK', '맥북프로', '디지털', 1000, 1);
INSERT INTO buy VALUES(NULL, 'APN', '아이폰', '디지털', 200, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '아이폰', '디지털', 200, 5);
INSERT INTO buy VALUES(NULL, 'BLK', '청바지', '패션', 50, 3);
INSERT INTO buy VALUES(NULL, 'MMU', '에어팟', '디지털', 80, 10);
INSERT INTO buy VALUES(NULL, 'GRL', '혼공SQL', '서적', 15, 5);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 2);
INSERT INTO buy VALUES(NULL, 'APN', '청바지', '패션', 50, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 1);
INSERT INTO buy VALUES(NULL, 'APN', '혼공SQL', '서적', 15, 1);
INSERT INTO buy VALUES(NULL, 'MMU', '지갑', NULL, 30, 4);

SELECT * FROM member;
SELECT * FROM buy;

-- SELECT는 선택하여 출력하겠다는 것.
select '하이';

-- member 테이블의 모든 데이터를 출력하겠다는 명령어
select * from member;


select mem_name from member;
-- mem_name에 별칭을 붙이는 것.
select mem_name as '멤버명' from member;

select addr '주소', debut_date '데뷔일자', mem_name '멤버이름' from member;

select mem_id, mem_name
	from member
    where height <=162;
    
select * from member where mem_name='블랙핑크';

select * from member where mem_number='4';

select mem_name, height, mem_number 
	from member
	where height >= 165 AND mem_number>6;
    
select mem_name '그룹이름', height '키'
	from member
    where height between 163 and 165;

-- select mem_name, addr from member where addr='경기' or addr='전남' or addr='경남';
select mem_name, addr
	from member
    where addr in('경기', '전남', '경남');
    
select * from member
	where mem_name like '우%';
    
select * from member
	where mem_name like '__핑크';
    
select height from member where mem_name = '에이핑크';

select mem_name, height from member
		where height > (select height from member where mem_name = '에이핑크');
						-- 164
-- =========================================================
-- order by =====================================    
select mem_id, mem_name,debut_date
	from member
    order by debut_date;
    
select mem_id, mem_name, debut_date
	from member
    order by debut_date desc;
    
select mem_id, mem_name, debut_date, height
	from member
    where height >= 164
    order by height desc;

-- ==================  LIMIT ============================
select * from member limit 3;

select mem_name, debut_date
	from member
    order by debut_date
    limit 3;
-- ==================  distinct ============================
select distinct addr from member;


-- ==================  group by ============================
select mem_id, amount from buy order by mem_id;
select mem_id, sum(amount) from buy;

select mem_id, sum(amount) from buy group by mem_id;

select mem_id, sum(amount) '총 구매 갯수' from buy group by mem_id;

select mem_id '회원 아이디', sum(price*amount) '총 구매 금액' from buy group by mem_id;

select mem_id '그룹명', avg(amount) '평균 구매 개수' from buy group by mem_id order by avg(amount) desc;

select count(*) from member;
-- null은 제외하고 개수를 출력해준다.
-- 그래서 null이 없는 column을 선택하는 것이 중요하다. PK는 null이 존재할 수 없는 영역.
select count(phone1) '연락처가 있는 회원' from member;

select count(mem_id) 'NULL이 존재하지 않는 column' from member;

select * from buy;

select mem_id '회원 아이디', sum(price*amount) '총 구매금액'
	from buy
    group by mem_id
    having sum(price*amount) > 1000;
    
create table test(
	a int,
    b int
);

select * from test;

insert into test values(10, 5);
insert into test(a) values(20);

select a, sum(a*b) '결과' from test group by a;

use market_db;

create table hongong1(
	toy_id int,
    toy_name varchar(4),
    age int
);

select * from hongong1;

-- column을 지정하여 추가 가능
insert into hongong1 values(1, '우디', 25);
insert into hongong1(toy_id, toy_name) values(2, '버즈');
insert into hongong1(toy_name, age, toy_id) values('제시', 20, 3);


create table hongong2(
	toy_id int auto_increment primary key,
    toy_name varchar(4),
    age int
);

select * from hongong2;

insert into hongong2 values(null, '보핍', 25);
insert into hongong2 values(null, '슬링키', 22);
insert into hongong2 values(null, '렉스', 21);
select * from hongong2;

select last_insert_id();

alter table hongong2 auto_increment=100;
insert into hongong2 values(null, '재남', 35);
select * from hongong2;

-- show global variables;

use world;

select * from city;

select count(*) from city;

select * from city limit 5;

create table city_popul (
city_name varchar(35),
population int);

insert into city_popul select name, population from world.city;
select * from city_popul;


-- ==================  update  ============================
use market_db;

update city_popul
	set city_name = '서울'
    where city_name = 'Seoul';

select * from city_popul where city_name = '서울';

update city_popul
	set city_name = '뉴욕' , population = 0
    where city_name = 'New York';
    
select * from city_popul where city_name = '뉴욕';

update city_popul
	set population = population / 10000;
 
 select * from city_popul where city_name='뉴욕';
 
-- ==================  drop  ============================
delete from test;

select * from city_popul;

delete from city_popul
	where city_name like 'New%';
    
-- ==================  DataType   ============================
-- ============ variable ============
use market_db;

set @myVar1 = 5;
set @myVar2 = 4.25;

select @myVar1;
select @myVar1 + @myVar2;

set @txt = '가수이름==>';
set @height = 166;
select @txt, mem_name from member where height > @height;

set @count = 3;
-- java:
-- PreparedStatement pstmt = null;
-- String sql = ""; 아래 쿼리가 해당 역할.
prepare mySQL from 'select mem_name, height from member order by height limit ?';
-- pstmt = conn.create(sql);
-- pstmt = setxxx("@count");
-- pstmt.executeQuery();
-- set()과 execute()를 같이 하는 것.
execute mySQL USING @count;

select convert(avg(price), signed) '평균가격' from buy;

select cast(('2022%12%12') as date);
select convert(('2022%12%12') , date) '날짜';

select num, concat(cast(price as char),'x',cast(amount as char),'=')
	'가격x수량', price*amount '구매액'
    from buy;
    
select '100'+'200';
select concat('100','200');

select concat(100, '200');
select 100 + '200';
-- ==================  Join  =========================

-- select * from buy inner join member on buy.mem_id = member.mem_id where buy.mem_id='GRL';
select * from buy
	inner join member
    on buy.mem_id = member.mem_id
where buy.mem_id = 'GRL';
-- JOIN 은 어떤 속성을 선택할 것인지 앞에 테이블. 을 붙여 명확히 해주는 것이 좋다.
select buy.mem_id, mem_name, prod_name, addr, concat(phone1, phone2) '연락처'
	from buy
    inner join member
    on buy.mem_id = member.mem_id;
    
-- 테이블 옆에 alias 를 붙여 B, M 처럼 별칭을 사용하는 것도 가능하다.
select M.mem_id, M.mem_name, B.prod_name, M.addr
	from buy B
		inner join member M
        ON B.mem_id = M.mem_id
	order by M.mem_id;
    
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
	from member M
		left outer join buy B
        ON M.mem_id = B.mem_id
	order by M.mem_id;
    
select M.mem_id, M.mem_name, B.prod_name, M.addr
	from member M
		inner join buy B
        ON M.mem_id = B.mem_id
	order by M.mem_id;
    
SELECT M.mem_id, M.mem_name, B.prod_name, M.addr
	from member M
		right outer join buy B
        ON M.mem_id = B.mem_id
	order by M.mem_id;
    
select M.mem_id, M.mem_name, B.prod_name, M.addr
	from buy B
		inner join member M
        ON M.mem_id = B.mem_id
	order by M.mem_id;
    
create table emp_table(
	emp char(4),
    manager char(4),
    phone varchar(8));

insert into emp_table values('대표',NULL, '0000');
insert into emp_table values('영업이사','대표', '1111');
insert into emp_table values('관리이사','대표', '2222');
insert into emp_table values('정보이사','대표', '3333');
insert into emp_table values('영업과장','영업이사', '1111-1');
insert into emp_table values('경리부장','관리이사', '2222-1');
insert into emp_table values('인사부장','관리이사', '2222-2');
insert into emp_table values('개발팀장','정보이사', '3333-1');
insert into emp_table values('개발주임','정보이사', '3333-1-1');

select A.emp '직원' , B.emp '직속상관', B.phone '직속상관 연락처'
	from emp_table A
		INNER JOIN emp_table B
        on A.manager = B.emp
	where A.emp = '경리부장';

-- ================= stored procedure ===========

drop procedure if exists ifProc3;
delimiter $$
create procedure ifProc3()
begin 
	declare debutDate date;
    declare curDate date;
    declare days int;
	
    select debut_date into debutDate
		from market_db.member
        where mem_id = 'APN';
        
	set curDate = CURRENT_DATE();
    set days = DATEDIFF(curDate, debutDate);
    
    if(days/365) >= 5 then
		select concat('데뷔한 지 ', days, '일이나 지났습니다. 핑순이들 축하합니다!');
	else
		select '데뷔한 지' + days + '일밖에 안됐네요. 핑순이들 화이팅~';
	end if;
end $$
delimiter ;
call ifProc3();

select mem_id, sum(price*amount) '총구매액'
	from buy
	group by mem_id;
    
select mem_id, sum(price*amount) '총구매액'
	from buy
	group by mem_id
    order by sum(price*amount) desc;
    
select B.mem_id, M.mem_name, sum(price*amount) '총구매액'
	from buy B
		inner join member M
        on B.mem_id = M.mem_id
        
	group by B.mem_id
    order by sum(price*amount) desc;
    
select M.mem_id, M.mem_name, sum(price*amount) '총구매액'
	from buy B
		right outer join member M
        on B.mem_id = M.mem_id
	group by M.mem_id
    order by sum(price*amount) desc;
    
select M.mem_id, M.mem_name, sum(price*amount) '총구매액',
	CASE
		WHEN (sum(price*amount)>= 1500) THEN '최우수고객'
        WHEN (sum(price*amount)>= 1000) THEN '우수고객'
        WHEN (sum(price*amount)>= 1) THEN '일반고객'
        ELSE '유령고객'
    END '회원등급'    
	from buy B
		right outer join member M
        on B.mem_id = M.mem_id
	group by M.mem_id
    order by sum(price*amount) desc;

USE market_db;
-- ============ while ======================

drop procedure if exists whileProc;
delimiter $$
create procedure whileProc()
begin
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    while(i <= 100) do
		set hap = hap + i;
        set i = i + 1;
    end while;
    select '1부터 100까지의 합 ==>' , hap;
end$$
delimiter ;
call whileProc();

drop procedure if exists whileProc;
delimiter $$
create procedure whileProc()
begin
	declare i int;
    declare hap int;
    set i = 1;
    set hap = 0;
    
    myWhile:
    while(i <= 100) do
		if(i%4 = 0) then	
			set i = i+1;
            iterate myWhile;
		end if;
		set hap = hap + i;
        if(hap > 1000) then
			leave myWhile;
		end if;
        set i = i + 1;
    end while;
    select '1부터 100까지의 합(4의 배수 제외), 1000이 넘으면 종료 ==>' , hap;
end$$
delimiter ;
call whileProc();

-- ===================  기출문제  ===================
use test10;
create table customor(
	c_id varchar(20),
    c_name varchar(10) not null,
    c_age int,
    c_rank varchar(10) not null,
    c_job varchar(20),
    c_money int default 0,
    primary key(c_id)
);
drop table customor;

create table product(
	p_id char(3),
    p_name varchar(20),
    p_unit int,
    p_price int,
    p_maker varchar(20),
    primary key (p_id),
    check (p_unit>=0 and p_unit <= 10000)
);

create table orders(
	o_number char(3),
    o_customer varchar(20),
    o_product char(3),
    o_unit int,
    o_addr varchar(30),
    o_date DATE,
    primary key(o_number),
    foreign key(o_customer) references customor(c_id),
    foreign key(o_product) references product(p_id)
);

create table shipping(
	s_num char(3),
    s_name varchar(20),
    s_addr varchar(100),
    s_call varchar(20),
    primary key(s_num)
);

select * from customor, product, orders, shipping;

alter table customor add regist_day DATE;

alter table customor drop column regist_day;

alter table customor add constraint CHK_AGE check(c_age>=20);

alter table customor drop constraint chk_age;
