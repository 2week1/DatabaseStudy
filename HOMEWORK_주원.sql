/* 
                                2024 / 07 / 28 ����
*/

-- 1. �� ������б��� �а� �̸��� �迭�� ǥ���Ͻÿ�. ��, ��� ����� "�а� ��", "�迭" 
-- ���� ǥ���ϵ��� �Ѵ�. DEPARTMENT_NAME / CATEGORY

SELECT DEPARTMENT_NAME �а���, CATEGORY �迭 FROM TB_DEPARTMENT ;

-- 2.  �а��� �а� ������ ������ ���� ���·� ȭ�鿡 ����Ѵ�. DEPARTMENT_NAME / CAPACITY

SELECT DEPARTMENT_NAME||'�� ������ '|| CAPACITY||'�� �Դϴ�' "�а��� ����" FROM TB_DEPARTMENT;

--  3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� 
-- ���Դ�. �����ΰ�? (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� 
-- ã�� ������ ����)
SELECT STUDENT_NAME  FROM TB_STUDENT
    JOIN TB_DEPARTMENT USING(DEPARTMENT_NO) 
    WHERE DEPARTMENT_NO = '001' AND ABSENCE_YN = 'Y' AND (SUBSTR(STUDENT_SSN, 8, 1) IN('2','4'));

-- 4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� �Ѵ�. �� ����ڵ��� 
--�й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�.  

SELECT STUDENT_NAME "���� �˰� �߿�߿�" FROM TB_STUDENT 
WHERE STUDENT_NO  IN ( 'A513079', 'A513090', 'A513091', 'A513110', 'A513119');

-- 5. ���������� 20�� �̻� 30�� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�. DEPARTMENT_NAME / CATEGORY 
 SELECT DEPARTMENT_NAME, CATEGORY FROM  TB_DEPARTMENT 
 WHERE (CAPACITY >=20 AND CAPACITY <= 30);


-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�.  �׷� �� 
-- ������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�. 

SELECT PROFESSOR_NAME FROM TB_PROFESSOR WHERE PROFESSOR_NO ='P052';

-- 7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�. 
-- ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�. 
SELECT DEPARTMENT_NO FROM TB_STUDENT WHERE DEPARTMENT_NO IS NULL;

-- 8. ������û�� �Ϸ��� �Ѵ�. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ� 
-- ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.

SELECT CLASS_NO FROM TB_CLASS WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�. 
SELECT DISTINCT(CATEGORY) FROM TB_DEPARTMENT;

-- 10. 02 �й� ���� �����ڵ��� ������ ������� ����. ������ ������� ������ �������� 
-- �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�. 

SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN FROM TB_STUDENT 
WHERE STUDENT_NO LIKE('A2%') AND STUDENT_ADDRESS LIKE('����%') AND ABSENCE_YN = 'N';  


--                      [Additional SELECT - �Լ�] 

-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ���� 
-- ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" �� 
-- ǥ�õǵ��� �Ѵ�.) 

SELECT STUDENT_NO �й�,STUDENT_NAME �̸�,TO_CHAR(ENTRANCE_DATE, 'YYYY-MM-DD') ���г⵵ FROM TB_STUDENT 
WHERE DEPARTMENT_NO ='002' 
ORDER BY(ENTRANCE_DATE);

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. �� ������ 
-- �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
-- ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)

SELECT PROFESSOR_NAME, PROFESSOR_SSN FROM TB_PROFESSOR WHERE PROFESSOR_NAME NOT LIKE ('___');

    /*
    3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. �� 
    �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� �� 
    2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ���������� 
    ����Ѵ�.) 
    */
    
   --!! TODO::// SELECT PROFESSOR_NAME ����,  EXTRACT(YEAR FROM SYSDATE) - EXTRACT(TO_DATE(PROFESSOR_SSN, ��YYYYMMDD��)) ������ FROM TB_PROFESSOR;
   
   
-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� ����� 
-- ?�̸�? �� �������� �Ѵ�. (���� 2���� ���� ������ ���ٰ� �����Ͻÿ�)

SELECT SUBSTR(PROFESSOR_NAME, 2,3) �̸� FROM TB_PROFESSOR;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�?  �̶�, 
-- 19�쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�. 
-- TODO::// SELECT STUDENT_NAME,ENTRANCE_DATE FROM TB_STUDENT WHERE (ENTRANCE_DATE - STUDENT_NO >19);

-- 6. 2020�� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR('2020/12/10') ��¥
     , TO_CHAR(SYSDATE, 'DY') ���� 
  FROM DUAL;
  
--  7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD')  �� ���� �� �� �� 
-- �� �� ���� �ǹ��ұ�? �� TO_DATE('99/10/11','RR/MM/DD'), 
-- TO_DATE('49/10/11','RR/MM/DD') �� ���� �� �� �� �� �� ���� �ǹ��ұ�?
SELECT 
    TO_CHAR(TO_DATE('99/10/11', 'YY/MM/DD'), 'YYYY-MM-DD') Date1,
    TO_CHAR(TO_DATE('49/10/11', 'YY/MM/DD'), 'YYYY-MM-DD') Date2,
    TO_CHAR(TO_DATE('99/10/11', 'RR/MM/DD'), 'YYYY-MM-DD') Date3,
    TO_CHAR(TO_DATE('49/10/11', 'RR/MM/DD'), 'YYYY-MM-DD') Date4
FROM 
    DUAL;
    
-- 8. �� ������б��� 2000�⵵ ���� �����ڵ��� �й��� A�� �����ϰ� �Ǿ��ִ�. 2000�⵵ 
-- ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.     

SELECT STUDENT_NO, STUDENT_NAME FROM TB_STUDENT WHERE STUDENT_NO NOT LIKE('A%');


-- 9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. ��, 
-- �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, ������ �ݿø��Ͽ� �Ҽ��� ���� �� 
-- �ڸ������� ǥ���Ѵ�. 

-- TODO ::// SELECT ROUND(SUM(POINT)/8) FROM TB_GRADE WHERE STUDENT_NO = 'A517178';

-- 10. �а��� �л����� ���Ͽ� "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� 
-- ��µǵ��� �Ͻÿ�.

SELECT DEPARTMENT_NO, STUDENT_NO FROM TB_STUDENT GROUP BY STUDENT_NO HAVING COUNT(*) >2;