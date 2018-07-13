CREATE OR REPLACE PACKAGE BODY 
/**
* Exercise PACKAGE BODY comment.
*@headcom
**/
TESTUSER.FAKE_TYPE_BODY 
AS 
/**
* Exercise PACKAGE BODY method comment.
*
* @parameter p_parameter parameter in method comment within package body
*
*/
    PROCEDURE dummy (p_parameter varchar2) IS
    BEGIN
    	NULL;
    END;
END; 
/

