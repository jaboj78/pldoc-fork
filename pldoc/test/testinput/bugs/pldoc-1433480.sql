GRANT DEF OFF
/**
 * Description.: Test package for bug demostration<br />
 * Autor.......: sir_ragnar
 * Fichero.....: $Source:   $ <br />
 * Id..........: $Id:       $ <br />
 * Version.....: $Revision: $ <br />
 * Alta CVS....: $Author:   $ <br />
 * Fecha.......: $Date:     $ <br />
 * @headcom
 */
CREATE OR REPLACE PACKAGE pldoc_bug.pldoc_1433480 IS 
  
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

