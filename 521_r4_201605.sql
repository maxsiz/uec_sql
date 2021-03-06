--r4
SELECT SUBSTR(T.CARD_NUM,2) as NUM, O.CODE as CARRIER, count (*) as TRIP_COUNT
,T.AMOUNT AS TARIF
, decode(R.ID_CODE_MSG,200001000,1,0) as VID
--, T.*
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
    INNER JOIN CPTT.ROUTE R ON T.id_route=R.ID AND T.id_division = R.id_division
 WHERE 
     T.CARD_SERIES  in (83) 
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014','0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0028','0062')  
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01052016'
/*
--exclude old card, remaked. �� ��� - �� ����� ��������� �� r4
AND T.CARD_NUM not in (
'0003003594',
'0003002252',
'0003002946',
'0003000146',
'0003008630',
'0003011755',
'0003009481',
'0003023999',
'0003002451',
'0003004199',
'0003013546',
'0003008929',
'0003001905',
'0003006190',
'0003014169',
'0003012919',
'0003001806',
'0003024228',
'0003012495',
'0003008530',
'0003000755',
'0003014983',
'0003016539'
)
*/
GROUP BY SUBSTR(T.CARD_NUM,2), O.CODE, T.AMOUNT, decode(R.ID_CODE_MSG,200001000,1,0) 
ORDER BY decode(R.ID_CODE_MSG,200001000,1,0),O.CODE, T.AMOUNT, SUBSTR(T.CARD_NUM,2) 

--data for reestr 521
SELECT SUBSTR(T.CARD_NUM,2), O.CODE, MAX(O.NAME) as CARRIER_NAME, count (*) as kol_t
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 WHERE 
     T.CARD_SERIES  in (83) --������ �� ������
     --� ������ ���� ������������, ����� ��������� ��� ������ ������
     and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
                    ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0028','0062')  
AND   T.KIND=17 --����������� ������� �� SU
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01032016'
/*
AND T.CARD_NUM  in (
0003000327,
0003000483,
0003001674,
0003004063,
0003007320,
0003007535,
0003009213,
0003014819,
0003014989,
0003016327,
0003016352,
0003017845,
0003022570,
0003023244,
0003007432,
0003008398,
0003015478,
0003017441
)
*/
GROUP BY T.CARD_NUM, O.CODE 
ORDER BY T.CARD_NUM 

--kontrol data
SELECT count(*) as tickets, SUM(kol_t) as TRIPS, MIN(minins), MAX(maxins) FROM (
SELECT T.CARD_NUM, count (*) as kol_t, MIN(T.INS_DATE) as minins, MAX(T.INS_DATE) as maxins
 FROM CPTT.T_DATA T
    INNER JOIN CPTT.DIVISION D ON T.ID_DIVISION=D.ID
    INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 WHERE 
     T.CARD_SERIES  in (83) 
     --and O.CODE in ('0002','0003','0004','0005','0006','0007','0008','0009','0011','0012','0013','0014'
    --                ,'0015','0016','0017','0018','0019','0020','0021','0022','0023','0024','0025','0026','0027','0028','0062'
--                    ,'0080'--Usolie
         --           )  
AND   T.KIND=17 
AND TO_CHAR(TRUNC(T.DATE_OF,'MM'), 'DDMMYYYY') = '01062016'
--AND T.INS_DATE < TO_DATE('01.06.2016 21:28:44','DD.MM.YYYY HH24:MI:SS')
GROUP BY T.CARD_NUM 
)
--18427 -689355 (20160302 23:13)
--18427 -689355 (20160303 08:33)
--18427 -689355 (20160309 12:27)

--march
--19962  -807001 (20160401 15:33)
--19962  -807780 (20160404 12:16)

--april 2016
--20157 840548 (20160502 16:37)
--20157 840548 (20160504 11:24)
--20157 840548 (20160518 14:12)
--20157   840548  01.04.2016 8:14:31  01.05.2016 21:06:18 (20160601 15:55)

--may 2016
--19533   747827 (20160601 15:34)
--19533   747827  01.05.2016 4:34:22  01.06.2016 6:22:58 (20160601 15:55)
--19533   748908  01.05.2016 4:34:22  01.06.2016 21:28:43(20160602 09:25)
--19533   748908  01.05.2016 4:34:22  01.06.2016 21:28:43 (20160602 17:05)
--19533   749251  1-���-2016 4:34:22  2-���-2016 21:05:37 (20160607 10:41)!!!!!!

--june 2016
--19057   609594  01.06.2016 7:57:26  27.06.2016 10:28:47 (20160627 12:00)
