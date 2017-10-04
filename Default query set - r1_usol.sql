--***************************************
--r1 дл€ активных ”Ё 
select
UPPER(a.lastname) as LNAME, UPPER(a.firstname) as FNAME, UPPER(a.middlename) as MNAME
, a.birthdate ,a.snils
, ac.card_num
,ac.ins as DATE_INS
, a.state  as PRIM2
from uec_appl a
  INNER JOIN uec_active_tcard ac on ac.social_card=a.panid

where ac.card_num in (
'200405051',
'200402030',
'200300738',
'200404325',
'200404921',
'200404464',
'200103308',
'200300883'

)
--where ac.ins < date '01.04.2016'
--group by ac.card_num
--HAVING COUNT(*)>1

--update aisvtk SET SNILS=REPLACE(REPLACE(snils,'-',''),' ','' )
--select  * from aisvtk
--, count(*)
--,MAX(a.panid)
--,ac.ins
--****************************************************
--люди с двум€ активными картами
--*******************

SELECT a.lastname, a.firstname, a.middlename, a.birthdate, a.snils, a.address, a.panid, ac.card_num
, av.card_num, av.f, av.i,av.o, av.birthdate, av.snils
from uec_appl a
  INNER JOIN uec_active_tcard ac on ac.social_card=a.panid
  LEFT join aisvtk av on av.snils =a.snils
WHERE av.snils is not null

--GROUP BY a.lastname||a.firstname||a.middlename
--, a.birthdate
--, a.snils
--HAVING COUNT(*)>1
---****************************************************
--SELECT * from  uec_active_tcard ac
       --   INNER JOIN uec_block_load b on b.panid=ac.social_card


 -- DELETE from  uec_active_tcard
-- LNAME;FNAME;MNAME;BIRTHDATE;SNILS;NUM;DATE_INS;PRIM2
 select
  --DISTINCT

  --LEFT(REPLACE(ua.scn,' ',''),19)
UPPER(a.lastname) as LNAME, UPPER(a.firstname) as FNAME, UPPER(a.middlename) as MNAME
, a.birthdate ,a.snils, right(ua.sysnumber,9) as NUM, a.UPDATED as DATE_INS, a.state  as PRIM2
--,a.panid, ua.sysnumber
from uec_appl a
      inner join uec_soctrans_arc ua on a.panid = LEFT(REPLACE(ua.scn,' ',''),19)
WHERE a.panid is not null
and ua.sysnumber   in (
'0200401424',
'0200400723'
)

--GROUP BY LEFT(REPLACE(ua.scn,' ',''),19)
--HAVING count(*)>1
order by ua.sysnumber

select * from uec_soctrans_arc a
where  LEFT(REPLACE(a.scn,' ',''),19) in ('9643500250022158004',
'9643500250022152445',
'9643500250022151306',
'9643500250022143113',
'9643500250022133114')
order by a.scn, a.sysnumber
