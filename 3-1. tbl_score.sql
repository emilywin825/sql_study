

create table tbl_score (
   stu_name VARCHAR(30) not null,
   kor INT(3) not null,
   eng INT(3) not null,
   math INT(3) not null,
   stu_num INT(10) auto_increment,
   total INT(3),
   average FLOAT(5, 2),
   grade CHAR(1),
   constraint pk_stu_num
   primary key (stu_num)
);

select * from tbl_score;

truncate table tbl_score;

select * from person p;
