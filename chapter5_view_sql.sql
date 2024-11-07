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

CREATE VIEW v_member
as 
	select mem_id, mem_name, addr from member;
    
select * from v_member;

select mem_name, addr from v_member
	where addr in ('서울', '경기');
    
select B.mem_id, M.mem_name, B.prod_name, M.addr,
	CONCAT(M.phone1, M.phone2) '연락처'
    from buy B
		INNER JOIN member M
        on B.mem_id = M.mem_id;
        
create view v_memberbuy
as        
	select B.mem_id, M.mem_name, B.prod_name, M.addr,
		CONCAT(M.phone1, M.phone2) '연락처'
		from buy B
			INNER JOIN member M
			on B.mem_id = M.mem_id;
            
select * from v_memberbuy where mem_name = '블랙핑크';

use market_db;
drop view if exists v_viewtest1;
create view v_viewtest1
as
	select B.mem_id 'Member ID', M.mem_name AS 'Member Name',
    B.prod_name 'Product Name',
				concat(M.phone1, M.phone2) as 'office Phone'
	from buy B
		inner join member M
        ON B.mem_id = M.mem_id;

select distinct `Member ID`, `Member Name` from v_viewtest1;

alter view v_viewtest1
as
	select B.mem_id '회원 아이디', M.mem_name AS '회원 이름',
    B.prod_name '제품 이름',
				concat(M.phone1, M.phone2) as '연락처'
	from buy B
		inner join member M
        ON B.mem_id = M.mem_id;

select distinct `회원 아이디`, `회원 이름` from v_viewtest1;

desc v_viewtest1;

update v_member set addr = '부산' where mem_id='BLK';

SELECT * FROM V_MEMBER;

create view v_height167
as
	select * from member where height >= 167;
    
select * from v_height167;
SELECT * FROM member;
delete from v_height167 where height < 167;
delete from member where mem_id='TRA';

alter view v_height167
as 
	select * from member where height>=167
    with check option;
    
    
drop view v_height167;
insert into v_height167 values('TRA', '티아라', 6, '서울', NULL, NULL, 159, '2005-01-01');

DELETE FROM member WHERE mem_id='TOB';    
insert into v_height167 values('TOB', '텔레토비', 4, '영국', NULL, NULL, 140, '1995-01-01');

DELIMITER $$
	CREATE procedure USER_PROC()
    BEGIN
		SELECT * FROM MEMBER;
    END $$
DELIMITER ;

call user_proc();

USE MARKET_DB;
DROP PROCEDURE IF EXISTS user_proc1;
delimiter $$
create procedure user_proc1(in userName varchar(10))
begin
	select * from member where mem_name = userName;
end $$
delimiter ;
        
call user_proc1('에이핑크');

DROP PROCEDURE IF EXISTS user_proc2;
delimiter $$
create procedure user_proc2(
in userNumber int,
IN userHeight int
)
begin
	select * from member 
    where mem_number > userNumber and height > userHeight;
end $$
delimiter ;

call user_proc2(6,165);

create table if not exists noTable(
	id int auto_increment primary key,
    txt char(10)
);

delimiter $$
create procedure user_proc3(
	in txtValue char(10),
    out outValue int
)
begin
	insert into noTable values(null, txtValue);
	select max(id) into outValue from noTable;
end $$
delimiter ;

call user_proc3('테스트1', @myValue);
select concat('입력된 id값 ==> ' , @myValue);

select * from noTable;

delimiter $$
create procedure ifelse_proc(
	in memName varchar(10)
)
begin
	declare debutYear INT;
    select YEAR(debut_date) into debutYear from member
		where mem_name = memName;
	if(debutYear >= 2015) then
		select '신인 가수네요. 화이팅하세요.' as '메시지';
	else
		select '고참 가수네요. 그동안 수고하셨어요.' as '메시지';
	end if;
end $$
delimiter ;

call ifelse_proc('오마이걸');

drop procedure dynamic_proc;
delimiter $$
create procedure dynamic_proc(
	in tableName varchar(20)
)
begin
	set @sqlQuery = concat('select * from ', tableName);
    prepare myQuery from @sqlQuery;
    execute myQuery;
    deallocate prepare myQuery;
end $$
delimiter ;

call dynamic_proc ('member');

-- =========== 카페 만들기 ================
drop procedure dynamic_proc2;
delimiter $$
create procedure dynamic_proc2(
	in tableName varchar(20)
)
begin
	set @sqlQuery = concat('create table ', tableName, '(
		cafe_num int auto_increment primary key, 
        cafe_name varchar(10) not null,
        cafe_description text
    );');
    prepare myQuery from @sqlQuery;
    execute myQuery;
    deallocate prepare myQuery;
end $$
delimiter ;

call dynamic_proc2 ('magic');
drop table magic;
