create or replace
package wwv_flow_global
--  Copyright (c) Oracle Corporation 1999 - 2003. All Rights Reserved.
--
--    DESCRIPTION
--      Flow global package variables.
--
--    SECURITY
--      Publicly executable.
--
--    NOTES
--      Allows sharing of data within a session that does not belong to any given package.
--      Includes type declaration(s).
--
--    RUNTIME DEPLOYMENT: YES
--
is
    g_v255_result        varchar2(255) := null;
    g_v1_result          varchar2(1)   := null;
    g_image_prefix       constant varchar2(255) := wwv_flow_image_prefix.g_image_prefix;
    --g_xe                 boolean := case '0' when '1' then true else false end;
    g_xe                 varchar(20);
    aboolean               boolean ;
    --aboolean_with_default  boolean := CASE 1 WHEN 0 THEN TRUE ELSE FALSE END  ;
    aboolean_with_default  boolean := 'case "0" when "1" then true else false end';

    --------
    -- types
    --
    type vc_map  is table of varchar2(32767) index by varchar2(255);
    type vc_arr2 is table of varchar2(32767) index by binary_integer;
    type n_arr   is table of number          index by binary_integer;
    type d_arr   is table of date            index by binary_integer;

end;

