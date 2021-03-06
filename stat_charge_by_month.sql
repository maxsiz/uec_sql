SELECT  TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'YYYYMMDD') as MONTH_YEAR, SUM(T.amount) as s
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
   INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 WHERE 
 T.DATE_OF>=TO_DATE('01.10.2015 00:00:00','DD.MM.YYYY HH24:MI:SS')  
   and O.CODE = '0010'
   AND   T.KIND  in (7,10,11,12,13)
GROUP by TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'YYYYMMDD')
ORDER by TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'YYYYMMDD')
