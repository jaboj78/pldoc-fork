--3042925	Object - oriented code dies	

CREATE OR REPLACE
PACKAGE pldoc_bug.testcase_3042925
IS 
/**
 * Project: Test Project (Starschema)
* Description: Employee load...
* DB impact: YES
* Commit inside: YES
* Rollback inside: YES
* @author Foldi Tamas (Starschema Kft)
* @headcom
*/
 
v_prc_name CONSTANT VARCHAR2( 50 ) := 'ETL_EMPLOYEE';
 /* current procedure's name */
 v_prc_desc CONSTANT VARCHAR2( 50 ) := 'Load employees from SCOTT';
 /* current procedure's ddescription */
 v_src_sch CONSTANT VARCHAR2( 30 ) := 'ISZMETL';
 /* ETL schema's name */
 v_src_table CONSTANT VARCHAR2( 30 ) := 'SRC_EMPLOYEE';
 /*Source table name*/
 v_dm_sch CONSTANT VARCHAR2( 30 ) := 'ISZM';
 /* schema where the DM table is located*/
 v_dm_table CONSTANT VARCHAR2( 30 ) := 'DIM_EMPLOYEE';
 /*DM table name*/
 v_tab_load CONSTANT VARCHAR2( 15 ) := 'UPSERT';
 /* load type */
 v_src_id CONSTANT NUMBER( 10 ) := 0;
 /*Source ID from sys_dta_src*/
 /** these steps are executed by the main function */
 v_load_steps CONSTANT typ_str_arr := NEW typ_str_arr( 'step_tmp_employee', 'step_src_employee' );
 v_start_date DATE;
 /* procedure start date*/
 v_batch_id VARCHAR2( 50 );
 /* identifier of given overnight batch */
 v_run_type VARCHAR2( 50 );
 /* Normal execution or Re-run */
 v_cnt NUMBER( 15 );
 /* count of updated rows */
 v_err NUMBER;
 /*Error*/
 v_msg VARCHAR2( 32000 );
 /*Message*/
 v_log_id NUMBER( 10 );
 /* remove me */
 /**
 * Executes the load procedure 
 * @param p_input_params Procedure parameters (key=value pairs) * @throws others if load fails
 */
 PROCEDURE main( p_input_params VARCHAR2 );
 /**
 * Executes the load procedure
 *
 * @param p_params Procedure parameters (omissible) * @throws others if load fails
 */
 PROCEDURE main( p_params param_list DEFAULT NULL );
 /**
 * Executes built-in tests
 *
 * @param p_params Procedure parameters (omissible)
 * @throws others if load fails
 */
 PROCEDURE test( p_params param_list DEFAULT NULL );
 /**
 * Loads data from SCOTT.EMP to tmp_scott_emp
 *
 * @param p_params Procedure parameters
 * @throws others if step fails */
 PROCEDURE step_tmp_employee( p_params IN OUT obj_param );
 /**
 * Loads data from tmp_scott_emp to SRC_EMPLOYEE
 *
 * @param p_params Procedure parameters
 * @throws others if step fails
 */
 PROCEDURE step_src_employee( p_params IN OUT obj_param );
END etl_employee;
/
