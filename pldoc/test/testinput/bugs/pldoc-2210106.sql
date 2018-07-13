--2210106	Defaults - for parameters are not shown	

-- Start of DDL Script for Package S205031.PK_PLDOC
-- Generated 30.10.2008 18:38:47 from S205031@IKB3

CREATE OR REPLACE 
PACKAGE pldoc_bug.testcase_2210106 IS
  /**
  * Test package for several bug tracker artefacts.
  * @headcom
  */

  /** Constant, which will not shown with value in html.*/
  vcConstant CONSTANT VARCHAR2(10) := 'VALUE';

  /**
  * Test procedure to show, that parameters, which named in mixed case, are
  * shown in lower case in the output.
  * @param i_vcMixedCase The mixed case parameter.
  */
  PROCEDURE pr_mixed_case(i_vcMixedCase IN VARCHAR2);

  /**
  * Test procedure to show, that for parameters, which have an default, the
  * defautl is not shown in the output.
  * @param i_vcMixedCase The mixed case parameter.
  */
  PROCEDURE pr_default_parameter(i_vcDefault IN VARCHAR2 DEFAULT 'STANDARD');
END;
/

CREATE OR REPLACE 
PACKAGE BODY pk_pldoc IS
  PROCEDURE pr_mixed_case(i_vcMixedCase IN VARCHAR2) IS
  BEGIN
    NULL;
  END;

  PROCEDURE pr_default_parameter(i_vcDefault IN VARCHAR2 DEFAULT 'STANDARD') IS
  BEGIN
    NULL;
  END;
END;
/


-- End of DDL Script for Package S205031.PK_PLDOC


