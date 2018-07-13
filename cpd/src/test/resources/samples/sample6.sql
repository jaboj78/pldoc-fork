

CREATE OR REPLACE 
PACKAGE samples.deprecated IS
  /**
  * ========================================================================<br/>
  * Project:         Test Project (<a href="http://pldoc.sourceforge.net">PLDoc</a>)<br/>
  * Description:     Documenting specification and body, listing deprecated items.<br/>
  * DB impact:       YES<br/>
  * Commit inside:   NO<br/>
  * Rollback inside: NO<br/>
  * ------------------------------------------------------------------------<br/>
  * ========================================================================<br/>
  * @deprecated Use something <b>new</b> instead.
  * @headcom
  */

  /** Constant, which will be shown with value in html.*/
  vcConstant CONSTANT VARCHAR2(10) := 'VALUE';

  /**
  * Test (in Specification) procedure to show, that parameters named in mixed case, are
  * shown in lower case in the output.
  * @param i_vcMixedCase This mixed case parameter has an inline @deprecated deprecated tag.
  * @deprecated Demonstrating that single sentence deprecated method comments are processed correctly. 
  */
  PROCEDURE pr_mixed_case(i_vcMixedCase IN VARCHAR2);

  /**
  * Test (in Specification) procedure to show, that for parameters which have a default, the
  * default is shown in the output.
  * @param i_vcMixedCase The mixed case parameter.
  * @return success code - please ignore @deprecated.
  * @deprecated Demonstrating that multi-sentence deprecated method comments are processed correctly. 
  */
  FUNCTION pr_default_parameter(i_vcDefault IN VARCHAR2 DEFAULT 'STANDARD') RETURN INTEGER;
END;
/

CREATE OR REPLACE 
PACKAGE BODY samples.deprecated IS

  /**
  * Test (in BODY) procedure to show, that for parameters which have a default, the
  * default is shown in the output.
  * @param i_vcMixedCase This mixed case parameter has an inline @deprecated deprecated tag.
  * @deprecated 
  */
  PROCEDURE pr_mixed_case(i_vcMixedCase IN VARCHAR2) IS
  BEGIN
    NULL;
  END;


  /**
  * Test (in BODY) procedure to show, that for parameters which have a default, the
  * default is shown in the output.
  * @param i_vcMixedCase The mixed case parameter.
  * @deprecated 
  */
  PROCEDURE pr_default_parameter(i_vcDefault IN VARCHAR2 DEFAULT 'STANDARD') IS
  BEGIN
    NULL;
  END;

  /**
  * Test (in BODY) private procedure to show, that for parameters which have a default, the
  * default is shown in the output.
  * @param i_vcMixedCase The mixed case parameter.
  * @return success code - please ignore @deprecated.
  * @deprecated 
  */
  FUNCTION pr_private_procedure(i_vcDefault IN VARCHAR2 DEFAULT 'STANDARD') RETURN INTEGER IS
  BEGIN
    NULL;
  END;
END;
/




