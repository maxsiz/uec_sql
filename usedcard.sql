set long 32767 pagesize 0 linesize 800 feedback off echo off verify off trims on
spool &1;
--used cards
SELECT SUBSTR(T.CARD_NUM,2)
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 WHERE 
     T.CARD_SERIES  in (83) 
--     and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
--                    ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062'
--                    ,'0080'--Usolie
--                    )  
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01062016'
GROUP BY T.CARD_NUM; 
spool off;
exit;
