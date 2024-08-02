/*
    * ������ (SEQUENCE)
    : �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
    
    ������ ���������� ������ ������ ������Ű�鼭 ����
    
    
    EX) �����ȣ, ȸ����ȣ, ������ȣ ...
*/

/*
    * ������ �����ϱ� *
    
    CREATE SEQUENCE ��������
    [START WITH ����] --> ó�� �߻���ų ���۰� ���� [���� �� �⺻���� 1]
    INCREMENT BY ���� --> �󸶸�ŭ�� ������ų �������� ���� �� ���� [�⺻�� : 1]
    [MAXVALUE ����]   --> �ִ� [�⺻��,,, ��û ŭ]
    [MINVALUE ����]   --> �ּڰ� [�⺻��: 1]
    [CYCLE | NOCYCLE] --> ���� ��ȯ���� [�⺻��: NOCYCLE]
                     --> CYCLE : ������ ���� �ִ񰪿� �����ϸ� �ּҰ����� �ٽ� ��ȯ�ϵ��� ����
                     --> NOCYCLE : ������ ���� �ִ񰪿� �����ϸ� �� �̻� ������Ű�� �ʵ��� ����
    [NOCACHE | CACHE ����] --> ĳ�ø޸� �Ҵ� ���� [�⺻�� : CACHE 20]
                          --> ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� ����
                                            �Ź� ȣ���� ������ ���� ��ȣ�� �����ϴ� ���� �ƴ϶� 
                                            ĳ�ø޸𸮶�� ������ �̸� ������ ������ �����ٰ� ���
                                            (�̸� �������� ������ �ӵ��� ����)
     [����]
     - �̸� �����ֱ� -
     * ���̺� : TB_
     * ��    : VW_
     * ������ : SEQ_
     * Ʈ���� : TRG_
*/

--SEQ_TEST��� �̸��� ������ ����
CREATE SEQUENCE SEQ_TEST;

-- * ���� ������ ������ �ִ� �������� ��ȸ
SELECT * FROM USER_SEQUENCES;

-- SEQ_EMPNO ��� �̸��� ������ ����
-- ���۹�ȣ�� 300, �������� 5, �ִ��� 310, ��ȯ X, ĳ�ø޸� X
CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
    * ������ ����ϱ� *
    
    - ��������.CURRVAL : ���� ������ �� (���������� ������ NEXTVAL�� ������ ��)
    - ��������.NEXTVAL : ������ ���� ���� ���� �������� �߻��� �����
                        ���� ������ ������ INCREMENT BY ������ �� ��ŭ ������ ��
*/

SELECT SEQ_EMPNO.CURRVAL FROM DUAL;     --���� �߻�!! NEXTVAL�� �ѹ��� �������� ���� �̻� CURRVAL �� ����� �� ����!

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;     -- ���� �� ó�� ���� �� ���� �� : 300

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;     -- 305

SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;     -- 310

SELECT * FROM USER_SEQUENCES;
SELECT SEQ_EMPNO.NEXTVAL FROM DUAL;     -- 315 ==> ���� �߻�! �ִ��� 310���� �����Ǿ� �־� �� �̻��� ���� ��ȸ�ǹǷ� ���� �߻�

/*
    * ������ ���� �����ϱ� *
    
    ALTER SEQUENCE ��������
    [INCREMENT BY ����]       --> ������ (�⺻��: 1)
    [MAXVALUE ����]           --> �ִ밪 (�⺻��: ��ûŭ..)
    [MINVALUE ����]           --> �ּҰ� (�⺻��: 1)
    [CYCLE | NOCYCLE]        --> �� ��ȯ���� (�⺻��: NOCYCLE)
    [NOCACHE | CACHE ����]    --> ĳ�ø޸� ��뿩�� ���� (����Ʈ����) (�⺻��: CACHE 20)

    --> START WITH ���� �Ұ�!
*/

-- SEQ_EMPNO �������� �������� 10, �ִ��� 400���� ����
ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

SELECT SEQ_EMPNO.NEXTVAL FROM DAUL;    --320. (310 +10)

--������ ����:DROP SEQUENCE ��������;
-- SEQ_EMPNO ������ ����
DROP SEQUENCE SEQ_EMPNO;

SELECT * FROM USER_SEQUENCES;
--------------------------------------------------------------------------------
/*
    EMPLOYEE ���̺��� ������ ����
    -> ������ ��� �÷�: �����ȣ (EMP_ID)
*/
-- * ������ �����ϱ�
CREATE SEQUENCE SEQ_EID
START WITH 300      -- ���۹�ȣ : 300
NOCACHE;

-- ���۰�: 300, ������: 1, ... ��ȯ���� : NOCYCLE, �ִ밪 : ��û ū ��...!!
-- * ������ ����ϱ� : EMPLOYEE ���̺��� �����Ͱ� �߰��� ��
INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '���ǿ�', '990928-1111111', 'J4' ,SYSDATE);

SELECT * FROM EMPLOYEE;

INSERT INTO EMPLOYEE (EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, HIRE_DATE)
    VALUES (SEQ_EID.NEXTVAL, '���Ǽ�', '990928-1111111', 'J4' ,SYSDATE);
    
ROLLBACK;    