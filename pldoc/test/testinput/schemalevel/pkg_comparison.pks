CREATE OR REPLACE 
PACKAGE pkg_comparison 
AS

/** Update PKG_COMPARISON[publ_id=pa_publ_id AND epsfile=pa_epsfile].GRAPHIC_LAST_MODIFIED with modification date from file system. 

<P>This works around PL/SQL's inability to access filesystem information directly.</P>
<BR/>
<P>This PROCEDURE is a candidate for deprecation by replacing the entire update process by a process using Java within Oracle to get the modification date directly.</P>
 
 <BR/>
*@param  pa_last_date date derived from the file system
*@param  pa_epsfile filename (without any suffix) of the graphic file containing the Display Ad
*@param  pa_publ_id The Publication (Book) that should be updated
*@param  pa_logging_level logging level for this process - defaults to 'INFO'
**/
PROCEDURE prc_before_as_comparison(pa_last_date IN date, pa_epsfile IN varchar2, pa_publ_id IN varchar2, pa_logging_level IN varchar2 := 'INFO') ;
END;
/

