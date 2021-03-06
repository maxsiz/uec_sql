SELECT 
TO_CHAR(TRUNC(T.DATE_OF,'DD'), 'YYYYMMDD') as D,
O.NAME,
R.CODE, MAX(R.NAME) as MNAME, 
  count(*) as kol --, T.*
--'964310380'||T.CARD_NUM as NUM, O.CODE, count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE R ON T.id_route=R.ID AND T.id_division = R.id_division
    
 WHERE  
 --TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01032016'
 T.DATE_OF BETWEEN TO_DATE('01.04.2016 00:00:00','DD.MM.YYYY HH24:MI:SS')
                      AND TO_DATE('01.05.2016 23:59:59','DD.MM.YYYY HH24:MI:SS')    
 AND T.KIND=17
 AND T.CARD_SERIES = 83
 AND O.CODE='0022'
 GROUP BY  TO_CHAR(TRUNC(T.DATE_OF,'DD'), 'YYYYMMDD'),O.NAME,R.CODE
 ORDER BY TO_CHAR(TRUNC(T.DATE_OF,'DD'), 'YYYYMMDD'),O.NAME,R.CODE
     
