CREATE OR REPLACE 
PACKAGE pldoc_bug.testcase_3552725
AS

/**
*<pre>
*PLDOC/PMD Parser need to support the "AT TIME ZONE <time zone expression>" 
*</pre>
*{@link https://support.oracle.com/epmos/faces/ui/km/SearchDocDisplay.jspx?type=DOCUMENT&id=337698.1  Oracle Support TIMECALC: A package to simplify timestamp calculations [ID 337698.1] }
*{@see http://docs.oracle.com/cd/E11882_01/server.112/e17118/expressions007.htm}
*/

/** AT LOCAL clause */
c_at_local_time_zone  CONSTANT TIMESTAMP WITH TIME ZONE :=  FROM_TZ(CAST(TO_DATE('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS') AS TIMESTAMP), 'America/New_York') AT LOCAL ;

/** AT TIME ZONE literal clause */
c_at_time_zone_literal CONSTANT TIMESTAMP WITH TIME ZONE :=  FROM_TZ(CAST(TO_DATE('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS') AS TIMESTAMP), 'America/New_York') AT TIME ZONE 'America/Los_Angeles' ;

/** AT TIME ZONE DBTIMEZONE clause */
c_at_time_zone_dbtimezone CONSTANT TIMESTAMP WITH TIME ZONE :=  FROM_TZ(CAST(TO_DATE('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS') AS TIMESTAMP), 'America/New_York') AT TIME ZONE DBTIMEZONE ;

/** AT TIME ZONE SESSIONTIMEZONE clause */
c_at_time_zone_sessiontimezone CONSTANT TIMESTAMP WITH TIME ZONE :=  FROM_TZ(CAST(TO_DATE('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS') AS TIMESTAMP), 'America/New_York') AT TIME ZONE SESSIONTIMEZONE ;

/** AT TIME ZONE expression clause */
c_at_time_zone_expression CONSTANT TIMESTAMP WITH TIME ZONE :=  FROM_TZ(CAST(TO_DATE('1999-12-01 11:00:00', 'YYYY-MM-DD HH:MI:SS') AS TIMESTAMP), 'America/New_York') AT TIME ZONE TO_CHAR(c_at_time_zone_literal,'TZR'); 

END;
/



