create or replace TYPE "ty_root"
AS OBJECT ("SYS_XDBPD$" "XDB"."XDB$RAW_LIST_T","nbr" VARCHAR2(4000 CHAR),"fName" VARCHAR2(4000 CHAR),"sName" VARCHAR2(4000 CHAR),"gender" VARCHAR2(4000 CHAR),"expGrade" VARCHAR2(4000 CHAR),"total" NUMBER(38),"whnCmplt" TIMESTAMP,"unexp" RAW(1),"absnt" RAW(1),"rvsd" RAW(1),"rtrt" RAW(1),"ab" RAW(1),"ap" RAW(1),"bdm" RAW(1),"q" "q2170_COLL") NOT FINAL INSTANTIABLE; 


CREATE OR REPLACE TYPE tp_leaf1 UNDER ty_root 
(
additional_field NUMBER(9)
)
;


