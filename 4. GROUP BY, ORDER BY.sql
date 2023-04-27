

SELECT * FROM tb_sal_his;


-- 집계 함수 (다중행 함수)
-- : 여러 행을 묶어서 함수를 적용
SELECT * FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
ORDER BY emp_no, pay_de
;

SELECT * FROM tb_sal_his
WHERE emp_no = '1000000005'
;

SELECT
    SUBSTR(emp_nm, 1, 1) 성씨   
FROM tb_emp
;


-- GROUP BY로 소그룹화 하지 않으면 집계함수는 전체행수를 기준으로 집계한다.
SELECT 
    SUM(pay_amt) "지급 총액"
    , AVG(pay_amt) "평균 지급액"
    , COUNT(pay_amt) "지급 횟수"
FROM tb_sal_his
;

SELECT * FROM tb_emp;


-- COUNT, SUM, AVG : NULL값은 제외하고 연산
-- ! 하지만 count(*)은 null값까지 카운트
SELECT 
    COUNT(emp_no) AS "총 사원수" 
    , COUNT(direct_manager_emp_no) "dmen"
    , COUNT(*) 
    , MIN(birth_de) "최연장자의 생일"
    , MAX(birth_de) "최연소자의 생일"
FROM tb_emp;


SELECT 
    direct_manager_emp_no
FROM tb_emp;


-- GROUP BY : 지정된 컬럼으로 소그룹화 한 후 집계함수 적용
-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일 부서별 총 사원 수를 조회

SELECT * FROM tb_emp
ORDER BY dept_cd
;





SELECT 
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd
;

-- 사원별 누적 급여수령액 조회

SELECT * FROM TB_SAL_HIS tsh 
ORDER BY EMP_NO,PAY_DE;

SELECT 
    emp_no "사번"
	, SUM(pay_amt) "누적 수령액"
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

-- 사원별로 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
    -- , ROUND(pay_amt, 2)
FROM tb_sal_his
GROUP BY emp_no
ORDER BY emp_no
;

SELECT 
	MAX(EMP_NO) ,DEPT_CD 
FROM TB_EMP te 
GROUP BY DEPT_CD; --GROUP BY를 하지 않은 대상들은 SELECT에서 다이랙트로 부를 수 없음
				  -- 집계함수 사용하면 가능

SELECT EMP_NO, EMP_NM
FROM TB_EMP te 
GROUP BY EMP_NO,EMP_NM; 



-- 사원별로 2019년에 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
-- group by절에 있는 where절은 그룹화하기 전에 필터링

SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
    , TO_CHAR(SUM(pay_amt), 'L999,999,999') "연봉"
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
ORDER BY emp_no
;

-- HAVING : 그룹화된 결과에서 조건을 걸어 행 수를 제한
-- 그룹화해서 통계낸 이후에 필터링

-- 부서별로 가장 어린사람의 생년월일, 연장자의 생년월일, 부서별 총 사원 수를 조회
-- 그런데 부서별 사원이 1명인 부서의 정보는 조회하고 싶지 않음.
SELECT --3
    dept_cd
    , MAX(birth_de) 최연소자
    , MIN(birth_de) 최연장자
    , COUNT(emp_no) 직원수
FROM tb_emp --1
GROUP BY dept_cd --2
HAVING COUNT(emp_no) > 1 --4
ORDER BY dept_cd
;


-- 사원별로 급여를 제일 많이받았을 때, 제일 적게받았을 때, 평균적으로 얼마받았는지 조회
-- 평균 급여가 450만원 이상인 사람만 조회
SELECT 
    emp_no "사번"
    , TO_CHAR(MAX(pay_amt), 'L999,999,999') "최고 수령액"
    , TO_CHAR(MIN(pay_amt), 'L999,999,999') "최저 수령액"
    , TO_CHAR(ROUND(AVG(pay_amt), 2), 'L999,999,999.99') "평균 수령액"
FROM tb_sal_his
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;

-- 사원별로 2019년 월평균 수령액이 450만원 이상인 사원의 사원번호와 2019년 연봉 조회
SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'--먼저 19년도로 제한하고
GROUP BY emp_no --그 뒤에 emp_no로 묶어서 통계낸 후
HAVING AVG(pay_amt) >= 4500000 -- 다시한번 avg 구함
;

-- 그룹화 대상 컬럼이 2개 이상인 경우
SELECT 
    emp_no
    , sex_cd
    , dept_cd
FROM tb_emp
ORDER BY dept_cd, sex_cd
;

-- GROUP BY의 대상이 2개인 경우
SELECT 
    dept_cd,SEX_CD , COUNT(*)
FROM tb_emp
GROUP BY dept_cd, sex_cd
ORDER BY dept_cd --ORDER BY도 GROUP BY에 없는거로 정렬하면 오류
;


-- ORDER BY : 정렬
-- ASC : 오름차 정렬 (기본값), DESC : 내림차 정렬
-- 항상 SELECT절의 맨 마지막에 위치

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_no DESC
;

SELECT 
    emp_no
    , emp_nm
    , addr
FROM tb_emp
ORDER BY emp_nm DESC
;

SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY dept_cd ASC, emp_nm DESC --dept_cd로 오름차정렬하고, 같은 dept_cd 안에서 emp_nm로 내림차정렬
;


SELECT 
    emp_no AS 사번
    , emp_nm AS 이름
    , addr AS 주소
FROM tb_emp
ORDER BY 이름 DESC
;

SELECT 
    emp_no --1
    , emp_nm --2
    , dept_cd --3
FROM tb_emp
ORDER BY 3 ASC, 1 DESC
;


SELECT 
    emp_no
    , emp_nm
    , dept_cd
FROM tb_emp
ORDER BY 3 ASC, emp_no DESC
;

SELECT emp_no AS 사번, emp_nm AS 이름, addr AS 주소
FROM tb_emp
ORDER BY 이름, 1 DESC
;

SELECT 
    emp_no
    , SUM(pay_amt) 연봉
FROM tb_sal_his
WHERE pay_de BETWEEN '20190101' AND '20191231'
GROUP BY emp_no
HAVING AVG(pay_amt) >= 4500000
ORDER BY emp_no
;