
CREATE OR REPLACE
TYPE BODY         TY_CLASSIFICATION AS
/**
* Exercise PACKAGE BODY comment.
*@headcom
**/

/**
* Is this classification used?.
*
* @return TRUE/FALSE
*
*/
MEMBER FUNCTION get_used RETURN VARCHAR2
IS
BEGIN
	 RETURN used;
END get_used;

/**
* Is this national used?.
*
* @return TRUE/FALSE
*
*/
MEMBER FUNCTION get_national RETURN VARCHAR2
IS
BEGIN
	 RETURN national;
END get_national;


/**
* Return this Classications short description.
*
* @return description
*
*/
MEMBER FUNCTION get_short_descr RETURN VARCHAR2
IS
BEGIN
	 RETURN short_descr;
END get_short_descr;

/**
* Return this Classications full description.
*
* @return description
*
*/
MEMBER FUNCTION get_descr RETURN VARCHAR2
IS
BEGIn
	 RETURN descr;
END get_descr;

END;
/

SHOW ERRORS
