create database naver_db;

use naver_db;

create table member(
	id varchar(5) primary key,
    name varchar(10) not null,
    count int not null,
    addr varchar(20) not null,
    phone1 varchar(3),
    phone2 varchar(8),
	height varchar(3) not null,
    debute_day DATE not null
);

create table buy(
	num int auto_increment primary key,
    id varchar(3),
    product varchar(20)  not null,
    category varchar(10),
    price int not null,
    amount int not null,
    foreign key(id) references member(id)
);

select * from member;

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

select B.id, B.product from buy B
	inner join member M
    on B.id = M.id;
    
use naver_db;
drop table if exists buy, member;
create table member(
	mem_id char(8) not null primary key,
    mem_name varchar(10) not null,
    height tinyint unsigned null
);

describe member;

drop table if exists member;
create table member(
	mem_id char(8),
    mem_name varchar(10) not null,
    height tinyint unsigned null,
    primary key(mem_id)
    -- constraint primary key pk_member_mem_id (mem_id)
);
	
drop table if exists member;
create table member(
	mem_id char(8) not null,
    mem_name varchar(10) not null,
    height tinyint unsigned null
);    

alter table member
	add constraint
    primary key(mem_id);

create table buy(
	num int auto_increment not null primary key,
    mem_id char(8) not null,
    prod_name char(6) not null,
    foreign key (mem_id) references member(mem_id)
    );
    
INSERT INTO MEMBER values('BLK', '블랙핑크', 163);
INSERT INTO buy values(null,'BLK','지갑');
INSERT INTO buy values(null,'BLK','맥북');

select M.mem_id, M.mem_name, B.prod_name from buy B
	inner join member M
    on B.mem_id = M.mem_id;    
    
update member set mem_id = 'PINK' where mem_id='BLK';

delete from member where mem_id = 'PINK';

DROP TABLE IF EXISTS buy;
create table buy(
	num int auto_increment not null primary key,
    mem_id char(8) not null,
    prod_name char(6) not null
--    foreign key (mem_id) references member(mem_id) on update cascade on delete cascade
    );
    
describe buy;

drop table if exists member;
create table member(
	mem_id char(8) not null primary key,
    mem_name varchar(10) not null,
    height tinyint unsigned null,
    email char(30) null unique
); 

INSERT INTO MEMBER values('BLK', '블랙핑크', 163, 'pink@gmail.com');
INSERT INTO MEMBER values('TWC', '트와이스', 167, NULL);
INSERT INTO MEMBER values('APN', '에이핑크', 164, 'pink@gmail.com');

SELECT * FROM MEMBER;

drop table if exists member;
create table member(
	mem_id char(8) not null primary key,
    mem_name varchar(10) not null,
    height tinyint unsigned null check(height >= 160),
    phone1 char(3) null
); 
INSERT INTO MEMBER values('BLK', '블랙핑크', 163, null);
INSERT INTO MEMBER values('TWC', '트와이스', 99, null);

ALTER TABLE MEMBER
	add constraint
    check (phone1 in('02','031','032','054','055','061'));
    
INSERT INTO MEMBER values('BLK', '블랙핑크', 163, '02');
INSERT INTO MEMBER values('TWC', '트와이스', 167, '010');

drop table if exists member;
create table member(
	mem_id char(8) not null primary key,
    mem_name varchar(10) not null,
    height tinyint unsigned null default 160,
    phone1 char(3) null
); 

alter table member
	alter column phone1 set default '02';

INSERT INTO MEMBER values('RED', '레드벨벳', 161, '054');
INSERT INTO MEMBER values('SPC', '우주소녀',DEFAULT,DEFAULT);
-- INSERT INTO MEMBER values('SPC', '우주소녀',NULL,NULL);
INSERT INTO MEMBER(mem_id, mem_name) values('SPC', '우주소녀');

delete from member where mem_id='SPC';
SELECT * FROM MEMBER;
