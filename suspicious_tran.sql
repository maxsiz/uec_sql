SELECT Card_Num, Card_Series, Card_Num_Count, Shift_Date, Shift_End, TT.CODE as Term_Code, Card_Num_Sec, O.NAME, O.CODE   FROM
/*Отображаем номер карты, количество предъявлений,  дата открытия смены, номер терминала. TO_DATE(t1.Shift_Date, 'DD.MM.YYYY') as*/
(
 select t. card_num as Card_Num,
        COUNT(t.card_num) as Card_Num_Count,
        t.shift_begin AS Shift_Date,
        t.card_num_sec AS Card_Num_Sec,
        t.shift_end AS Shift_End,
        t.ID_TERM,
        t.card_series as Card_Series
 from CPTT.t_data t
 where t.card_num is not null
 and t.card_series not in (01,02,03,06)
 GROUP BY t.card_num, t.shift_begin, t.shift_end, t.ID_TERM,/* term.code,*/ t.card_series, t.card_num_sec
 --ORDER BY t.card_num
)t1
 INNER JOIN CPTT.TERM TT ON T1.ID_TERM=TT.ID
 INNER JOIN CPTT.DIVISION D ON TT.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
/*В запросе требуется задать значения: Дата на терминале, Количество предъявлений, Серия карты*/
-- фильтр по дате, времени, точно указываем между чем и чем
WHERE t1.Shift_Date BETWEEN TO_DATE('01.09.2015 00:00:00','DD.MM.YYYY HH24:MI:SS')
                        AND TO_DATE('30.09.2015 23:59:59','DD.MM.YYYY HH24:MI:SS')
-- фильр по кол-ву предъявлений (либо <, > какого -то значения, либо включая конкретные значения)
--AND t1.Card_Num_Count in (1,2,3,4)  -- либо
AND t1.Card_Num_Count > 5           -- либо
-- фильтр по сериям карт (перечисление через "," номеров серий)
AND t1.Card_Series in (82)
ORDER BY t1.card_num
