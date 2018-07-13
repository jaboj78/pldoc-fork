

CREATE OR REPLACE PACKAGE pkg_datatype_defaults AS 
  v_char char(30);
  v_nchar nchar(30);
  v_varchar2 VARCHAR2(30);
  v_nvarchar2 nVARCHAR2(30);
  v_char_syntax VARCHAR2(30 char);
  v_byte_syntax VARCHAR2(30 byte);
  v_long long;
  v_long_raw long raw;
  v_date DATE;
  v_number NUMBER;
  v_numeric NUMeric;
  v_dec dec;
  v_decimal decimal;
  v_float FLOAT;
  v_integer INTEGER;
  v_int INT;
  v_smallint smallINT;
  v_real REAL;
  v_double_precision double precision ;
  v_timestamp_default TIMESTAMP;
  v_timestamptz_default TIMESTAMP WITH TIME ZONE;
  v_timestampltz_default TIMESTAMP WITH LOCAL TIME ZONE;
  v_duration_ds_default INTERVAL DAY TO SECOND;
  v_duration_ym_default INTERVAL YEAR TO month ;
  v_bfile bfile ;
  v_blob blob ;
  v_clob clob ;
  v_nclob nclob ;
  v_rowid rowid ;
  v_urowid urowid ;
END;
/



