-- * QUIZ1 * --------
/*
	CREATE USER C##TEST IDENTIFIED BY 1234; 실행
	User C##TEST이(가) 생성되었습니다.
	계정 생성만 하고 접속 시 에러 (user C##TEST lacks CREATE SESSION privillege; logon denied 에러)
*/

-- 원인 ?
-- 사용자 계정을 생성한 후에 GRANT로 권한을 부여하지 않아서
-- 해결방안 ?
-- 관리자 계정으로 로그인해서 접속한 후에 해당 사용자에 최소한의 권한 (CONNECT, RESOURCE)을 부여해줘야 함
-- * QUIZ2 * --------
CREATE TABLE TB_JOB (
	JOBCODE NUMBER PRIMARY KEY,
	JOBNAME VARCHAR2(10) NOT NULL
);


CREATE TABLE TB_EMP (
	EMPNO NUMBER PRIMARY KEY,
	EMPNAME VARCHAR2(10) NOT NULL,
	JOBNO NUMBER REFERENCES TB_JOB(JOBCODE)
);
/*
	위의 두 테이블을 조인하여 EMPNO, EMPNAME, JOBNO, JOBNAME 컬럼을 조회하고자 한다.
	이때 실행한 SQL문이 아래와 같다고 했을 때,
*/
SELECT EMPNO, EMPNAME, JOBNO, JOBNAME
FROM TB_EMP
	JOIN TB_JOB ON(JOBCODE = JOBNO);
    
-- 다음과 같은 오류가 발생했다.
-- ORA-00904: "TB_JOB"."JOBNO": invalid identifier

-- 원인 ? 조인하고자 하는 두 테이블의 연결고리 역할을 하는 컬럼명이 다르므로 JOIN-USING 구문을 사용할 수 없음

-- 해결방안 ? JOIN-USING구문을 JOIN-ON구문으로 변경