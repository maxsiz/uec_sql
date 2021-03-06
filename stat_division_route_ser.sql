SELECT 
D.NAME, R.CODE, R.NAME, T.card_series, T.amount
,T.*
--'964310380'||T.CARD_NUM as NUM, O.CODE, count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE R ON T.id_route=R.ID AND T.id_division = R.id_division
    
 WHERE 
     TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01012016'
     AND O.CODE = '0022'
     AND T.CARD_SERIES  in (60,30,33) 
     
--AND   T.KIND in 17 
--AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01012016'

