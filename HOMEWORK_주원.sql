/* 
                                2024 / 07 / 28 과제
*/

-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열" 
-- 으로 표시하도록 한다. DEPARTMENT_NAME / CATEGORY

SELECT DEPARTMENT_NAME 학과명, CATEGORY 계열 FROM TB_DEPARTMENT ;

-- 2.  학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다. DEPARTMENT_NAME / CAPACITY

SELECT DEPARTMENT_NAME||'의 정원은 '|| CAPACITY||'명 입니다' "학과별 정원" FROM TB_DEPARTMENT;

--  3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이 
-- 들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 
-- 찾아 내도록 하자)
SELECT STUDENT_NAME  FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) 
    WHERE DEPARTMENT_NO = '001' AND ABSENCE_YN = 'Y' AND (SUBSTR(STUDENT_SSN, 8, 1) IN('2','4'));

-- 4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다. 그 대상자들의 
--학번이 다음과 같을 때 대상자들을 찾는 적절한 SQL 구문을 작성하시오.  

SELECT STUDENT_NAME "범인 검거 삐용삐용" FROM TB_STUDENT 
WHERE STUDENT_NO  IN ( 'A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 5. 입학정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 출력하시오. DEPARTMENT_NAME / CATEGORY 
 SELECT DEPARTMENT_NAME, CATEGORY FROM  TB_DEPARTMENT 
 WHERE (CAPACITY >=20 AND CAPACITY <= 30);


-- 6. 춘 기술대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.  그럼 춘 
-- 기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오. 

SELECT PROFESSOR_NAME FROM TB_PROFESSOR WHERE PROFESSOR_NO ='P052';

-- 7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다. 
-- 어떠한 SQL 문장을 사용하면 될 것인지 작성하시오. 
SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE DEPARTMENT_NO IS NULL;

-- 8. 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는 
-- 과목들은 어떤 과목인지 과목번호를 조회해보시오.

SELECT CLASS_NO FROM TB_CLASS WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오. 
SELECT DISTINCT(CATEGORY) FROM TB_DEPARTMENT;

-- 10. 02 학번 전주 거주자들의 모임을 만들려고 핚다. 휴학한 사람들은 제외한 재학중인 
-- 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오. 

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN FROM TB_STUDENT 
WHERE STUDENT_NO LIKE('A2%') AND STUDENT_ADDRESS LIKE('전주%') AND ABSENCE_YN = 'N';  


--                      [Additional SELECT - 함수] 

-- 1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른 
-- 순으로 표시하는 SQL 문장을 작성하시오.( 단, 헤더는 "학번", "이름", "입학년도" 가 
-- 표시되도록 한다.) 

SELECT STUDENT_NO 학번,STUDENT_NAME 이름,TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') 입학년도 FROM TB_STUDENT 
WHERE DEPARTMENT_NO ='002' 
ORDER BY(ENTRANCE_DATE);

-- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 핚 명 있다고 한다. 그 교수의 
-- 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. (* 이때 올바르게 작성한 SQL 
-- 문장의 결과 값이 예상과 다르게 나올 수 있다. 원인이 무엇일지 생각해볼 것)

SELECT PROFESSOR_NAME, PROFESSOR_SSN FROM TB_PROFESSOR WHERE PROFESSOR_NAME NOT LIKE ('___');

    /*
    3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단 
    이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. (단, 교수 중 
    2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만’으로 
    계산한다.) 
    */
    
   --!! TODO::// SELECT PROFESSOR_NAME 나이,  EXTRACT(YEAR FROM SYSDATE) - EXTRACT(TO_DATE(PROFESSOR_SSN, ‘YYYYMMDD’)) 만나이 FROM TB_PROFESSOR;
   
   
-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는 
-- ?이름? 이 찍히도록 한다. (성이 2자인 경우는 교수는 없다고 가정하시오)

SELECT SUBSTR(PROFESSOR_NAME, 2,3) 이름 FROM TB_PROFESSOR;

-- 5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가?  이때, 
-- 19살에 입학하면 재수를 하지 않은 것으로 간주한다. 
-- TODO::// SELECT STUDENT_NAME,ENTRANCE_DATE FROM TB_STUDENT WHERE (ENTRANCE_DATE - STUDENT_NO >19);

-- 6. 2020년 크리스마스는 무슨 요일인가?
SELECT TO_CHAR('2020/12/10') 날짜
     , TO_CHAR(SYSDATE, 'DY') 요일 
  FROM DUAL;
  
--  7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')  은 각각 몇 년 몇 
-- 월 몇 일을 의미할까? 또 TO_DATE('99/10/11','RR/MM/DD'), 
-- TO_DATE('49/10/11','RR/MM/DD') 은 각각 몇 년 몇 월 몇 일을 의미할까?
SELECT 
    TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'), 'YYYY-MM-DD') Date1,
    TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'), 'YYYY-MM-DD') Date2,
    TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYY-MM-DD') Date3,
    TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYY-MM-DD') Date4
FROM 
    DUAL;
    
-- 8. 춘 기술대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 2000년도 
-- 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오.     

SELECT STUDENT_NO, STUDENT_NAME FROM TB_STUDENT WHERE STUDENT_NO NOT LIKE('A%');


-- 9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단, 
-- 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한 
-- 자리까지만 표시한다. 

-- TODO ::// SELECT ROUND(SUM(POINT)/8) FROM TB_GRADE WHERE STUDENT_NO = 'A517178';

-- 10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이 
-- 출력되도록 하시오.

SELECT DEPARTMENT_NO, STUDENT_NO FROM TB_STUDENT GROUP BY STUDENT_NO HAVING COUNT(*) >2;