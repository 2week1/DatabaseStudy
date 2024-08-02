/*
    * PL/SQL : PROCEDURE LANGUAGE EXTENSION TO SQL

    ����Ŭ ��ü�� ����Ǿ� �ִ� �������� ���
    SQL ���� ������ ���� ����, ����, �ݺ����� �����Ͽ� SQL�� ������ ��ȯ
    �ټ��� SQL���� �ѹ��� ���డ��
    
    *����*
    [�����]   : DECLARE �� ����
    �����     : BEGIN ���� ����, SQL �� �Ǵ� ���(���ǹ�, �ݺ���) ���� ������ �ۼ��ϴ� �κ�
    [����ó����] : EXCEPTION���� ����. ���� �߻� �� �ذ��ϱ� ���� �κ�
*/
SET SERVEROUTPUT ON;    --ȭ�鿡 ǥ���ϱ� ���� ����

-- HELLO ORACLE ��� : ȭ�鿡 ����ϰ��� �� �� DBMS_OUTPUT.PUT_LINE (����� ����)

BEGIN
    -- �ڹ� : System.out.println("Hello Java!");
    DBMS_OUTPUT.PUT_LINE('HELLO ORACLE!');
END;
/
--------------------------------------------------------------------------------
/*
    * ����� (DECLARE)
    : ���� �Ǵ� ����� �����ϴ� �κ� (����� ���ÿ� �ʱ�ȭ�� ����)
    
    - ������ Ÿ�� ���� ����
        + �Ϲ� Ÿ��
        + ���۷��� Ÿ��
        + ROW Ÿ��
*/

/*
    * �Ϲ� Ÿ�� ����
    ������ �ڷ��� [:=��];
    -- ��� ���� �� CONSTANT �� �ٿ���
    -- �ʱ�ȭ�� ���� := ��ȣ�� ���
*/

DECLARE
    EID NUMBER;                 -- EID ��� �̸��� NUMBER Ÿ�� ���� ����
    ENAME VARCHAR2(20);         -- ENAME ��� �̸��� VARCHAR2(20) Ÿ�� ���� ����
    PI CONSTANT NUMBER := 3.14; -- PI ��� �̸��� NUMBER Ÿ�� ��� ���� �� 3.14 ������ �ʱ�ȭ
BEGIN
    -- ������ ���� ����
    EID := 100;     -- EID ��� ������ 100�̶�� ���� ����
    ENAME := '�Ӽ���'; -- ENAME �̶�� ������ �� �̸��� ������ ����
    
    -- �� ����, ����� ����� ���� ȭ�鿡 ���
    -- Ư�� ���ڿ� ������ ���� ����ϰ��� �� �� ���Ῥ����(||)�� ���!
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/

-- ���� �Է¹޾� ������ ����
DECLARE
    EID NUMBER;
    ENAME VARCHAR2(20);
    PI CONSTANT NUMBER := 3.14;

BEGIN
    EID := &��ȣ;
    ENAME := '�Ӽ���';
    
    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);    
    DBMS_OUTPUT.PUT_LINE('PI : ' || PI);
END;
/
--------------------------------------------------------------------------------

/*
    * ���۷��� Ÿ�� ����
    : � ���̺��� � �÷��� ������Ÿ���� �����Ͽ� �ش� Ÿ������ ������ ����
    
    ������ ���̺��.�÷���%TYPE
*/

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;           -- EID��� ������ EMPLOYEE ���̺��� EMP_ID �÷��� Ÿ���� ���� (VARCHAR2(3))
    ENAME EMPLOYEE.EMP_NAME%TYPE;       -- ENAME ������ EMPLOYEE ���̺��� EMP_NAME �÷��� Ÿ���� ���� (VARCHAR2(20))
    SAL EMPLOYEE.SALARY%TYPE;           -- SAL ������ EMPLOYEE ���̺��� SALARY �÷��� Ÿ���� ���� (NUMBER)
    
BEGIN
    -- EID := '100';
    -- ENAME := '�Ӽ���';
    -- SAL := 3000000;

    -- EMPLOYEE ���̺��� 200�� ����� ���, �����, �޿� ��ȸ
    SELECT EMP_ID, EMP_NAME, SALARY
    INTO EID, ENAME, SAL                --�� �÷��� ��� ���� ������ ����
    FROM EMPLOYEE
    WHERE EMP_ID = 200
    WHERE EMP_ID = &���;

    DBMS_OUTPUT.PUT_LINE('EID : ' || EID);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || SAL);
    
END;
/


--------------------------------------------------------------------------------
-- ���� -- 
/*
    ���۷��� Ÿ�� ������ EID, ENAME, JCODE, SAL, DTITLE�� �����ϰ� �� �ڷ����� EMPLOYEE���̺��� EMP_ID, EMP_NAME, JOB_CODE, SALARY �÷���
    DEPARTMENT ���̺��� DEPT_TITLE �÷��� �����ϵ��� �� �� ����ڰ� �Է��� ����� ��� ������ ��ȸ�Ͽ� ������ ��� ���
    
    ��� ���� : [���], [�̸�], [�����ڵ�], [����], [�μ���]

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
    WHERE EMPLOYEE.EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE(EID || ', ' || ENAME || ', ' || JCODE || ', ' || SAL || ', ' || DTITLE);
END;
/   

--------------------------------------------------------------------------------
 /*
 * ROW Ÿ�� ����
    : ���̺��� �� �࿡ ���� ��� �÷����� �ѹ��� ���� �� �ִ� ����
    
    ������ ���̺��%ROWTYPE;
 
 */   

DECLARE
    E EMPLOYEE%ROWTYPE;
BEGIN
    SELECT * 
    INTO E
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
-- �����, �޿�, ���ʽ� ������ ���
    DBMS_OUTPUT.PUT_LINE('����� :' || E.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� :' || E.SALARY);
    -- DBMS_OUTPUT.PUT_LINE('���ʽ� :' || E.BONUS);
    -- NULL ���� ��� 0���� ǥ���ϱ� ���� NVL �Լ� ��� ����!
    DBMS_OUTPUT.PUT_LINE('���ʽ� :' || NVL(E.BONUS, 0));
END;
/

--------------------------------------------------------------------------------

/*
    * �����(BEGIN)
    
    ** ���ǹ� **
        - ���� IF�� : IF ���ǽ� THEN ���೻�� END IF;
        IF/ELSE�� : IF ���ǽ� THEN ���ǽ��� ���� �� ���೻�� ELSE ���ǽ��� �����϶� ���೻�� END IF;
        - IF/ELSE �� : IF ���ǽ�1 THEN ���೻��1 ELSIF ���ǽ�2 THEN ���೻��2... [ELSE ���೻��] END IF;
        
        - CASE/WHEN/THEN ��
            CASE �񱳴�� WHEN ����񱳰�1 �����1
                         WHEN ����񱳰�2 �����2
                         WHEN ����񱳰�3 �����3
                            ...
                        ELSE �����N
        END;
*/        
-- ����ڿ��� ����� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ� ������ ���
-- �� �����Ϳ� ���� ���� : ���(EID), �̸�(ENAME), �޿�(SAL), ���ʽ� (BONUS)
-- ��, ���ʽ����� 0�� ����� ��� "���ʽ��� ���� �ʴ� ����Դϴ�." ���

DECLARE
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
    SAL EMPLOYEE.SALARY%TYPE;
    BONUS EMPLOYEE.BONUS%TYPE;

BEGIN

    SELECT EMP_ID, EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO EID, ENAME, SAL, BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� :'  || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� :'  || ENAME);
    DBMS_OUTPUT.PUT_LINE('�޿� :'  || SAL);
    
    IF BONUS = 0
        THEN DBMS_OUTPUT.PUT_LINE ('���ʽ��� ���� �ʴ� ����Դϴ�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ� :'  || BONUS);
    END IF;
END;
/
--------------------------------------------------------------------------------
/*
    DECLARE
        -- ���۷��� ���� (EID, ENAME, DTITLE, NCODE)
            ��������(EMP_ID, EMP_NAME, DEPT_TITLE, NATIONAL_CODE)
        -- �Ϲ�Ÿ�Ժ��� (TEAM ����Ÿ��) --> '������' �Ǵ� '�ؿ���' ������ ����
    BEGIN
        -- ����ڰ� �Է��� ����� �ش��ϴ� ���, �̸�, �μ���, �ٹ������ڵ� ��ȸ
        -- ��ȸ �� �ش� ���� ������ ����
        
        -- �̶�, NCODE�� ���� KO�� ��� '������'�� TEAM ������ ����
                            KO�� �ƴ� ��� '�ؿ���'�� TEAM ������ ����
                            
        -- ��� ���� : ���, �̸�, �μ�, �Ҽ�
        
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
    
    WHERE EMP_ID = &���;
    
    IF NCODE = 'KO'
        THEN TEAM := '������';
    ELSE
        TEAM := '�ؿ���';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || DTITLE);
    DBMS_OUTPUT.PUT_LINE('�Ҽ� : ' || TEAM);
END;
/
--------------------------------------------------------------------------------
/*
    ����(SCORE)
    ���(GRADE) = 'A', 'B', 'C', 'D', 'F'
    
    ����ڿ��� ������ �Է¹޾�
    90�� �̻��̸� 'A'
    80�� �̻��̸� 'B'
    70�� �̻��̸� 'C'
    60�� �̻��̸� 'D'
    �� �Ʒ��� 'F'
    
    << ��� >>
    "������ XX�̰�, ����� X�Դϴ�."
    ���� F����̶�� "���� ����Դϴ�.
    
*/
DECLARE
    SCORE NUMBER;
    GRADE CHAR(1);
BEGIN
    SCORE := &����;
    
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
    
    DBMS_OUTPUT.PUT_LINE('������ ' || SCORE || ' �̰� ����� ' || GRADE || ' �Դϴ�.');
    IF GRADE = 'F'
        THEN DBMS_OUTPUT.PUT_LINE('���� ����Դϴ�.');
        
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
    WHERE EMP_ID = &���;
    
    -- �ش� ����� �μ��ڵ� �������� �μ��� ���� --
    DTITLE := CASE EMP.DEPT_CODE
                WHEN 'D1' THEN '�λ������'
                WHEN 'D2' THEN 'ȸ�������'
                WHEN 'D3' THEN '�����ú�'
                WHEN 'D4' THEN '����������'
                WHEN 'D5' THEN '�ؿܿ���1��'
                WHEN 'D6' THEN '�ؿܿ���2��'
                WHEN 'D7' THEN '�ؿܿ���3��'
                WHEN 'D8' THEN '���������'
                WHEN 'D9' THEN '�ѹ���'
                ELSE '�μ� ����'
            END;
--------------------------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE(EMP.EMP_NAME || '����� �ҼӺμ��� ' || DTITLE || '�Դϴ�.');
END;
/

SELECT * FROM DEPARTMENT;
--------------------------------------------------------------------------------

/*
    * �ݺ���
        - �⺻ ���� : LOOP 
                        �ݺ��� ����
                        �ݺ����� ������ ����
                    END LOOP;
                    
                    * �ݺ����� ������ ����
                    [1] IF ���ǽ� THEN EXIT; END IF;
                    [2] EXIT WHIN ���ǽ�;
                    
                - FOR LOOP��
                    FOR ���� IN [REVERSE] �ʱⰪ..������
                    LOOP �ݺ��ұ��� END LOOP;
                    
                    * REVERSE : ���������� �ʱⰪ���� �ݺ�
                    
            - WHILE LOOP ��
                WHILE ���ǽ� 
                LOOP �ݺ��ұ��� END LOOP;
*/

-- �⺻������ ����Ͽ� 'HELLO ORACLE'�� 5�� ���

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

-- FOR LOOP ���� ����Ͽ� HELLO ORACLE! 5�� ���

BEGIN
    FOR I IN 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(I || ') HELLO ORACLE!');
    END LOOP;
    END;
    /
--------------------------------------------------------------------------------
-- TEST ���̺� ����
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

--TEST ���̺� �����͸� 100�� �߰� (TNO: ������ ���, TDATE: ���� ��¥)


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
    * ���� ó����
        - ���� (EXCEPTION) : ���� �� �߻��ϴ� ����
    
    EXCEPTION 
        WHEN ���ܸ� THEN ����ó������;
        WHEN ���ܸ� THEN ����ó������;
        ...
        WHEN OTHERS THEN ����ó������;
        
        * ����Ŭ���� �̸� ������ ���� => �ý��� ����
            - NO_DATA_FOUND : ��ȸ�� ����� ���� ��
            - TOO_MANY_ROWS : ��ȸ�� ����� ���� ���� �� (-> ������ ����..)
            - ZERO_DIVIDE : 0���� ���� �������� �� ��
            - DUP_VAL_ON_INDEX : UNIQUE ���ǿ� ����� �� (�ߺ��Ǵ� ���)
            ...
        * OTHERS : � ���ܵ� �߻��Ǿ��� ��
*/

-- ����ڿ��� ���ڸ� �Է¹޾� 10���� ���� ����� ���. (0�� �ԷµǾ��� ���� ������ �߻��� �� �ִ� ...)

DECLARE
    NUM NUMBER;
BEGIN
    NUM := &����;
    DBMS_OUTPUT.PUT_LINE(10/NUM);
EXCEPTION
    -- WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('0���� ���� �� �����ϴ�');
END;
/

-- EMPLOYEE ���̺� EMP_ID �÷��� �⺻Ű�� ����
-- ALTER TABLE EMPLOYEE ADD PRIMARY KEY (EMP_ID);

-- �⺻Ű (PRIMARY KEY) : UNIQUE + NOT NULL

BEGIN
    UPDATE EMPLOYEE
    SET EMP_ID = '&�����һ��'
    WHERE EMP_NAME = '���ö';
    
EXCEPTION 
    WHEN DUP_VAL_ON_INDEX THEN DBMS_OUTPUT.PUT_LINE('�ߺ��� ����Դϴ�.');
END;
/

--------------------------------------����--------------------------------------
/*
    * ����� ����� �Է¹޾� �ش� ����� ���, �̸��� ���
*/
DECLARE 
    EID EMPLOYEE.EMP_ID%TYPE;
    ENAME EMPLOYEE.EMP_NAME%TYPE;
BEGIN
    SELECT EMP_ID, EMP_NAME
    INTO EID, ENAME
    FROM EMPLOYEE
    WHERE MANAGER_ID = '&������';         -- ����Ÿ������ �Է¹ް��� �� ��� ��������ǥ�� �����ش�.
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || ENAME);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('�Է��� �������� ���� ����� �����ϴ�');
    WHEN TOO_MANY_ROWS THEN DBMS_OUTPUT.PUT_LINE('�ش� ����� ���� ����� �����ϴ�.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('������ �߻��Ͽ����ϴ�. �����ڿ��� �����ϼ���!');
END;  
/*

     * Ʈ���� (TRIGGER)
     : ������ ���̺� DML(INSERT, UPDATE, DELETE)���� ���� ��������� ���� �� (���̺� �̺�Ʈ�� �߻����� ��)
        �ڵ����� �Ź� ������ ������ �̸� �����صδ� ��
        
        ex) ȸ�� Ż�� �� ���� ȸ�����̺��� ������ ���� (DELETE)�ϰ�
            Ż�� ȸ�� ���̺� ������ �߰�(INSERT) �ؾ� �� �� �ڵ����� ����
            
        ex) �Ű�Ƚ���� Ư�� ���� �Ѿ�� �� �ش� ȸ���� ������Ʈ ó��
        
        ex) ����� ���� �����͸� ����� �� �ش� ��ǰ�� ��� ������ �����ؾ� �� ��
*/

/*
    * Ʈ������ ���� *
    
    - SQL ���� ���� �ñ⿡ ���� �з�
        + BEFORE TRIGGER : ������ ���̺� �̺�Ʈ�� �߻��ϱ� ���� Ʈ���� ����
        + AFTER TRIGGER  : ������ ���̺� �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ����
    
    - SQL ���� ���� ������ �޴� �� �࿡ ���� �з�
    + ���� Ʈ����    : �̺�Ʈ�� �߻��� SQL���� ���� �� �ѹ��� Ʈ���� ����
    + �� Ʈ����      : �ش� SQL���� ����ɶ����� �Ź� Ʈ���� ����
                      FOR EACH ROW �ɼ� ���� �ʿ�
                      
                      :OLD - BEFORE UPDATE (���� �� �ڷ�), BEFORE DELETE (���� �� �ڷ�)
                      :NEW - AFTER INSERT (�߰��� �ڷ�), AFTER UPDATE(���� �� �ڷ�)
*/

/*
    * Ʈ���� �����ϱ�
    
    CREATE [OR REPLACE] TRIGGER Ʈ�����̸�                   -- Ʈ���� �⺻���� (�̸�)
    BEFORE | AFTER  INSERT | UPDATE | DELETE ON ���̺��    -- �̺�Ʈ ���� ����
    [FOR EACH ROW]                                          -- �Ź� Ʈ���Ÿ� ������ �������� ���� �ɼ�
    
    [DECLARE]       -- ���� / ��� ���� �� �ʱ�ȭ
    BEGIN           -- �����(SQL��, ���ǹ�, �ݺ���...)
                        �̺�Ʈ �߻� �� �ڵ����� ó���� ����
    [EXCEPTION]     -- ����ó����
    END;
    /
    
*/

-- EMPLOYEE ���̺� �����Ͱ� �߰��� ������ '���Ի���� ȯ���մϴ�. ^^' ���
CREATE TRIGGER TRG_01
AFTER INSERT ON EMPLOYEE
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� ȯ���մϴ� ^^');
END;
/

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (500, '������', '000501-3000000', 'D4', 'J4',SYSDATE);

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE, JOB_CODE, HIRE_DATE)
    VALUES (501, '����â', '950704-1000000', 'D6', 'J5',SYSDATE);
--------------------------------------------------------------------------------
-- ��ǰ �԰� �� ��� ����

-- * ���̺�, ������ ����
-- ��ǰ�� �����ϱ� ���� ���̺�
CREATE TABLE TB_PRODUCT (
    PNO NUMBER PRIMARY KEY,      -- ��ǰ��ȣ
    PNAME VARCHAR2(30) NOT NULL, -- ��ǰ��
    BRAND VARCHAR2(30) NOT NULL, -- �귣��
    PRICE NUMBER DEFAULT 0,      -- ����
    STOCK NUMBER DEFAULT 0       -- ��� ����
);


-- ��ǰ��ȣ�� ����� ������ (���۹�ȣ 200, ������ 5, ĳ�ø޸� X)
CREATE SEQUENCE SEQ_PNO 
START WITH 200
INCREMENT BY 5
NOCACHE;

-- ���� ������ �߰�
INSERT INTO TB_PRODUCT(PNO, PNAME, BRAND) VALUES (SEQ_PNO.NEXTVAL, '������15', '���');
INSERT INTO TB_PRODUCT VALUES(SEQ_PNO.NEXTVAL, '������ ����6', '����', 2000000, 50);
INSERT INTO TB_PRODUCT VALUES (SEQ_PNO.NEXTVAL, '������', '�����', 80000, 500);

SELECT * FROM TB_PRODUCT;

COMMIT;     -- DB�� �ݿ��ϱ�

-- ��ǰ ����� ������ �����ϱ� ���� ���̺�

CREATE TABLE TB_PDETAIL (
    DNO NUMBER PRIMARY KEY,             -- ������ȣ
    PNO NUMBER REFERENCES TB_PRODUCT,   -- ��ǰ ��ȣ
    DDATE DATE DEFAULT SYSDATE,         -- �������
    AMOUNT NUMBER NOT NULL,             -- ����� ����
    TYPE CHAR(6) CHECK(TYPE IN ('�԰�', '���')) -- ����� ����
);

-- ����� ������ ���� ������ (������ȣ)
CREATE SEQUENCE SEQ_DNO
NOCACHE;

-- 205�� ��ǰ, ���ó�¥, 5�� ���
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 205, DEFAULT, 5, '���');

-- * TB_PRODUCT ���̺� ������Ʈ
UPDATE TB_PRODUCT
    SET STOCK = STOCK - 5
WHERE PNO = 205;

ROLLBACK;   -- ���� �������� ������ �־� �ѹ�

SELECT * FROM TB_PDETAIL;
SELECT * FROM TB_PRODUCT;       -- ���� ������ 5�� �� �� ������Ʈ

-- 200 �� (������15) ��ǰ�� ��� 10�� �԰�
INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, DEFAULT, 10, '�԰�');

UPDATE TB_PRODUCT
    SET STOCK = STOCK + 10
    WHERE PNO = 200;

COMMIT;
--------------------------------------------------------------------------------
/*
    TB_PDETAIL (������̷�) ���̺� ������ �߰�(INSERT) �̺�Ʈ �߻� ��
    TB_PRODUCT (��ǰ) ���̺� ��� ������ ����(UPDATE) �Ǿ�� ��! -> �ڵ����� ó���� �� �ֵ��� Ʈ���� ����!
    
    - UPDATE ����
     * ��ǰ�� �԰�� ��� -> �ش� ��ǰ�� ã�Ƽ� ��� ���� ����
        UPDATE TB_PRODUCT
            SET STOCK = STOCK + �԰����(TB_PDETAIL.AMOUNT) --> :NEW.AMOUNT
            WHERE PNO = �԰�Ȼ�ǰ��ȣ(TB_PDETAIL.PNO)       --> :NEW.PNO
    * ��ǰ�� ���� ��� -> �ش� ��ǰ�� ã�Ƽ� ��� ���� ����
        UPDATE TB_PRODUCT
            SET STOCK = STOCK - ������(TB_PDETAIL.AMOUNT) --> :NEW.AMOUNT
            WHERE PNO = ���Ȼ�ǰ��ȣ(TB_PDETAIL.PNO)       --> :NEW.PNO 
*/

-- ** TRG_02 Ʈ���� ���� **

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON TB_PDETAIL
FOR EACH ROW
BEGIN 
    IF :NEW.TYPE = '�԰�' 
        THEN UPDATE TB_PRODUCT 
                SET STOCK = STOCK + :NEW.AMOUNT
            WHERE PNO = :NEW.PNO;
    ELSE UPDATE TB_PRODUCT 
                SET STOCK = STOCK - :NEW.AMOUNT
            WHERE PNO = :NEW.PNO;
    END IF;
END;
/

INSERT INTO TB_PDETAIL VALUES (SEQ_DNO.NEXTVAL, 200, SYSDATE, 100, '�԰�');

SELECT * FROM TB_PRODUCT;

COMMIT;


