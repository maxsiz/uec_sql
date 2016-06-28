set long 32767 pagesize 0 linesize 800 feedback off echo off verify off trims on
spool &1;
--active card reg
SELECT SUBSTR(T.CARD_NUM,2)
 FROM CPTT.T_DATA T
-- WHERE  T.CARD_SERIES  in (83)  AND TRUNC(T.DATE_OF,'MM') = TRUNC(SYSDATE,'MM')
 WHERE  T.CARD_SERIES  in (83)  --AND TRUNC(T.DATE_OF,'MM') = TRUNC(SYSDATE-10,'MM')
GROUP BY T.CARD_NUM ;
spool off;
exit;
