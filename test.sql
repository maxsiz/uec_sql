set long 32767 pagesize 0 linesize 800 feedback off echo off verify off trims on
select 'ыва' from dual;
spool &1;
select '&2', SYSDATE from dual;
spool off;
exit;