CREATE OR REPLACE Function CA_DESCRIBE_AGENTE_FLEX (CODIGO_AGENTE_FLEX IN VARCHAR,NOMBRE_AGENTE OUT cp_usuarios.nom_usuario%type)
RETURN  VARCHAR2
-- OBJETIVO:   DADO EL CODIGO FLEX DEL AGENTE HALLAR CEDULA EN WF
-- MODIFICATION HISTORY
-- Person      Date         Comments
-- ---------   ---------   -------------------------------------------
--  MARIO J.   2002-07-09   CREACION Y PRUEBAS
-- ---------   ---------   -------------------------------------------
IS
NIT_AGENTE cp_usuarios.nit_usuario%type;
NRO NUMBER(6);

BEGIN

IF CODIGO_AGENTE_FLEX IS NULL THEN
   NIT_AGENTE:='934177';
   NOMBRE_AGENTE:='CALL CENTER MIGRACION';
ELSE
   SELECT COUNT(*) INTO NRO FROM CP_USUARIOS
        WHERE COD_USUARIO = CODIGO_AGENTE_FLEX AND ZONA = 'A';
   if nro = 1 then
      SELECT NIT_USUARIO INTO NIT_AGENTE FROM CP_USUARIOS
         WHERE COD_USUARIO = CODIGO_AGENTE_FLEX AND ZONA = 'A';
      SELECT COUNT(*) INTO NRO FROM CP_USUARIOS WHERE NIT_USUARIO = NIT_AGENTE;
      IF NRO = 0 THEN
--       CREAR EL USUARIO
         NOMBRE_AGENTE:='VACANTE ADM '||CODIGO_AGENTE_FLEX;
         CARGA_USUARIOS_CALL_2(
                NIT_AGENTE,--NITUSU
                NOMBRE_AGENTE,--SHORTNAME
                'VACANTE',--NOMBRE1
                NULL,--NOMBRE2
                'CBR ADM.',--APELLIDO1
                NULL,--APELLIDO2
                CODIGO_AGENTE_FLEX,--PASSWORDU
                CODIGO_AGENTE_FLEX --CODIGO
                );
      ELSE
          SELECT MAX(NOM_USUARIO) INTO NOMBRE_AGENTE FROM CP_USUARIOS WHERE NIT_USUARIO = NIT_AGENTE;
      END IF;
    ELSE
       NIT_AGENTE:=CODIGO_AGENTE_FLEX||CODIGO_AGENTE_FLEX;
       NOMBRE_AGENTE:='VACANTE ADM '||CODIGO_AGENTE_FLEX;
       CARGA_USUARIOS_CALL_2(
                NIT_AGENTE,--NITUSU
                NOMBRE_AGENTE,--SHORTNAME
                'VACANTE',--NOMBRE1
                NULL,--NOMBRE2
                'CALL CENTER',--APELLIDO1
                NULL,--APELLIDO2
                CODIGO_AGENTE_FLEX,--PASSWORDU
                CODIGO_AGENTE_FLEX --CODIGO
                );
    END IF;
END IF;

RETURN NIT_AGENTE ;
END; -- Function CA_DESCRIBE_AGENTE_FLEX
/