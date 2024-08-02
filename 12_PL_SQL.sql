/*
    * PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL

    오라클 자체에 내장되어 있는 절차적인 언어
    SQL 문장 내에서 변수 정의, 조건, 반복등을 지원하여 SQL의 단점을 보환
    다수의 SQL문을 한번에 실행가능
    
    *구조*
    [선언부]   : DECLARE 로 시작
    실행부     : BEGIN 으로 시작, SQL 문 또는 제어문(조건문, 반복문) 등의 로직을 작성하는 부분
    [예외처리부] : EXCEPTION으로 시작. 예외 발생 시 해결하기 위한 부분
*/
SET SERVEROUTPUT ON;    --화면에 표시하기 위한 설정

-- HELLO ORACLE 출력 : 화면에 출력하고자 할 때 DBMS_OUTPUT.PUT_LINE (출력할 내용)

BEGIN
    -- 자바 : System.out.println("Hello Java!");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE!');
END;
/
--------------------------------------------------------------------------------
/*
    * 선언부 (DECLARE)
    : 변수 또는 상수를 선언하는 부분 (선언과 동시에 초기화도 가능)
    
    - 데이터 타입 선언 종류
        + 일반 타입
        + 래퍼런스 타입
        + ROW 타입
*/

/*
    * 일반 타입 변수
    변수명 자료형 [:=값];
    -- 상수 선언 시 CONSTANT 를 붙여줌
    -- 초기화할 때는 := 기호를 사용
*/

DECLARE
    EID NUMBER;                 -- EID 라는 이름의 NUMBER 타입 변수 선언
    ENAME VARCHAR2(20);         -- ENAME 라는 이름의 VARCHAR2(20) 타입 변수 선언
    PI CONSTANT NUMBER := 3.14; -- PI 라는 이름의 NUMBER 타입 상수 선언 및 3.14 값으로 초기화
BEGIN
    -- 변수에 값을 대입
    EID := 100;     -- EID 라는 변수에 100이라는 값을 대입
    ENAME := '임수진'; -- ENAME 이라는 변수에 내 이름을 값으로 대입
    
    -- 각 변수, 상수에 저장된 값을 화면에 출력
    -- 특정 문자와 변수를 같이 출력하고자 할 때 연결연산자(||)를 사용!
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

-- 값을 입력받아 변수에 대입
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;

BEGIN
    EID := &번호;
    ENAME := '임수진';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);    
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------

/*
    * 래퍼런스 타입 변수
    : 어떤 테이블의 어떤 컬럼의 데이터타입을 참조하여 해당 타입으로 변수를 지정
    
    변수명 테이블명.컬럼명%TYPE
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;           -- EID라는 변수는 EMPLOYEE 테이블의 EMP_ID 컬럼의 타입을 참조 (VARCHAR2(3))
    ENAME EMPLOYEE.EMP_NAME%TYPE;       -- ENAME 변수는 EMPLOYEE 테이블의 EMP_NAME 컬럼의 타입을 참조 (VARCHAR2(20))
    SAL EMPLOYEE.SALARY%TYPE;           -- SAL 변수는 EMPLOYEE 테이블의 SALARY 컬럼의 타입을 참조 (NUMBER)
    
BEGIN
    -- EID := '100';
    -- ENAME := '임수진';
    -- SAL := 3000000;

    -- EMPLOYEE 테이블에서 200번 사원의 사번, 사원명, 급여 조회
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL                --각 컬럼의 결과 값을 변수에 대입
    FROM EMPLOYEE
    WHERE EMP_ID = 200
    WHERE EMP_ID = &사번;

    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    
END;
/


--------------------------------------------------------------------------------
-- 문제 -- 
/*
    래퍼런스 타입 변수로 EID, ENAME, JCODE, SAL, DTITLE을 선언하고 각 자료형을 EMPLOYEE테이블의 EMP_ID, EMP_NAME, JOB_CODE, SALARY 컬럼과
    DEPARTMENT 테이블의 DEPT_TITLE 컬럼을 참조하도록 한 뒤 사용자가 입력한 사번의 사원 정보를 조회하여 변수에 담아 출력
    
    출력 형식 : [사번], [이름], [직급코드], [월급], [부서명]

*/
DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    JCODE EMPLOYEE.JOB_CODE%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
BEGIN
    SELECT EMPLOYEE.EMP_ID, EMPLOYEE.EMP_NAME, EMPLOYEE.JOB_CODE, EMPLOYEE.SALARY, DEPARTMENT.DEPT_TITLE
    INTO EID, ENAME, JCODE, SAL, DTITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
    WHERE EMPLOYEE.EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/   

--------------------------------------------------------------------------------
 /*
 * ROW 타입 변수
    : 테이블의 한 행에 대한 모든 컬럼값을 한번에 담을 수 있는 변수
    
    변수명 테이블명%ROWTYPE;
 
 */   

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * 
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
-- 사원명, 급여, 보너스 정보를 출력
    DBMS_OUTPUT.PUT_LINE('사원명 :' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 :' || E.SALARY);
    -- DBMS_OUTPUT.PUT_LINE('보너스 :' || E.BONUS);
    -- NULL 값인 경우 0으로 표시하기 위해 NVL 함수 사용 가능!
    DBMS_OUTPUT.PUT_LINE('보너스 :' || NVL(E.BONUS, 0));
END;
/

--------------------------------------------------------------------------------

/*
    * 실행부(BEGIN)
    
    ** 조건문 **
        - 단일 IF문 : IF 조건식 THEN 실행내용 END IF;
        IF/ELSE문 : IF 조건식 THEN 조건식이 참일 때 실행내용 ELSE 조건식이 거짓일때 실행내용 END IF;
        - IF/ELSE 문 : IF 조건식1 THEN 실행내용1 ELSIF 조건식2 THEN 실행내용2... [ELSE 실행내용] END IF;
        
        - CASE/WHEN/THEN 문
            CASE 비교대상 WHEN 동등비교값1 결과값1
                         WHEN 동등비교값2 결과값2
                         WHEN 동등비교값3 결과값3
                            ...
                        ELSE 결과값N
        END;
*/        
-- 사용자에게 사번을 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스 정보를 출력
-- 각 데이터에 대한 변수 : 사번(EID), 이름(ENAME), 급여(SAL), 보너스 (BONUS)
-- 단, 보너스값이 0인 사원의 경우 "보너스를 받지 않는 사원입니다." 출력

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN

    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 :'  || EID);
    DBMS_OUTPUT.PUT_LINE('이름 :'  || ENAME);
    DBMS_OUTPUT.PUT_LINE('급여 :'  || SAL);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE ('보너스를 받지 않는 사원입니다');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스 :'  || BONUS);
    END IF;
END;
/
--------------------------------------------------------------------------------
/*
    DECLARE
        -- 래퍼런스 변수 (EID, ENAME, DTITLE, NCODE)
            참조변수(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
        -- 일반타입변수 (TEAM 문자타입) --> '국내팀' 또는 '해외팀' 저장할 예정
    BEGIN
        -- 사용자가 입력한 사번의 해당하는 사번, 이름, 부서명, 근무국가코드 조회
        -- 조회 후 해당 값을 변수에 저장
        
        -- 이때, NCODE의 값이 KO일 경우 '국내팀'을 TEAM 변수에 저장
                            KO가 아닐 경우 '해외팀'을 TEAM 변수에 저장
                            
        -- 출력 형식 : 사번, 이름, 부서, 소속
        
    END;
    /
*/

DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    DTITLE DEPARTMENT.DEPT_TITLE%TYPE;
    NCODE LOCATION.NATIONAL_CODE%TYPE;
    
    TEAM VARCHAR2(10);
BEGIN
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE
    INTO EID, ENAME, DTITLE, NCODE
    FROM EMPLOYEE
        JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
        JOIN LOCATION ON (LOCATION_ID = lOCAL_CODE)
    
    WHERE EMP_ID = &사번;
    
    IF NCODE = 'KO'
        THEN TEAM := '국내팀';
    ELSE
        TEAM := '해외팀';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('소속 : ' || TEAM);
END;
/
--------------------------------------------------------------------------------
/*
    점수(SCORE)
    등급(GRADE) = 'A', 'B', 'C', 'D', 'F'
    
    사용자에게 점수를 입력받아
    90점 이상이면 'A'
    80점 이상이면 'B'
    70점 이상이면 'C'
    60점 이상이면 'D'
    그 아래면 'F'
    
    << 출력 >>
    "점수는 XX이고, 등급은 X입니다."
    만약 F등급이라면 "재평가 대상입니다.
    
*/
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := &점수;
    
    IF SCORE >= 90
        THEN GRADE := 'A';
    ELSIF SCORE >= 80
        THEN GRADE := 'B';
    ELSIF SCORE >= 70
        THEN GRADE := 'C';       
    ELSIF SCORE >= 60
        THEN GRADE := 'D';    
    ELSE
        GRADE := 'F';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('점수는 ' || SCORE || ' 이고 등급은 ' || GRADE || ' 입니다.');
    IF GRADE = 'F'
        THEN DBMS_OUTPUT.PUT_LINE('재평가 대상입니다.');
        
    END IF;
END;
/

--------------------------------------------------------------------------------
DECLARE
    EMP EMPLOYEE%ROWTYPE;
    DTITLE VARCHAR2(50);
BEGIN
    SELECT *
    INTO EMP
    FROM EMPLOYEE
    WHERE EMP_ID = &사번;
    
    -- 해당 사원의 부서코드 기준으로 부서명 저장 --
    DTITLE := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계관리부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업부'
                WHEN 'D5' THEN '해외영업1부'
                WHEN 'D6' THEN '해외영업2부'
                WHEN 'D7' THEN '해외영업3부'
                WHEN 'D8' THEN '기술지원부'
                WHEN 'D9' THEN '총무부'
                ELSE '부서 없음'
            END;
--------------------------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '사원의 소속부서는 ' || DTITLE || '입니다.');
END;
/

SELECT * FROM DEPARTMENT;
--------------------------------------------------------------------------------

/*
    * 반복문
        - 기본 구문 : LOOP 
                        반복할 구문
                        반복문을 종료할 구문
                    END LOOP;
                    
                    * 반복문을 종료할 구문
                    [1] IF 조건식 THEN EXIT; END IF;
                    [2] EXIT WHIN 조건식;
                    
                - FOR LOOP문
                    FOR 변수 IN [REVERSE] 초기값..최종값
                    LOOP 반복할구문 END LOOP;
                    
                    * REVERSE : 최종값부터 초기값까지 반복
                    
            - WHILE LOOP 문
                WHILE 조건식 
                LOOP 반복할구문 END LOOP;
*/

-- 기본구문을 사용하여 'HELLO ORACLE'을 5번 출력

DECLARE
    N NUMBER := 1;

BEGIN 
    LOOP
        DBMS_OUTPUT.PUT_LINE(N || ') HELLO ORACLE!');
        
        N := N+1;
        IF N > 5
        THEN EXIT;
        END IF;
    END LOOP;
END;
/

-- FOR LOOP 문을 사용하여 HELLO ORACLE! 5번 출력

BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I || ') HELLO ORACLE!');
    END LOOP;
    END;
    /
--------------------------------------------------------------------------------
-- TEST 테이블 삭제
DROP TABLE TEST;
CREATE TABLE TEST (
    TNO NUMBER PRIMARY KEY,
    TDATE DATE
);

CREATE SEQUENCE SEQ_TNO
INCREMENT BY 2
MAXVALUE 1000
NOCYCLE
NOCACHE;

--TEST 테이블에 데이터를 100개 추가 (TNO: 시퀀스 사용, TDATE: 현재 날짜)


BEGIN
    FOR I IN 1..100 
    LOOP
        INSERT INTO TEST VALUES(SEQ_TNO.NEXTVAL,SYSDATE); 
    END LOOP;
END;
/

SELECT * FROM TEST;

--------------------------------------------------------------------------------
/*
    * 예외 처리부
        - 예외 (EXCEPTION) : 실행 중 발생하는 오류
    
    EXCEPTION 
        WHEN 예외명 THEN 예외처리구문;
        WHEN 예외명 THEN 예외처리구문;
        ...
        WHEN OTHERS THEN 예외처리구문;
        
        * 오라클에서 미리 정의한 예외 => 시스템 예외
            - NO_DATA_FOUND : 조회된 결과가 없을 때
            - TOO_MANY_ROWS : 조회된 결과가 여러 행일 때 (-> 변수에 대입..)
            - ZERO_DIVIDE : 0으로 값을 나누려고 할 때
            - DUP_VAL_ON_INDEX : UNIQUE 조건에 위배될 때 (중복되는 경우)
            ...
        * OTHERS : 어떤 예외든 발생되었을 때
*/

-- 사용자에게 숫자를 입력받아 10으로 나눈 결과를 출력. (0이 입력되었을 때는 오류가 발생될 수 있다 ...)

DECLARE
    NUM NUMBER;
BEGIN
    NUM := &숫자;
    DBMS_OUTPUT.PUT_LINE(10/NUM);
EXCEPTION
    -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0으로 나눌 수 없습니다');
END;
/

-- EMPLOYEE 테이블 EMP_ID 컬럼을 기본키로 설정
-- ALTER TABLE EMPLOYEE ADD PRIMARY KEY (EMP_ID);

-- 기본키 (PRIMARY KEY) : UNIQUE + NOT NULL

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&변경할사번'
    WHERE EMP_NAME = '노옹철';
    
EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('중복된 사번입니다.');
END;
/

--------------------------------------문제--------------------------------------
/*
    * 사수의 사번을 입력받아 해당 사원의 사번, 이름을 출력
*/
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = '&사수사번';         -- 문자타입으로 입력받고자 할 경우 작은따옴표로 감싸준다.
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || ENAME);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('입력한 사수사번을 가진 사원이 없습니다');
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('해당 사수에 대한 사원이 많습니다.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('오류가 발생하였습니다. 관리자에게 문의하세요!');
END;  
/*

     * 트리거 (TRIGGER)
     : 지정된 테이블에 DML(INSERT, UPDATE, DELETE)문에 의해 변경사항이 있을 때 (테이블에 이벤트가 발생했을 때)
        자동으로 매번 실행할 내용을 미리 정의해두는 것
        
        ex) 회원 탈퇴 시 기존 회원테이블에서 데이터 삭제 (DELETE)하고
            탈퇴 회원 테이블에 데이터 추가(INSERT) 해야 할 때 자동으로 실행
            
        ex) 신고횟수가 특정 값을 넘어갔을 때 해당 회원을 블랙리스트 처리
        
        ex) 입출고에 대한 데이터를 기록할 때 해당 상품의 재고 수량을 갱신해야 할 때
*/

/*
    * 트리거의 종류 *
    
    - SQL 문의 실행 시기에 따른 분류
        + BEFORE TRIGGER : 지정한 테이블에 이벤트가 발생하기 전에 트리거 실행
        + AFTER TRIGGER  : 지정한 테이블에 이벤트가 발생한 후에 트리거 실행
    
    - SQL 문에 의해 영향을 받는 각 행에 따른 분류
    + 문장 트리거    : 이벤트가 발생한 SQL문에 대해 딱 한번만 트리거 실행
    + 행 트리거      : 해당 SQL문이 실행될때마다 매번 트리거 실행
                      FOR EACH ROW 옵션 설정 필요
                      
                      :OLD - BEFORE UPDATE (수정 전 자료), BEFORE DELETE (삭제 전 자료)
                      :NEW - AFTER INSERT (추가된 자료), AFTER UPDATE(수정 후 자료)
*/

/*
    * 트리거 생성하기
    
    CREATE [OR REPLACE] TRIGGER 트리거이름                   -- 트리거 기본정보 (이름)
    BEFORE | AFTER  INSERT | UPDATE | DELETE ON 테이블명    -- 이벤트 관련 정보
    [FOR EACH ROW]                                          -- 매번 트리거를 실행할 것인지에 대한 옵션
    
    [DECLARE]       -- 변수 / 상수 선언 및 초기화
    BEGIN           -- 실행부(SQL문, 조건문, 반복문...)
                        이벤트 발생 시 자동으로 처리할 구문
    [EXCEPTION]     -- 예외처리부
    END;
    /
    
*/

-- EMPLOYEE 테이블에 데이터가 추가될 때마다 '신입사원님 환영합니다. ^^' 출력
CREATE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원님 환영합니다 ^^');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (500, '양준혁', '000501-3000000', 'D4', 'J4',SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (501, '김인창', '950704-1000000', 'D6', 'J5',SYSDATE);
--------------------------------------------------------------------------------
-- 상품 입고 및 출고 관련

-- * 테이블, 시퀀스 생성
-- 상품을 저장하기 위한 테이블
CREATE TABLE TB_PRODUCT (
    PNO NUMBER PRIMARY KEY,      -- 상품번호
    PNAME VARCHAR2(30) NOT NULL, -- 상품명
    BRAND VARCHAR2(30) NOT NULL, -- 브랜드
    PRICE NUMBER DEFAULT 0,      -- 가격
    STOCK NUMBER DEFAULT 0       -- 재고 수량
);


-- 상품번호로 사용할 시퀀스 (시작번호 200, 증가값 5, 캐시메모리 X)
CREATE SEQUENCE SEQ_PNO 
START WITH 200
INCREMENT BY 5
NOCACHE;

-- 샘플 데이터 추가
INSERT INTO TB_PRODUCT(PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '아이폰15', '사과');
INSERT INTO TB_PRODUCT VALUES(SEQ_PNO.NEXTVAL, '갤럭시 폴드6', '샘송', 2000000, 50);
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '샤오미', '샤우미', 80000, 500);

SELECT * FROM TB_PRODUCT;

COMMIT;     -- DB에 반영하기

-- 상품 입출고 내역을 저장하기 위한 테이블

CREATE TABLE TB_PDETAIL (
    DNO NUMBER PRIMARY KEY,             -- 내역번호
    PNO NUMBER REFERENCES TB_PRODUCT,   -- 상품 번호
    DDATE DATE DEFAULT SYSDATE,         -- 입출고일
    AMOUNT NUMBER NOT NULL,             -- 입출고 수량
    TYPE CHAR(6) CHECK(TYPE IN ('입고', '출고')) -- 입출고 상태
);

-- 입출고 내역에 대한 시퀀스 (내역번호)
CREATE SEQUENCE SEQ_DNO
NOCACHE;

-- 205번 상품, 오늘날짜, 5개 출고
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '출고');

-- * TB_PRODUCT 테이블에 업데이트
UPDATE TB_PRODUCT
    SET STOCK = STOCK - 5
WHERE PNO = 205;

ROLLBACK;   -- 위의 쿼리문에 오류가 있어 롤백

SELECT * FROM TB_PDETAIL;
SELECT * FROM TB_PRODUCT;       -- 기존 값에서 5를 뺀 값 업데이트

-- 200 번 (아이폰15) 상품의 재고를 10개 입고
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '입고');

UPDATE TB_PRODUCT
    SET STOCK = STOCK + 10
    WHERE PNO = 200;

COMMIT;
--------------------------------------------------------------------------------
/*
    TB_PDETAIL (입출고이력) 테이블에 데이터 추가(INSERT) 이벤트 발생 시
    TB_PRODUCT (상품) 테이블에 재고 수량이 갱신(UPDATE) 되어야 함! -> 자동으로 처리할 수 있도록 트리거 생성!
    
    - UPDATE 조건
     * 상품이 입고된 경우 -> 해당 상품을 찾아서 재고 수량 증가
        UPDATE TB_PRODUCT
            SET STOCK = STOCK + 입고수량(TB_PDETAIL.AMOUNT) --> :NEW.AMOUNT
            WHERE PNO = 입고된상품번호(TB_PDETAIL.PNO)       --> :NEW.PNO
    * 상품이 출고된 경우 -> 해당 상품을 찾아서 재고 수량 감소
        UPDATE TB_PRODUCT
            SET STOCK = STOCK - 출고수량(TB_PDETAIL.AMOUNT) --> :NEW.AMOUNT
            WHERE PNO = 출고된상품번호(TB_PDETAIL.PNO)       --> :NEW.PNO 
*/

-- ** TRG_02 트리거 생성 **

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PDETAIL
FOR EACH ROW
BEGIN 
    IF :NEW.TYPE = '입고' 
        THEN UPDATE TB_PRODUCT 
                SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PNO = :NEW.PNO;
    ELSE UPDATE TB_PRODUCT 
                SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PNO = :NEW.PNO;
    END IF;
END;
/

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, SYSDATE, 100, '입고');

SELECT * FROM TB_PRODUCT;

COMMIT;


