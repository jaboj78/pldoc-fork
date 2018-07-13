--2210106	Defaults - for parameters are not shown	

-- Start of DDL Script for Package S205031.PK_PLDOC
-- Generated 30.10.2008 18:38:47 from S205031@IKB3

CREATE OR REPLACE 
PACKAGE pldoc_bug.testcase_3449496 IS
  /**
  * ========================================================================<br/>
  * Project:         Test Project (<a href="http://pldoc.sourceforge.net">PLDoc</a>)<br/>
  * Description:     A little bit naïve but want to use national character here.<br/>
  * DB impact:       YES<br/>
  * Commit inside:   NO<br/>
  * Rollback inside: NO<br/>
  * ------------------------------------------------------------------------<br/>
  * $Header: /cvsroot/pldoc/sources/testinput/test1.sql,v 1.2 2004/06/22 14:37:46 altumano Exp $<br/>
  * ========================================================================<br/>
  * @deprecated Use something <b>new</b> instead.
  * @headcom
  */

  /** Constant, which will not shown with value in html.*/
  vcConstant CONSTANT VARCHAR2(10) := 'VALUE';

  /**
  * Test (in Specification) procedure to show, that parameters, which named in mixed case, are
  * shown in lower case in the output.
  * @param i_vcMixedCase This mixed case parameter has an inline @deprecated deprecated tag.
  * @deprecated Demonstrating that single sentence deprecated method comments are processed correctly. 
  */
  PROCEDURE pr_mixed_case(i_vcMixedCase IN VARCHAR2);

  /**
  * Test (in Specification) procedure to show, that for parameters, which have an default, the
  * default is not shown in the output.
  * @param i_vcMixedCase The mixed case parameter.
  * @return success code - please ignore @deprecated.
  * @deprecated Demonstrating that multi-sentence deprecated method comments are processed correctly. 
  */
  FUNCTION pr_default_parameter(i_vcDefault IN VARCHAR2 DEFAULT 'STANDARD') RETURN INTEGER;
END;
/

CREATE OR REPLACE 
PACKAGE BODY pldoc_bug.testcase_3449496 IS

  /**
  * Test (in BODY) procedure to show, that for parameters, which have an default, the
  * default is not shown in the output.
  * @param i_vcMixedCase This mixed case parameter has an inline @deprecated deprecated tag.
  * @deprecated 
  */
  PROCEDURE pr_mixed_case(i_vcMixedCase IN VARCHAR2) IS
  BEGIN
    NULL;
  END;


  /**
  * Test (in BODY) procedure to show, that for parameters, which have an default, the
  * default is not shown in the output.
  * @param i_vcMixedCase The mixed case parameter.
  * @deprecated 
  */
  PROCEDURE pr_default_parameter(i_vcDefault IN VARCHAR2 DEFAULT 'STANDARD') IS
  BEGIN
    NULL;
  END;

  /**
  * Private test (in BODY) procedure to show, that for parameters, which have an default, the
  * default is not shown in the output.
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


-- End of DDL Script for Package S205031.PK_PLDOC


