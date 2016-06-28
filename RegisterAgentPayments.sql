set long 32767 pagesize 0 linesize 800 feedback off echo off verify off trims on
spool &1;
--������ ���������� ���������
select 'ORGANIZATIONID;INN;BIC;MIFAREUID;TRANSPORTCARDID;TICKETID;AMOUNT' from dual;
--REGISTERAGENTPAYMENTS 
  SELECT O.CODE||';'||J.INN||';'||B.BIC||';'||SUBSTR(T.CARD_CHIP,1,8)||';964310380'||T.CARD_NUM||';'||LPAD(T.CARD_SERIES,4,'0')||';'||(T.AMOUNT-NVL(T.AMOUNT_BAIL,0))*100
 FROM CPTT.T_DATA T
 INNER JOIN CPTT.CARD C ON T.ID_CARD=C.ID
 INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 INNER JOIN CPTT.REF_JPERSON J ON O.ID_JPERSON=J.ID
 INNER JOIN CPTT.REF_BANK B ON J.ID_BANK_ACCOUNT=B.ID
 WHERE
T.CARD_SERIES in (15,16) --����� ����
AND  O.CODE = '0010' --��� ������
AND  (T.KIND=10 OR T.KIND=7 OR T.KIND=8 OR T.KIND=11 OR T.KIND=12 OR T.KIND=13)--���� ����������
 AND TO_CHAR(TRUNC(T.DATE_OF,'DD'), 'YYYYMMDD') = &2 --����;
spool off;
exit;
