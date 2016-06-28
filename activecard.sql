set long 32767 pagesize 0 linesize 800 feedback off echo off verify off trims on
spool &1;
--active card reg
select 'PERIOD;NUM;FIRST_DATE;LAST_DAT;KOL_T' from dual;
SELECT &2||';'||SUBSTR(T.CARD_NUM,2)||';'||MIN(Date_OF)||';'||MAX(DATE_OF)||';'||count (*) as r
 FROM CPTT.T_DATA T
 WHERE  T.CARD_SERIES  in (83)  AND TRUNC(T.DATE_OF,'MM') = TRUNC(SYSDATE,'MM')
GROUP BY T.CARD_NUM ;
spool off;
exit;
