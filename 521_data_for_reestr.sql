SELECT '964310380'||T.CARD_NUM as NUM, O.CODE, count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 WHERE 
     T.CARD_SERIES  in (60) --фильтр по сериям
     --в строке коды перевозчиков, можно дополнить или убрать лишние
     and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014','0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0062')  
AND   T.KIND=17 --регистрация поездки по SU
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01012016'
GROUP BY '964310380'||T.CARD_NUM , O.CODE
ORDER BY  '964310380'||T.CARD_NUM , O.CODE


