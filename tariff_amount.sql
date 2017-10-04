select 
tsz.price, tf.id_route, tf.begin_date, tz.id_zone_begin, tz.id_zone_end
/*
,' tariff_series=ts ->',ts.*
,' tariff=tf->', tf.*
,' tariff_series_zone=tsz -> ', tsz.*
,' tariff_zone=tz ->',tz.* 
*/
from cptt.tariff_series ts
     INNER JOIN cptt.tariff tf on tf.id=ts.ID_TARIFF
     INNER JOIN cptt.tariff_series_zone tsz on ts.ID=tsz.ID_TARIFF_SERIES
    INNER JOIN cptt.tariff_zone tz on tz.ID_TARIFF=tf.id and tz.ID=tsz.ID_TARIFF_ZONE
WHERE ts.SERIES like '%02%'  
and  tf.begin_date > TO_DATE('31.08.2016 23:59:59','DD.MM.YYYY HH24:MI:SS')
