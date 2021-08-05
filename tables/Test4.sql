create table PRODUCTO_PADRE
(
  DES_PRO_PADRE   VARCHAR2(30) not null,
  COD_PRO_PADRE   VARCHAR2(2) not null,
  ID_TIPO_CARTERA NUMBER(3)
);
comment on column PRODUCTO_PADRE.ID_TIPO_CARTERA
  is 'Tipo Cartera';
alter table PRODUCTO_PADRE
  add constraint PRODUCTO_PADRE_PK primary key (COD_PRO_PADRE);
grant select on PRODUCTO_PADRE to R_SISCORP;
grant select on PRODUCTO_PADRE to SISCORP;