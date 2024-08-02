-- 사용자 계정을 접속해주세요. (사용자명: C##KH / 비밀번호: KH)
--  해당 계정이 없을 경우 추가 후 kh.sql 스크립트 실행하여 아래 내용을 수행해주세요.

-- 사원 테이블에서 모든 정보 조회
SELECT * FROM EMPLOYEE;

-- 보너스가 있는 사원의 사원명, 급여, 보너스, 직급코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE FROM EMPLOYEE WHERE BONUS IS NOT NULL;

-- 이메일의 3번째 글자가 m인 사원의 모든 정보 조회
SELECT * FROM EMPLOYEE WHERE EMAIL LIKE '__m%';
-- 와일드카드 기호를 값으로써 사용하고자 한다면 LIKE'__\_' ESCAPE '\' 와 같이 작성해야 함!

-- 여자 사원 수 조회
SELECT COUNT (*) FROM EMPLOYEE 
WHERE SUBSTR(EMP_NO, 8, 1) IN (2, 4);

-- 퇴사하지 않은 사원의 급여 합 조회
SELECT TO_CHAR(SUM(SALARY), 'L99,999,999') "급여 합" FROM EMPLOYEE 
WHERE ENT_YN = 'N';
-- WHERE ENT_DATE IS NULL;

-- 9월에 입사한 사원 수 조회
SELECT COUNT (*) FROM EMPLOYEE
WHERE EXTRACT(MONTH FROM HIRE_DATE) = 9;
-- 입사일 컬럼에서 월 정보만 추출하여 9인지 비교


/*
	* 검색하고자 하는 내용 :
	
		직급코드가 J7이거나 J6이면서 SALARY 값이 200만원 이상이고
		BONUS가 있고 여자이며 이메일주소는 _앞에 3글자만 있는 사원의
		사원명, 주민등록번호, 직급코드, 부서코드, 급여, 보너스를 조회하고자 한다.
		
		(정상적으로 조회가 된다면 2개의 결과를 확인할 수 있음)
*/


-- 아래 쿼리문에서 실행 시 원하는 결과가 나오지 않는다. 
--  어떤 문제가 있는 지 원인을 파악하여 작성한 후, 해결해주세요.
SELECT EMP_NAME, EMP_NO, JOB_CODE, DEPT_CODE, SALARY, BONUS
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J6') -- JOB_CODE IN ('J7','J6')
      AND SALARY > 2000000
      AND EMAIL LIKE '___#_%' ESCAPE '#'
      AND BONUS IS NOT NULL
      AND SUBSTR(EMP_NO, 8, 1) IN(2, 4);
-- 원인 : 
/* 
    1) 직급코드에 대한 조건이 우선순위로 인해 제대로 실행되지 않음
    -> 괄호로 묶어주거나 IN 연산자로 대체해야 함
    
    2) 작성된 조건은 SALARY 값이 200만원 초과(>) 로 작성되어 있음
    => 200만원 이상인 조건은 등호를 추가해줘야 함 (>=)
    
    3) 이메일의 4번째 자리에 언더바(_)를 값으로써 조건을 주고자 한다면 ESCAPE를 사용하여 나만의 와일드카드로 구분해줘야 함
    
    4) 보너스가 있는 사원을 조회해야 하는데 없는 사원을 조회하고 있음
    => BONUS IS NULL --> BONUS IS NOT NULL로 변경해줘야 함
    
    5) 여자 사원 조건이 누락됨
    => 여자 사원 조건을 추가해줘야 함
*/