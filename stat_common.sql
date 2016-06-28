--active tickets, trips, avg, max
SELECT count(*) as tickets, SUM(kol_t) as TRIPS, TRUNC(AVG(kol_t), 2) as AVERAGE , MAX(kol_t) as PIK FROM (
SELECT T.CARD_NUM, count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 WHERE 
     T.CARD_SERIES  in (83) 
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
     --               ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
AND   T.KIND=17 
--AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01052016'
 AND T.DATE_OF > TO_DATE('01.05.2016 00:00:00','DD.MM.YYYY HH24:MI:SS')
GROUP BY T.CARD_NUM 
)

--maked cards
select count(*) 
from CPTT.CARD C 
WHERE C.SERIES = 83

--����� �������� ���� � �������
SELECT count(*) FROM (
SELECT T.CARD_NUM
 FROM CPTT.T_DATA T
 WHERE  T.CARD_SERIES  in (83) 
  AND T.DATE_OF > TO_DATE('01.01.2016 00:00:00','DD.MM.YYYY HH24:MI:SS')
GROUP BY T.CARD_NUM 
)
--������� �� ������
SELECT T.CARD_NUM, count(*) as kol
 FROM CPTT.T_DATA T
 WHERE  T.CARD_SERIES  in (83) 
   AND T.DATE_OF > TO_DATE('01.05.2016 00:00:00','DD.MM.YYYY HH24:MI:SS')
GROUP BY T.CARD_NUM 
