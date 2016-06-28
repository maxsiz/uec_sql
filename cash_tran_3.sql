SELECT T1.Card_Num_sec as "����� ���������", Cash_Count as "���-�� ����������"
,TO_CHAR(TRUNC(T1.shift_begin,'DD'), 'YYYYMMDD')  as "���� �����" --���� �����
, TO_CHAR(TRUNC(T2.date_of,'MI'), 'HH24:MI') as , TO_CHAR(TRUNC(T2.date_of,'HH'), 'HH24')
--, shift_begin --������ �����
--, Shift_End --����� �����
--, TT.CODE as Term_Code --�������� ����� ���������
--, O.NAME, O.CODE  --�����������, ��� ����������
 FROM
(
 select t.card_num_sec , COUNT(*) as Cash_Count,
        t.shift_begin , t.shift_end ,
        t.ID_TERM
 from CPTT.t_data t
 where  t.KIND=14 
 --������ �������: 
 and t.Shift_Begin BETWEEN TO_DATE('01.09.2015 00:00:00','DD.MM.YYYY HH24:MI:SS')
                        AND TO_DATE('07.10.2015 06:59:59','DD.MM.YYYY HH24:MI:SS')
 --and t.card_num_sec in ('0000016784', '0000017306') --������ �� ����� ���������    

 GROUP BY t.card_num_sec, t.shift_begin, t.shift_end, t.ID_TERM
 HAVING count(*) > 20  --����� ���������� � ����(�����   ������������  ������)
)t1
 INNER JOIN CPTT.TERM TT ON T1.ID_TERM=TT.ID
 INNER JOIN CPTT.DIVISION D ON TT.ID_DIVISION=D.ID
 INNER JOIN CPTT.OPERATOR O ON D.ID_OPERATOR=O.ID  and O.ROLE=1
 INNER JOIN CPTT.t_data T2 ON T1.CARD_NUM_SEC=T2.CARD_NUM_SEC AND T1.shift_begin = T2.shift_begin and T1.ID_TERM=T2.ID_TERM

WHERE  O.CODE in ('0031') --���  ����������� (����� ����������,  �����  �������)
ORDER BY t1.card_num_sec
