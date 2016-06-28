Select R2.*
     ,R3.tickets_83, R3.tickets_83_prigorod, R3.tickets_83_gorod
     ,R4.kol_all_trip, R4.kol_prigorod_trip, R4.kol_gorod_trip  FROM (
SELECT MAX(R1.ID) as ID, R1.NAME, SUM(kol_p_3033) as kol_p_3033, SUM(kol_p_69) as kol_p_69
      , SUM(kol_p_83) as kol_p_83, SUM(kol_p_83_prigorod) as kol_p_83_prigorod
      , SUM(kol_p_83_gorod) as kol_p_83_gorod
FROM (
SELECT 
O.ID, O.NAME,
--, T.card_series,
CASE
  WHEN T.card_series in (30,33) THEN 1
  ELSE 0
END as kol_p_3033,
/*
CASE
  WHEN T.card_series = 33 THEN 1
  ELSE 0
END as kol_p_33,
*/
CASE
  WHEN T.card_series = 69 THEN 1
  ELSE 0
END as kol_p_69,
CASE
  WHEN T.card_series = 83 THEN 1
  ELSE 0
END as kol_p_83,
CASE
  WHEN T.card_series = 83  and decode(RI.ID_CODE_MSG,200001000,1,0) = 1 THEN 1
  ELSE 0
END as kol_p_83_prigorod,
CASE
  WHEN T.card_series = 83  and decode(RI.ID_CODE_MSG,200001000,1,0)= 0 THEN 1
  ELSE 0
END as kol_p_83_gorod
 
FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE RI ON T.id_route=RI.ID AND T.id_division = RI.id_division
 WHERE 
     TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01052016'--!!!!CHANGE DATE
     AND T.INS_DATE < TO_DATE('01.06.2016 21:28:44','DD.MM.YYYY HH24:MI:SS')
     and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014','0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0028')  
     AND T.CARD_SERIES  in (30,33,69,83) 
     AND  (T.KIND=16 OR T.KIND=17 OR T.KIND=18 OR T.KIND=19 OR T.KIND=34) 
     ) R1
     GROUP BY R1.NAME
) R2 LEFT JOIN (     
SELECT R.ID, SUM(all_t) as tickets_83, SUM(prigorod) as tickets_83_prigorod, SUM(gorod) as tickets_83_gorod
 FROM (
 SELECT O.ID, T.CARD_NUM,  
MAX(decode(RI.ID_CODE_MSG,200001000,1,0)) as prigorod, 
MAX(decode(RI.ID_CODE_MSG,200001000,0,1)) as gorod, 
1 as all_t --count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE RI ON T.id_route=RI.ID AND T.id_division = RI.id_division
 WHERE 
     T.CARD_SERIES  in (83) 
    -- and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
    --                ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01052016'--!!!!CHANGE DATE
AND T.INS_DATE < TO_DATE('01.06.2016 21:28:44','DD.MM.YYYY HH24:MI:SS')
GROUP BY O.ID, T.CARD_NUM
) R
GROUP BY R.ID
) R3 ON R3.ID=R2.ID
INNER JOIN (
SELECT SUM(prigorod_trip) as kol_prigorod_trip, SUM(gorod_trip) as kol_gorod_trip, SUM(all_trip) as kol_all_trip 
from (
SELECT   
CASE 
 WHEN decode(RI.ID_CODE_MSG,200001000,1,0)= 1 THEN 1
 ELSE 0
END as prigorod_trip,
CASE 
 WHEN decode(RI.ID_CODE_MSG,200001000,1,0)= 0 THEN 1
 ELSE 0
END as gorod_trip,
1 as all_trip
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
     INNER JOIN CPTT.ROUTE RI ON T.id_route=RI.ID AND T.id_division = RI.id_division
 WHERE 
     T.CARD_SERIES  in (83) 
    -- and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
      --              ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01052016'--!!!!CHANGE DATE
AND T.INS_DATE < TO_DATE('01.06.2016 21:28:44','DD.MM.YYYY HH24:MI:SS')
)
) R4  ON 1=1
