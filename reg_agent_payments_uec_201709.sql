/*
--reestr of refillments 
--'3801;3812155469;044583722;'  UEC IO
--'3802;3801111847;042520607;' Socsystema
--select 'ORGANIZATIONID;INN;BIC;MIFAREUID;TRANSPORTCARDID;TICKETID;AMOUNT' from dual;
--REGISTERAGENTPAYMENTS 
  --SELECT '3801;3812155469;044583722;'||SUBSTR(T.CARD_CHIP,1,8)||';9643103883'||SUBSTR(T.CARD_NUM,2)||';'||LPAD(T.CARD_SERIES,4,'0')||';15000'
  SELECT DISTINCT '3802;3801111847;042520607;'||SUBSTR(T.CARD_CHIP,1,8)||';96431038'||nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)||SUBSTR(T.CARD_NUM,2)||';'||LPAD(nvl(T.NEW_CARD_SERIES, T.CARD_SERIES),4,'0')||';15000'
--SELECT '3802','3801111847','042520607',SUBSTR(T.CARD_CHIP,1,8),'9643103883'||SUBSTR(T.CARD_NUM,2), LPAD(T.CARD_SERIES,4,'0'),'15000'
 FROM CPTT.T_DATA T
-- INNER JOIN CPTT.CARD C ON T.ID_CARD=C.ID
 INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 --INNER JOIN CPTT.REF_JPERSON J ON O.ID_JPERSON=J.ID
 --INNER JOIN CPTT.REF_BANK B ON J.ID_BANK_ACCOUNT=B.ID
 WHERE
nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (82,83) --����� ����
 and O.CODE !=99  --''
AND   T.KIND in (7,12)
AND T.DATE_TO=TO_DATE('31.08.2017 00:00:00','DD.MM.YYYY HH24:MI:SS')

--exclude perevipusk
AND T.CARD_NUM  not in (
0
)
--double refillment
and T.ID not in (
0
)



--part 2
SELECT
-- DISTINCT 
--O.CODE, T.CARD_NUM, T.DATE_TO, T.DATE_OF, nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)
'3802;3801111847;042520607;'||SUBSTR(T.CARD_CHIP,1,8)||';9643103883'||SUBSTR(T.CARD_NUM,2)||';'||LPAD(nvl(T.NEW_CARD_SERIES, T.CARD_SERIES),4,'0')||';15000'
--DISTINCT T.CARD_NUM
 FROM CPTT.T_DATA T
 INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 WHERE
nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (80,82,83,84) 
--and O.CODE !=99
AND   T.KIND in (7,12)
--AND   T.KIND in (3)
AND T.DATE_TO=TO_DATE('31.08.2017 00:00:00','DD.MM.YYYY HH24:MI:SS')
AND T.CARD_NUM   in (
'000'
)

--part3  ����������� ���������� �� ������
SELECT
-- DISTINCT 
--O.CODE, T.CARD_NUM, T.DATE_TO, T.DATE_OF, nvl(T.NEW_CARD_SERIES, T.CARD_SERIES),
'3802;3801111847;042520607;'||SUBSTR(T.CARD_CHIP,1,8)||';9643103883'||SUBSTR(T.CARD_NUM,2)||';'||LPAD(nvl(T.NEW_CARD_SERIES, T.CARD_SERIES),4,'0')||';15000'
--DISTINCT T.CARD_NUM
 FROM CPTT.T_DATA T
 INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 WHERE
nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (80,82,83,84) 
--and O.CODE !=99
AND   T.KIND in (7,12)
--AND   T.KIND in (3)
--AND T.DATE_TO=TO_DATE('30.07.2017 00:00:00','DD.MM.YYYY HH24:MI:SS')
AND T.CARD_NUM   in (
'0003051233',
'0003053949', 
'0003053995' 
)

--select 'ORGANIZATIONID;INN;BIC;MIFAREUID;TRANSPORTCARDID;TICKETID;AMOUNT' from dual


select T1.card_num, T1.amount, T1.ID, T1.DATE_OF,T1.DATE_TO, T1.INS_DATE, T1.UPD_DATE, T1.CARD_CHIP FROM CPTT.T_DATA T1 where T1.CARD_NUM in (
SELECT 
T.card_num
--, T.amount, O.CODE, O.NAME, T.ID, T.DATE_OF,T.DATE_TO, T.INS_DATE, T.UPD_DATE, T.CARD_CHIP
, count(*) as kol, SUM(T.amount) as s, MIN(T.ID), MAX(T.INS_DATE)
--T.date_to, count(*) as kol, SUM(T.amount) as s, MAX(T.DATE_INS)
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 WHERE 
     
     nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (82)
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014','0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
    -- and O.CODE='0010'
AND   T.KIND  in (7,8,11,12,13)
AND T.DATE_TO=TO_DATE('31.03.2017 00:00:00','DD.MM.YYYY HH24:MI:SS')
GROUP by T.CARD_NUM
HAVING count(*)>1
)  and T1.KIND  in (7,8,11,12,13)
AND T1.DATE_TO=TO_DATE('31.03.2017 00:00:00','DD.MM.YYYY HH24:MI:SS')
ORDER BY  T1.card_num, T1.DATE_OF

--svod
select SER, count(*) from 
(
SELECT DISTINCT SUBSTR(T.CARD_CHIP,1,8),'9643103883'||SUBSTR(T.CARD_NUM,2), LPAD(nvl(T.NEW_CARD_SERIES, T.CARD_SERIES),4,'0') as SER
 FROM CPTT.T_DATA T
 INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 WHERE
nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (82,83) 
-- and O.CODE !=99  --''
AND   T.KIND in (7,12)
AND T.DATE_TO=TO_DATE('31.08.2017 00:00:00','DD.MM.YYYY HH24:MI:SS')
--exclude perevipusk
AND T.CARD_NUM  not in (
'0'
)
--double refillment
and T.ID not in (
0
)
) R
GROUP BY SER
