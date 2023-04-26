--  MariaDB에서 'spring'이라는 이름의 새 데이터베이스를 생성하는 SQL문
create database spring; 
 use spring;
 
-- auto_increment : mysql, mariadb의 방언
-- 오라클의 시퀀스 기능 자동으로 첫번째 인서트데이터 1
-- 순차적으로 1씩 증가하는 d를 자동으로 삽입
create table person (
	id int(10) auto_increment,
	person_name VARCHAR(50) not null,
	person_age int(3),
	constraint pk_person_id
	primary key(id)
);

select * from person;