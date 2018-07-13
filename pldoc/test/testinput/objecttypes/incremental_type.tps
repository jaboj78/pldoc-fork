

CREATE OR REPLACE TYPE ty_datatype_incremental AS OBJECT
(
  v_char char(30)
  ,v_nchar nchar(30)
 , MEMBER PROCEDURE initial_method ( a_parameter VARCHAR2, another_parameter VARCHAR2 )
)
ALTER TYPE ty_datatype_incremental ADD ATTRIBUTE ( an_attribute VARCHAR2(3) )
ALTER TYPE ty_datatype_incremental ADD MEMBER PROCEDURE a_method ( a_parameter VARCHAR2 )
ALTER TYPE ty_datatype_incremental ADD ATTRIBUTE ( an_attribute VARCHAR2(3), another_attribute VARCHAR2(3) )
ALTER TYPE ty_datatype_incremental ADD MEMBER PROCEDURE a_method ( a_parameter VARCHAR2, another_parameter VARCHAR2 )
ALTER TYPE ty_datatype_incremental MODIFY ATTRIBUTE ( an_attribute VARCHAR2(5), another_attribute VARCHAR2(5) )
ALTER TYPE ty_datatype_incremental DROP  ATTRIBUTE ( a_dropped_attribute , another_dropped_attribute  )
--
ALTER TYPE ty_datatype_incremental ADD ATTRIBUTE a_naked_attribute VARCHAR2(3) 
ALTER TYPE ty_datatype_incremental REPLACE AUTHID CURRENT_USER
/**
 This version of the type replaces all preceding versions
@headcom
**/ AS OBJECT 
(
replacement_attribute TIMESTAMP
,STATIC PROCEDURE a_method ( a_parameter VARCHAR2 )
,STATIC FUNCTION  a_singleton ( a_parameter VARCHAR2 ) RETURN ty_datatype_incremental
)
;
/
