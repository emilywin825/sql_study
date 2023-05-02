-- 댓글테이블은	원본게시물의 번호를 알고 있어야 함

create table tbl_reply (
   reply_no INT(10) auto_increment,
   reply_text VARCHAR(1000) not null,
   reply_writer VARCHAR(100) not null,
   reply_date DATETIME default current_timestamp,
   board_no INT(10),
   constraint pk_reply primary key (reply_no),
   constraint fk_reply 
   foreign key (board_no)
   references tbl_board (board_no)
   on delete cascade
);

select * from tbl_reply where board_no=3; 
