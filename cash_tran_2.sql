SELECT Card_Num_sec as "Карта оператора", Cash_Count as "Кол-во транзакций"
,TO_CHAR(TRUNC(T1.shift_begin,'DD'), 'YYYYMMDD')  as "Дата смены" --дата смены
--, shift_begin --начало смены
--, Shift_End --конец смены
--, TT.CODE as Term_Code --серийный номер терминала
, O.NAME, O.CODE  --предприятие, код предприяти
 FROM
(
 select t.card_num_sec , COUNT(*) as Cash_Count,
        t.shift_begin , t.shift_end ,
        t.ID_TERM
 from CPTT.t_data t
 where  t.KIND=14 
 --период выборки: 
 and t.Shift_Begin BETWEEN TO_DATE('01.09.2015 00:00:00','DD.MM.YYYY HH24:MI:SS')
                        AND TO_DATE('07.10.2015 06:59:59','DD.MM.YYYY HH24:MI:SS')
 --and t.card_num_sec in ('0000016784', '0000017306') --фильтр по карте оператора    

 GROUP BY t.card_num_sec, t.shift_begin, t.shift_end, t.ID_TERM
 HAVING count(*) > 20  --число транзакций в день(порог   срабатывания  отчёта)
)t1
 INNER JOIN CPTT.TERM TT ON T1.ID_TERM=TT.ID
 INNER JOIN CPTT.DIVISION D ON TT.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1

WHERE  O.CODE in ('0031') --код  предприятия (можно нескольоко,  через  запятую)
ORDER BY t1.card_num_sec
