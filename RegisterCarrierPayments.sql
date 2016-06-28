set long 32767 pagesize 0 linesize 800 feedback off echo off verify off trims on
spool &1;
--������ �������� � ������������
select 'ORGANIZATIONID;INN;BIC;MIFAREUID;TRANSPORTCARDID;TICKETID;AMOUNT' from dual;
--REGISTERCARRIERPAYMENTS 
  SELECT O.CODE||';'||J.INN||';'||B.BIC||';'||SUBSTR(T.CARD_CHIP,1,8)||';964310380'||T.CARD_NUM||';'||LPAD(T.CARD_SERIES,4,'0')||';'||T.AMOUNT*100
 FROM CPTT.T_DATA T
 INNER JOIN CPTT.CARD C ON T.ID_CARD=C.ID
 INNER JOIN CPTT.TERM TT ON T.ID_TERM=TT.ID
 INNER JOIN CPTT.DIVISION D ON TT.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 INNER JOIN CPTT.REF_JPERSON J ON O.ID_JPERSON=J.ID
 INNER JOIN CPTT.REF_BANK B ON J.ID_BANK_ACCOUNT=B.ID
 WHERE
T.CARD_SERIES in (15, 16) --����� ����
AND  O.CODE in
(  
'0080', --������
'0030' --�����
,'0031'--���
)
AND  (T.KIND=16)--���� ����������
 AND TO_CHAR(TRUNC(T.INS_DATE,'DD'), 'YYYYMMDD') = &2 --����;
spool off;
exit;