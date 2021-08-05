--------------------------------------------------------
--  DDL for Function BZ_CALCULA_ACTIVIDAD
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "WF"."BZ_CALCULA_ACTIVIDAD" 
  ( Caso IN varchar2, 
    etapa IN varchar2,
    mindate IN varchar2
     )
  RETURN  varchar2 IS

v_actividad varchar2(100);
BEGIN 

SELECT  c.activity_name
into    v_actividad
from    wf_item_activity_statuses a,
        wf_process_activities c
where   a.item_key = Caso
    and to_char(a.begin_date,'YYYY/MM/DD') = mindate
    and a.process_activity = c.instance_id
    and get_etapa(c.activity_name)= etapa
    and rownum = 1;
    
return v_actividad;

END; -- Function BZ_CALCULA_ACTIVIDAD

/