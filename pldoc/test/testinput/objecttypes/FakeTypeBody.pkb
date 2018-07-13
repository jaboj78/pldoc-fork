CREATE OR REPLACE TYPE BODY TESTUSER.FAKE_TYPE_BODY 
AS 
/**
* Exercise OBJECT TYPE BODY comment.
*@headcom
**/

/**
* Exercise OBJECT TYPE BODY method comment.
*
*@parameter p_parameter parameter in method comment within package body
*
*/
    PROCEDURE dummy (p_parameter varchar2) IS
    BEGIN
    	NULL;
    END;
END; 
/

