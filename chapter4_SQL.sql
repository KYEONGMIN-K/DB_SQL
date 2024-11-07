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

select * from member, buy;

