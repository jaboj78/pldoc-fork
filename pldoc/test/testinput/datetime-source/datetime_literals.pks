

CREATE OR REPLACE PACKAGE pkg_datetime_literals AS 
  -- DATE 
  v_date_ansi DATE := DATE '2009-06-01'; -- ANSI Date Literal
  v_date DATE := TO_DATE('20090601235959','YYYYMMDDHH24MISS');
  --TIMESTAMP with default precision literal
  v_timestamp_default TIMESTAMP:= TIMESTAMP'20090601235959.123456';
  --TIMESTAMP with maximum precision literal
  v_timestamp_max TIMESTAMP(9):= TIMESTAMP'20090601235959.123456789';
  --TIMESTAMP WITH TIME ZONE literal with locale
  v_timestamptz_default_loc TIMESTAMP WITH TIME ZONE := TIMESTAMP'1997-01-31 09:26:50.124 America/New_York' ;
  --TIMESTAMP WITH TIME ZONE literal with offset
  v_timestamptz_default_off TIMESTAMP WITH TIME ZONE := TIMESTAMP'1997-01-31 09:26:50.124 -8:00' ;
  v_timestampltz_default_loc TIMESTAMP WITH LOCAL TIME ZONE := TIMESTAMP'1997-01-31 09:26:50.124 America/New_York' ;
  --TIMESTAMP WITH LOCAL TIME ZONE literal with offset
  v_timestampltz_default_off TIMESTAMP WITH LOCAL TIME ZONE := TIMESTAMP'1997-01-31 09:26:50.124 -8:00' ;
  /*
    INTERVAL Syntax 

    INTERVAL'y-m' YEAR[(precision1)] TO MONTH
    INTERVAL'y' YEAR(precision1)
    INTERVAL'm' MONTH(precision1)

    INTERVAL'd[h[:m[:s]]]' unit1[(precision1)] TO unit2[(precision2)]
      unit1,unit2 = {DAY,HOUR,MINUTE,SECOND}
      constraint unit1 always longer than unit2, i.e. DAY is longer than MINUTE
      so can have DAY to MINUTE, but not MINUTE to DAY
  */
  v_duration_ym_default INTERVAL YEAR TO month := INTERVAL '0-1' YEAR TO MONTH;
  v_duration_ym_y INTERVAL YEAR TO month := INTERVAL '1' YEAR ;
  v_duration_ym_yyymm INTERVAL YEAR TO month := INTERVAL '123-1' YEAR(3) TO MONTH;
  v_duration_ym_yyy INTERVAL YEAR TO month := INTERVAL '123' YEAR(3) ;
  v_duration_ym_mmm INTERVAL YEAR TO month := INTERVAL '360' MONTH ;

  v_duration_ds_default INTERVAL DAY TO SECOND := INTERVAL '3 12:30:06.123456' DAY TO SECOND;
  v_duration_ds_dds INTERVAL DAY TO SECOND := INTERVAL '3 12:30:06.7' DAY TO SECOND(1);
  v_duration_ds_ddm INTERVAL DAY TO SECOND := INTERVAL '99 23:59' DAY TO MINUTE;
  v_duration_ds_ddh INTERVAL DAY TO SECOND := INTERVAL '99 23' DAY TO HOUR;
  v_duration_ds_dd INTERVAL DAY TO SECOND := INTERVAL '30' DAY;
  v_duration_ds_dddd INTERVAL DAY TO SECOND := INTERVAL '9999' DAY(4);
  v_duration_ds_max INTERVAL DAY(9) TO SECOND(9) := INTERVAL'999999999 25:59:59.123456789';
  v_duration_ds_hhmm INTERVAL DAY TO SECOND := INTERVAL '12:30:06.123456' HOUR TO MINUTE;
  v_duration_ds_hhss INTERVAL DAY TO SECOND := INTERVAL '12:30:06.123456' HOUR TO SECOND;
  v_duration_ds_hh INTERVAL DAY TO SECOND := INTERVAL '12' HOUR;
  v_duration_ds_mmss INTERVAL DAY TO SECOND := INTERVAL '30:06.123456' MINUTE TO SECOND;
  v_duration_ds_mm INTERVAL DAY TO SECOND := INTERVAL '30' MINUTE;
END;
/



