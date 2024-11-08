
DELIMITER $$
	CREATE procedure USER_PROC()
    BEGIN
		SELECT * FROM MEMBER;
    END $$
DELIMITER ;

call user_proc();

-- 입력 매개변수==================================
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
-- 출력 매개변수==================================
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


set global log_bin_trust_function_creators = 1;

USE MARKET_DB;
DROP FUNCTION IF EXISTS sumFunc;
delimiter $$
create function sumFunc(number1 int, number2 int)
	returns int
begin
	return number1 + number2;
end $$
delimiter ;

select sumFunc(100,200) as '합계';

-- ============ 테스트 : 스토어드 프로시저 안에서 sql을 사용하고 그 sql에 스토어드 함수를 사용하는 것이 가능하다. =============
delimiter $$
create procedure user_test()
begin
	select sumFunc(100,200) as'합계';
end $$
delimiter ;

call user_test();

delimiter $$
create function calcYearFunc(dYear INT)
	RETURNS INT
begin
	declare runYear int;
    set runYear = YEAR(curdate()) - dYear;
    return runYear;
end $$
delimiter ;

select calcYearFunc(2010) as '활동 햇수';
select calcYearFunc(2007) into @debut2007;
select calcYearFunc(2013) into @debut2013;
select @debut2007 - @debut2013 as '2007과 2013 차이';

-- 함수 체이닝
select mem_id, mem_name, calcYearFunc(year(debut_date)) as '활동 햇수'
	from member;
    
drop function calcYearFunc;

delimiter $$
create procedure cursor_proc()
begin
	declare memNumber int;
    declare cnt int default 0;
	declare totNumber int default 0;
    declare endOfRow boolean default false;
    
    declare memberCursor cursor for
		SELECT mem_number from member;
	
    declare continue handler
		for not found set endOfRow = true;
	
    open memberCursor;
    
    cursor_loop : loop
		fetch memberCursor into memNumber;
        
        if endOfRow then
			leave cursor_loop;
        end if;
        
        set cnt = cnt + 1;
        set totNumber = totNumber + memNumber;
    end loop cursor_loop;
    
    select (totNumber / cnt) as '회원 평균 인원 수';
    
    close memberCursor;
end $$
delimiter ;

call cursor_proc();