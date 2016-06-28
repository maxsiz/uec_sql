set long 32767 pagesize 0 linesize 800 feedback off echo off verify off trims on
spool &1;
--recharged card reg
select SUBSTR(T.CARD_NUM,2)
 FROM CPTT.T_DATA T
 INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=2
 WHERE
T.CARD_SERIES in (83) --seria
 and O.CODE ='0010' --sber
AND   T.KIND in (7,12)
AND T.DATE_TO=TO_DATE('30.06.2016 00:00:00','DD.MM.YYYY HH24:MI:SS');
spool off;
exit;
