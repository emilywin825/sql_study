
--테이블(엔티티) 생성
--성적정보 저장 테이블

CREATE TABLE tbl_score(
	name VARCHAR2(4) NOT null,
	kor NUMBER(3) NOT NULL CHECK(kor>0 AND kor<=100),
	eng NUMBER(3) NOT NULL CHECK(eng>0 AND eng<=100),
	math NUMBER(3) NOT NULL CHECK(math>0 AND math<=100),
	total NUMBER(3) NULL,
	average NUMBER(5,2),
	grade CHAR(1),
	stu_num NUMBER(6),
	--테이블 생성시 PK 거는 법 :  (pk_stu_num : 인덱스명)
	CONSTRAINT pk_stu_num
	PRIMARY KEY (stu_num)
);

-- 테이블 생성 후 PK 거는 법
ALTER TABLE TBL_SCORE 
ADD CONSTRAINT pk_stu_num
	PRIMARY KEY (stu_num);

-- 칼럼 추가하기 (ALTER - ADD)
ALTER TABLE TBL_SCORE 
ADD (sci NUMBER(3) NOT NULL);

-- 칼럼 제거하기 (ALTER - DROP)
ALTER TABLE TBL_SCORE 
DROP COLUMN sci;

-- 테이블 복사 (tb_emp)
--CTAS
CREATE TABLE tb_emp_copy
AS SELECT * FROM tb_emp;

-- 복사 테이블 조회
SELECT * FROM tb_emp_copy;
SELECT * FROM tb_emp;

-- drop table (복구x / 로그도 안 남음)
DROP TABLE TB_EMP_COPY;

-- TRUNCATE table
-- 구조는 냅두고 내부 데이터만 전체 삭제
TRUNCATE TABLE TB_EMP_COPY;



-- 예시 테이블
CREATE TABLE goods (
	id NUMBER(6) PRIMARY KEY,
	g_name VARCHAR2(10) NOT NULL,
	price NUMBER(10) DEFAULT 1000,
	reg_date DATE
) ;



-- INSERT 
INSERT INTO goods 
	(id, g_name,price, reg_date)
VALUES (1,'선풍기','120000',SYSDATE);

INSERT INTO goods 
	(id, g_name, reg_date)
VALUES (2, '달고나',SYSDATE);

INSERT INTO goods 
	(id, g_name, PRICE)
VALUES (3, '새우깡',500);

-- 컬럼명 생략시 모든 컬럼에 대해 순서대로 넣어햐 함. -> 실무에서 사용 x
INSERT INTO goods VALUES (4, '신라면',1500,SYSDATE);

-- 다중 컬럼 가능
INSERT INTO goods VALUES (5, '마이쮸1',1500,SYSDATE),
						(6,'마이쮸2',1500,SYSDATE),
						(7, '마이쮸3',1500,SYSDATE);
					
-- 수정 UPDATE 
UPDATE goods 
SET g_name='냉장고'
WHERE id=3;

UPDATE goods 
SET g_name='콜라', price=3000
WHERE id=2;

UPDATE goods 
SET price=9999; --WHERE절 안쓰면 모든 행이 다 9999로 변경됨

UPDATE tbl_user
SET age=age+1; -- 새로운 해에 회원들의 나이를 +1하겠다 이럴 때 사용

-- 행을 삭제 DELETE 
DELETE FROM GOODS
WHERE id=3;

-- 모든 행 삭제
DELETE FROM goods;

SELECT * FROM goods;

-- SELECT 조회
SELECT CERTI_CD,
	   CERTI_NM,
	   ISSUE_INSTI_NM 
FROM TB_CERTI;

SELECT ISSUE_INSTI_NM 
FROM TB_CERTI;

--중복 제거 distinct->(작성 안하면 ALL(중복 제거 x)이 자동으로 들어감)
SELECT DISTINCT 
	   ISSUE_INSTI_NM 
FROM TB_CERTI;

-- 모든 컬럼 조회 (실무에서는 사용하지 마세요)
SELECT * FROM TB_CERTI;

-- 열 별칭 부여(alias)
SELECT
	te.EMP_NM 사원명,
	ADDR AS "사원의 거주지 주소"
FROM TB_EMP te;

--문자열 연결하기 (||)
SELECT 
	CERTI_NM || '(' || ISSUE_INSTI_NM || ')' "자격증 정보"
FROM TB_CERTI;





