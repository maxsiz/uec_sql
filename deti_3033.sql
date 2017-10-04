--deti 30 33 svod
SELECT 
 NAME||decode(VID,0,'',', пригород'), R.* from (
 select  O.CODE as CARRIER, MAX(O.NAME) as NAME, decode(R.ID_CODE_MSG,200001000,R.CODE,0) as VID, count (*) as TRIP_COUNT
,SUM(T.AMOUNT) AS SPISANO
--, T.*
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE R ON T.id_route=R.ID AND T.id_division = R.id_division
 WHERE 
     ( nvl(T.NEW_CARD_SERIES, T.CARD_SERIES) = 33 
     or   (nvl(T.NEW_CARD_SERIES, T.CARD_SERIES) =30 and R.ID_CODE_MSG != 200001000))
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014','0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
AND   T.KIND=16 
AND  T.INS_DATE between  TO_DATE('01.05.2017 03:00:00','DD.MM.YYYY HH24:MI:SS') 
                     and TO_DATE('01.06.2017 02:59:59','DD.MM.YYYY HH24:MI:SS') 
GROUP BY O.CODE, decode(R.ID_CODE_MSG,200001000,R.CODE,0) 
) R
ORDER BY R.CARRIER, R.VID 

