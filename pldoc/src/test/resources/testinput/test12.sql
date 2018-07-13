SET DEF OFF
/**
 * Description.: Test package for bug demostration<br />
 * Autor.......: sir_ragnar
 * Fichero.....: $Source: /cvsroot/pldoc/sources/testinput/test12.sql,v $ <br />
 * Id..........: $Id: test12.sql,v 1.1 2006/02/22 18:07:49 altumano Exp $ <br />
 * Version.....: $Revision: 1.1 $ <br />
 * Alta CVS....: $Author: altumano $ <br />
 * Fecha.......: $Date: 2006/02/22 18:07:49 $ <br />
 */
CREATE OR REPLACE PACKAGE Test IS 
  
  -- Hola -----------------------------------------------------------
  /**
   * Funci&oacute;n que recupera un valor de prueba
   *
   * @return Resultado de la prueba
   */
  FUNCTION Hola RETURN VARCHAR2;
  PRAGMA RESTRICT_REFERENCES( Hola, WNDS, WNPS, RNDS, RNPS );
END;
/
Show errors
SET DEF ON
