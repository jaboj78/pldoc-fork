CREATE OR REPLACE PACKAGE pkg_datatype AS 
  v_char char(30);
  v_nchar nchar(30);
  v_varchar2 VARCHAR2(30);
  v_nvarchar2 nVARCHAR2(30);
  v_char_syntax VARCHAR2(30 char);
  v_byte_syntax VARCHAR2(30 byte);
  v_long long;
  v_long_raw long raw;
  v_date DATE;
  v_number NUMBER(10,2);
  v_numeric NUMeric(10,2);
  v_dec dec(10,2);
  v_decimal decimal(10,2);
  v_float FLOAT(2);
  v_integer INTEGER(2);
  v_int INT(2);
  v_smallint smallINT;
  v_real REAL;
  v_double_precision double precision ;
  v_timestamp TIMESTAMP(9);
  v_timestamptz TIMESTAMP(9) WITH TIME ZONE;
  v_timestampltz TIMESTAMP(9) WITH LOCAL TIME ZONE;
  v_duration_ds INTERVAL DAY(9) TO SECOND;
  v_duration_ym INTERVAL YEAR(3) TO MONTH;
  v_duration_twp INTERVAL DAY(3) TO SECOND (4);
  v_bfile bfile ;
  v_blob blob ;
  v_clob clob ;
  v_nclob nclob ;
  v_rowid rowid ;
  v_urowid urowid(20);
END pkg_datatype;
/

