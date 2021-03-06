--reg_carrier_payments
--ORGANIZATIONID;INN;BIC;MIFAREUID;TRANSPORTCARDID;TICKETID;AMOUNT
select 
R1.CARRIER||';'||R1.INN||';'||R1.BIC||';'||SUBSTR(R1.CHIP,1,8)||';9643103883'||SUBSTR(R1.CARD_NUM,2)||';'||LPAD(R1.CARD_SERIES,4,'0')||';'||TRUNC(R1.TRIP_COUNT/R2.kol_t*150*100)
from
(
select R.CARD_NUM, R.CODE as CARRIER,  MAX(R.INN) as INN, MAX(R.BIC) as BIC
, MAX(R.CARD_CHIP) as CHIP , MAX(R.CARD_SERIES) as CARD_SERIES, SUM(TRIP) as TRIP_COUNT from (
SELECT CARD_NUM,O.CODE,J.INN, B.BIC, T.CARD_CHIP,T.CARD_SERIES, 1 as TRIP
, row_number() over (PARTITION by T.CARD_NUM ORDER BY T.DATE_OF) N
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE R ON T.id_route=R.ID AND T.id_division = R.id_division
    INNER JOIN CPTT.REF_JPERSON J ON O.ID_JPERSON=J.ID
    INNER JOIN CPTT.REF_BANK B ON J.ID_BANK_ACCOUNT=B.ID
 WHERE 
    nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (67) 
     and   O.CODE !='0080' --enee??aai Onieua
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01022017'
AND T.INS_DATE < TO_DATE('03.03.2017 10:04:07','DD.MM.YYYY HH24:MI:SS') --close month
--AND T.ST_LIMIT >169
) R
WHERE R.N<=30
GROUP BY R.CARD_NUM, R.CODE

/*-- old variant
SELECT T.CARD_NUM, MAX(O.CODE) as CARRIER, MAX(J.INN) as INN, MAX(B.BIC) as BIC
, MAX(T.CARD_CHIP) as CHIP , MAX(T.CARD_SERIES) as CARD_SERIES, count (*) as TRIP_COUNT
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE R ON T.id_route=R.ID AND T.id_division = R.id_division
    INNER JOIN CPTT.REF_JPERSON J ON O.ID_JPERSON=J.ID
    INNER JOIN CPTT.REF_BANK B ON J.ID_BANK_ACCOUNT=B.ID
 WHERE 
    nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (67) 
     and   O.CODE !='0080' --��������� ������
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01122016'
AND T.INS_DATE < TO_DATE('09.01.2017 10:06:49','DD.MM.YYYY HH24:MI:SS') --close month
AND T.ST_LIMIT >169
GROUP BY T.CARD_NUM, O.CODE
*/
) R1 
    INNER JOIN 
(--all trips by tickets
select R3.CARD_NUM, SUM(TRIP) as kol_t from (
SELECT CARD_NUM, 1 as TRIP
, row_number() over (PARTITION by T.CARD_NUM ORDER BY T.DATE_OF) N
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
      
WHERE 
    nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (67) 
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01022017'
AND T.INS_DATE < TO_DATE('03.03.2017 10:04:07','DD.MM.YYYY HH24:MI:SS') --close month
--AND T.ST_LIMIT >169
) R3
WHERE R3.N<=30
GROUP BY R3.CARD_NUM
/*
SELECT T.CARD_NUM, count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 WHERE 
     nvl(T.NEW_CARD_SERIES, T.CARD_SERIES)  in (67)
     and   O.CODE !='0080' --��������� ������ 
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
    --                ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0028','0062')  
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01122016'
AND T.INS_DATE < TO_DATE('09.01.2017 10:06:49','DD.MM.YYYY HH24:MI:SS') --close month
AND T.ST_LIMIT >169
GROUP BY T.CARD_NUM
*/
) R2 ON R2.CARD_NUM=R1.CARD_NUM
ORDER BY  R1.CARD_NUM


