--reg_carrier_payments
--ORGANIZATIONID;INN;BIC;MIFAREUID;TRANSPORTCARDID;TICKETID;AMOUNT
select 
R1.CARRIER||';'||R1.INN||';'||R1.BIC||';'||SUBSTR(R1.CHIP,1,8)||';9643103883'||SUBSTR(R1.CARD_NUM,2)||';'||LPAD(R1.CARD_SERIES,4,'0')||';'||TRUNC(R1.TRIP_COUNT/R2.kol_t*150*100)
from
(
SELECT T.CARD_NUM, MAX(O.CODE) as CARRIER, MAX(J.INN) as INN, MAX(B.BIC) as BIC
, MAX(T.CARD_CHIP) as CHIP , MAX(T.CARD_SERIES) as CARD_SERIES, count (*) as TRIP_COUNT
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE R ON T.id_route=R.ID AND T.id_division = R.id_division
    INNER JOIN CPTT.REF_JPERSON J ON O.ID_JPERSON=J.ID
    INNER JOIN CPTT.REF_BANK B ON J.ID_BANK_ACCOUNT=B.ID
 WHERE 
     T.CARD_SERIES  in (83) 
     and   O.CODE !='0080' --��������� ������
--     9,11,12,13,15,16,18,19,20,22,23,24,25 - �������
    --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014','0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
     --AND O.CODE = '0002'
     --AND O.CODE = '0003'
     --AND O.CODE = '0004'
     --AND O.CODE = '0005'
     --AND O.CODE = '0006'
     --AND O.CODE = '0007'
     --AND O.CODE = '0008'
     --AND O.CODE = '0009'
     --AND O.CODE = '0011'
     --AND O.CODE = '0012'
     --AND O.CODE = '0013'
     --AND O.CODE = '0014'
     --AND O.CODE = '0015'
     --AND O.CODE = '0016'
     --AND O.CODE = '0017'
     --AND O.CODE = '0018'
     --AND O.CODE = '0019'
     --AND O.CODE = '0020'
     --AND O.CODE = '0021'
     --AND O.CODE = '0022'
     --AND O.CODE = '0023'                        
     --AND O.CODE = '0024'
     --AND O.CODE = '0025'
     --AND O.CODE = '0026'               
     --AND O.CODE = '0027'
     --AND O.CODE = '0028'
     --AND O.CODE = '0062'         
AND   T.KIND=17 
--AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01022016'
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01082016'
--AND T.INS_DATE < TO_DATE('02.08.2016  05:45:00','DD.MM.YYYY HH24:MI:SS')
GROUP BY T.CARD_NUM, O.CODE
) R1 
    INNER JOIN 
(--all trips by tickets
SELECT T.CARD_NUM, count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 WHERE 
     T.CARD_SERIES  in (83)
     and   O.CODE !='0080' --��������� ������ 
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
    --                ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0028','0062')  
AND   T.KIND=17 
--AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01022016'
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01082016'
--AND T.INS_DATE < TO_DATE('02.08.2016  05:45:00','DD.MM.YYYY HH24:MI:SS')

GROUP BY T.CARD_NUM
) R2 ON R2.CARD_NUM=R1.CARD_NUM
ORDER BY  R1.CARD_NUM

--select CODE, NAME FROM cptt.OPERATOR O where O.ROLE=1
--kontrol, for reports
SELECT R.CODE, MAX(R.NAME) as NAME, count(*) as tickets--, SUM(kol_t) as TRIPS 
FROM (
SELECT O.CODE, MAX(O.NAME) as NAME,T.CARD_NUM , count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 WHERE 
     T.CARD_SERIES  in (83) 
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
      --              ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
  and   O.CODE !='0080'       
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01082016'
GROUP BY T.CARD_NUM, O.CODE 
) R
GROUP by R.CODE
ORDER by R.CODE