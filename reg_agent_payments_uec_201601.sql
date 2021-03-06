/*
--������ ���������� ���������
select 'ORGANIZATIONID;INN;BIC;MIFAREUID;TRANSPORTCARDID;TICKETID;AMOUNT' from dual;
--REGISTERAGENTPAYMENTS 
  SELECT '3801;3812155469;044583722;'||SUBSTR(MAX(T.CARD_CHIP),1,8)||';964310380'||T.CARD_NUM||';'||LPAD(MAX(T.CARD_SERIES),4,'0')||';15000'
 FROM CPTT.T_DATA T
-- INNER JOIN CPTT.CARD C ON T.ID_CARD=C.ID
 INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 --INNER JOIN CPTT.REF_JPERSON J ON O.ID_JPERSON=J.ID
 --INNER JOIN CPTT.REF_BANK B ON J.ID_BANK_ACCOUNT=B.ID
 WHERE
T.CARD_SERIES in (60,63) --����� ����
 and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014','0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
AND   T.KIND=17
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01012016'
GROUP BY T.CARD_NUM --, O.CODE
ORDER BY T.CARD_NUM --, O.CODE
*/

--select 'ORGANIZATIONID;INN;BIC;MIFAREUID;TRANSPORTCARDID;TICKETID;AMOUNT' from dual
--UNION
--
SELECT 
--'3801;3812155469;044583722;'||SUBSTR(MAX(T.CARD_CHIP),1,8)||';964310380'||T.CARD_NUM||';'||LPAD(MAX(T.CARD_SERIES),4,'0')||';15000' as NUM
 --,SUBSTR(MAX(T.CARD_CHIP),1,8) as CHIP1, T.CARD_NUM
--, O.CODE
-- , count (*) as kol_t
--T.*
--T.card_num, T.date_to, T.amount, T.amount_bail, T.amount_discount
T.date_to, count(*) as kol, SUM(T.amount) as s
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
   -- INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 WHERE 
     --T.CARD_SERIES  in (60,63) 
     T.CARD_SERIES =83
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014','0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
AND   T.KIND  in (7,12)
GROUP by T.DATE_TO
--GROUP BY '964310380'||T.CARD_NUM --, O.CODE
--ORDER BY  '964310380'||T.CARD_NUM --, O.CODE
--GROUP BY T.CARD_NUM --, O.CODE
--ORDER BY T.CARD_NUM --, O.CODE



