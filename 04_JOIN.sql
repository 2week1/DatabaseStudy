/*
    JOIN
    : 두 개 이상의 테이블에서 데이터를 조회하고자 할 때 사용되는 구문
      조회 결과는 하나의 결과물(RESULT SET)로 나옴
      
    * 관계형 데이터베이스(RDB) 에서는 최소한의 데이터를 각각의 테이블에 저장
      중복 저장을 최소화하기 위해 최대한 쪼개서 관리함
      
      => 관계형 데이터베이스에서 쿼리문을 이용한 테이블간의 "관계"를 맺는 방법
      (각 테이블간의 연결고리(외래키)를 통해서 데이터를 매칭시켜 조회함!)
      
    JOIN은 크게 "오라클 전용 구문" 과 "ANSI 구문" (미국국립표준협회)
        
        
                오라클 전용 구문           |              ANSI 구문
--------------------------------------------------------------------------------        
                등가 조인                 |              내부 조인
                (EQUAL JOIN)             |    (INTER JOIN) -> JOIN USING/ON
--------------------------------------------------------------------------------                
                포괄 조인                 |    왼쪽 외부 조인(LEFT OUTER JOIN)
              (LEFT OUTER)               |    오른쪽 외부 조인(RIGHT OUTER JOIN)   
              (RIGHT OUTER)              |    전체 외부 조인(FULL OUTER JOIN)
--------------------------------------------------------------------------------
            자제 조인(SELF JOIN)          |               JOIN ON
        비등기 조인(NON EQUAL JOIN)       |
--------------------------------------------------------------------------------        
*/

-- 전체 사원들의 사번, 사원명, 부서코드 조회
SELECT EMP_NAME, EMP_NAME, DEPT_CODE
FROM EMPLOYEE;

-- 부서코드, 부서명 조회 (부서 정보가 저장된 테이블 : DEPARTMENT)
SELECT DEPT_ID, DEPT_TITLE  FROM DEPARTMENT;

-- 전체 사원들의 사번, 사원명, 직급코드 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE;

-- 직급코드, 직급명 조회 (직급 정보 : JOB)
SELECT JOB_CODE, JOB_NAME
FROM JOB;

/*
    * 등가조인 (EQUAL JOIN) / 내부조인 (INTER JOIN)
    => 연결시키는 컬럼의 값이 일치하는 행들만 조회( => 일치하지 않는 값은 조회 시 제외)
*/

-- 오라클 전용 구문 --
/*
    * FROM 절에서 조회하고자 하는 테이블을 나열( ,로 구분)
    * WHERE 절에 매칭시킬 컬럼에 대한 조건을 작성
*/
-- 사원의 사번, 이름, 부서명을 조회 ( 부서코드 컬럼 => EMPLOYEE: DEPT_CODE, DEPARTMENT : DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

-- > NULL(EMPLOYEE.DEPT_CODE), 마케팅부(D3), 해외영업3부(D7), 국내영업부(D4) -> DEPARTMENT 데이터는 제외됨!
-- 각 테이블에만 존재하는 값들로 조회에서 제외됨

-- 사원의 사번, 이름, 직급명을 조회(직급코드 컬럼 => EMPLOYEE: JOB_CODE, JOB: JOB_CODE)
-- 두 테이블의 컬럼명이 동일할 경우 별칭을 지어줌으로써 구분할 수 있음!
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;

-- ANSI 구문 --
/*
    FROM 절에 기준이 되는 테이블을 하나 작성
    JOIN절 조인하고자 하는 테이블을 기술 + 매칭시키고자 하는 조건을 작성
    
    - JOIN USING    : 컬럼명이 같은 경우
    - JOIN ON       : 컬럼명이 같거나 다른 경우
*/
-- 사번, 사원명, 부서명 조회(EMPLOYEE : DEPT_CODE, DEPARTMENT: DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- 사번, 사원명, 직급명 조회(EMPLOYEE: JOB_CODE, JOB: JOB_CODE)
-- JOIN USING 구문 사용
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE);
    
-- JOIN ON 구문 사용
SELECT EMP_ID, EMP_NAME, JOB_NAME, E.JOB_CODE
FROM EMPLOYEE E
    JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);
    
-- 대리 직급인 사원의 사번, 사원명, 직급명, 급여 조회

-- **오라클 구문 사용**
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE 
    AND JOB_NAME='대리';

-- **ANSI 구문 사용**
SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE
    JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리';

-------------------------------------Quiz---------------------------------------
-- [1] 부서가 인사관리부인 사원들의 사번, 사원명, 보너스 조회
-- ** 오라클 구문 **
-- 사원 정보(EMPLOYEE) / 부서 정보(DEPARTMENT)
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND DEPT_TITLE = '인사관리부';
    
-- ** ANSI 구문**
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
    JOIN DEPARTMENT ON( DEPT_CODE = DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';


-- [2] 부서(DEPARTMENT)와 지역(LOCATION) 정보를 참고하여 전체 부서의 부서코드, 부서명, 지역코드, 지역명 조회
-- **오라클 구문**
SELECT DEPT_ID 부서코드, DEPT_TITLE 부서명, LOCATION_ID 지역코드, LOCAL_NAME 지역명
FROM DEPARTMENT, LOCATION
WHERE LOCATION_ID = LOCAL_CODE;
-- **ANSI 구문**
SELECT DEPT_ID 부서코드, DEPT_TITLE 부서명, LOCATION_ID 지역코드, LOCAL_NAME 지역명
FROM DEPARTMENT
    JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);

-- [3] 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
-- **오라클 구문**
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID AND BONUS IS NOT NULL;
-- **ANSI 구문**
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    WHERE BONUS IS NOT NULL;

-- [4] 부서가 총무부가 아닌 사원들의 사원명, 급여 조회
-- **오라클 구문**
SELECT EMP_NAME, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
    AND DEPT_TITLE != '총무부';
-- **ANSI 구문**
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    WHERE DEPT_TITLE != '총무부';
--------------------------------------------------------------------------------
/*
    포괄조인 / 외부조인 (OUTER JOIN) 
    : 두 테이블간의 JOIN시 일치하지 않는 행도 포함하여 조회하는 구문
    단, 반드시 LEFT/RIGHT를 지정해야 함(기준이 되는 테이블)
*/

-- 모든 사원의 사원명, 부서명, 급여, 연봉을 조회
-- * LEFT JOIN : 두 테이블 중 왼쪽에 작성된 테이블을 기준으로 조인

-- ** 오라클 구문 **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 연봉
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+);

-- ** ANSI 구문 **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 연봉
FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
-- * RIGHT JOIN : 두 테이블 중 오른쪽에 작성된 테이블 기준으로 조인
-- ** 오라클 구문 **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 연봉
FROM EMPLOYEE,DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID
ORDER BY EMP_NAME;

-- ** ANSI 구문 **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 연봉
FROM EMPLOYEE
    RIGHT JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
    
-- * FULL JOIN : 두 테이브리 가진 모든 행을 조회하는 조인구문(오라클 전용 구문 X)
-- ** ANSI 구문 **
SELECT EMP_NAME, DEPT_TITLE, SALARY, SALARY * 12 연봉
FROM EMPLOYEE
    FULL JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID;
--------------------------------------------------------------------------------

/*
    비등가 조인(NON EQUAL JOIN)
    : 매칭시킬 컬럼에 대한 조건 작성 시 '=' 를 사용하지 않는 조인
    
    * ANSI 구문에서는 JOIN ON만 사용 가능 *
*/

-- 사원에 대한 급여등급 조회(사원명, 급여, 급여등급)

-- 사원(EMPLOYEE), 급여등급(SAL_GRADE)

-- * 오라클 구문 *
SELECT EMP_NAME, SALARY, SAL_LEVEL
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
 WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
 
 -- * ANSI 구문 *
 SELECT EMP_NAME, SALARY, SAL_LEVEL
 FROM EMPLOYEE
    JOIN SAL_GRADE ON SALARY >= MIN_SAL AND SALARY <= MAX_SAL;
    
--------------------------------------------------------------------------------
/*
    자체 조인(SELF JOIN)
    : 같은 테이블을 다시 한번 조인하는 구문
*/

-- 전체 사원의 사번, 사원명, 부서코드,
--          사수 사번, 사수 사원명, 사수 부서코드 조회

-- 사원(EMPLOYEE), 사수(사원) {EMPLOYEE) ---> 테이블명이 동일하므로 "별칭"을 부여!
-- * 오라클 구문 *
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, E.DEPT_CODE 부서코드, E.MANAGER_ID,
        M.EMP_ID"사수 사번", M.EMP_NAME"사수 사원명", M.DEPT_CODE"사수 부서코드"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;

SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, E.DEPT_CODE 부서코드, E.MANAGER_ID,
        M.EMP_ID"사수 사번", M.EMP_NAME"사수 사원명", M.DEPT_CODE"사수 부서코드"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID;       -- 사원의 사수번호와 사번을 조건으로 주어 사수정보를 조회

-- ** ANSI 구문 **
SELECT E.EMP_ID 사번, E.EMP_NAME 사원명, E.DEPT_CODE 부서코드, E.MANAGER_ID,
        M.EMP_ID"사수 사번", M.EMP_NAME"사수 사원명", M.DEPT_CODE"사수 부서코드"
FROM EMPLOYEE E
    FULL JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID;
    -- LEFT JOIN EMPLOYEE M ON E.MANAGER_ID = M.EMP_ID; -- 사수가 없는 사원 정보도 조회하고자 할 때

--------------------------------------------------------------------------------

/*
    다중 조인
    : 2개 이상의 테이블을 조인하는 것
*/

-- 사번, 사원명, 부서명, 직급명 조회
-- 사원(EMPLOYEE) / 부서(DEPARTMENT) / 직급(JOB)
-- * 오라클 구문 *

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID
    AND E.JOB_CODE = J.JOB_CODE;


-- * ANSI 구문 *
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    JOIN JOB USING (JOB_CODE);

-- 사번, 사원명, 부서명, 지역명 조회
SELECT * FROM EMPLOYEE;     -- 부서코드 : DEPT_CODE
SELECT * FROM DEPARTMENT;   -- 부서코드 : DEPT_ID, 지역코드: LOCATION_ID
SELECT * FROM LOCATION;     -- 지역코드 : LOCAL_CODE

-- ** 오라클 구문 **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE, DEPARTEMENT, LOCATION
WHERE DEPT_CODE = DEPT_ID
    AND LOCATION_ID = LOCAL_CODE;
    
-- ** ANSI 구문 **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID      -- EMPLOYEE 테이블과 DEPARTMENT 테이블 조인!
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE;  -- DEPARTMENT 테이블과 LOCATION 테이블 조인!
--------------------------------------------------------------------------------

-- 1) 사번, 사원명, 부서명, 지역명, 국가명 조회
-- 사원+(EMPLOYEE) / 부서(DEPARTMENT) / 지역(LOCATION) / 국가(NATIONAL)

-- ** 오라클 구문 **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE, DEPARTMENT, LOCATION L, NATIONAL N
WHERE DEPT_CODE = DEPT_ID              -- EMPLOYEE 테이블과 DEPARTMENT 테이블 연결
    AND LOCATION_ID = LOCAL_CODE           -- DEPARTMENT 테이블과 LOCATION 테이블 연결
    AND L.NATIONAL_CODE  = N.NATIONAL_CODE;  -- LOCATION 테이블과 ANTIONAL 테이블 연결

-- ** ANSI 구문 **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE
    JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
    JOIN LOCATION L ON DEPARTMENT.LOCATION_ID = L.LOCAL_CODE
    JOIN NATIONAL N ON L.NATIONAL_CODE = N.NATIONAL_CODE;

-- 2) 사번, 사원명, 부서명, 직급명, 지역명, 국가명, 급여등급 조회
-- 직급(JOB) / 급여등급(SAL_GRADE)
-- ** 오라클 구문 **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE E, DEPARTMENT, LOCATION L, NATIONAL N, JOB J, SAL_GRADE
WHERE DEPT_CODE = DEPT_ID           --EMPLOYEE -- DEPARTMENT
    AND E.JOB_CODE = J.JOB_CODE     --EMPLOYEE -- JOB
    AND SALARY BETWEEN MIN_SAL AND MAX_SAL  --EMPLOYEE -- SAL_GRADE
    AND LOCATION_ID = LOCAL_CODE        --DEPARTMENT -- LOCATION
    AND L.NATIONAL_CODE = N.NATIONAL_CODE;   -- LOCATION -- NATIONAL
    
-- ** ANSI 구문 **
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME, SAL_LEVEL
FROM EMPLOYEE
    JOIN DEPARTMENT ON DEPT_CODE = DEPT_ID
    JOIN JOB USING (JOB_CODE)
    JOIN SAL_GRADE ON SALARY BETWEEN MIN_SAL AND MAX_SAL
    JOIN LOCATION ON LOCATION_ID = LOCAL_CODE
    JOIN NATIONAL USING (NATIONAL_CODE);