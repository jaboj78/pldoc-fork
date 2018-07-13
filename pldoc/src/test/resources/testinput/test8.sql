create or replace
package timestamp_test is

TYPE VARYING_ARRAY IS VARYING ARRAY(10) OF INTEGER;
TYPE REF_CURSOR IS REF CURSOR;

procedure some_procedure(
  time_var timestamp with time zone,
  long_raw_var long raw,
  varying_array_var VARYING_ARRAY,
  double_prec_var DOUBLE PRECISION,
  int_day_2_second_var INTERVAL DAY TO SECOND,
  int_y_2_m_var INTERVAL YEAR TO MONTH,
  time_local_var TIMESTAMP WITH LOCAL TIME ZONE,
  ref_cursor_var REF_CURSOR
);

end;
/
