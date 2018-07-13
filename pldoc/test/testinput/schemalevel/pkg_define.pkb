CREATE OR REPLACE 
PACKAGE BODY pkg_define
AS
	PROCEDURE define
	IS
	BEGIN
		define( 'I am defined' )  ;
		undefine( 'I am undefined' )  ;
		define;
	END define;
END;
/

