
CREATE OR REPLACE 
PROCEDURE 
prc_before_as(pa_last_date IN date, pa_epsfile IN varchar2, pa_publ_id IN varchar2, pa_logging_level IN varchar2 := 'INFO') 
/**
<P>Update PRC_BEFORE_AS[publ_id=pa_publ_id AND epsfile=pa_epsfile].GRAPHIC_LAST_MODIFIED with modification date from file system.</P>
<P>This works around PL/SQL's inability to access filesystem information directly.</P>
 
 <BR/>
*@param  pa_last_date date derived from the file system
*@param  pa_epsfile filename (without any suffix) of the graphic file containing the Display Ad
*@param  pa_publ_id The Publication (Book) that should be updated
*@param  pa_log_level logging level for this process - defaults to 'INFO'
<BR/>
This PROCEDUDE is a candidate for deprecation by replacing the entire update process by a process using Java within Oracle to get the modification date directly.

*/
AS

   m_loggername         CONSTANT VARCHAR2 (100) := 'lm_export';
   m_threadname         CONSTANT VARCHAR2 (100)
                                   := SYS_CONTEXT ('USERENV', 'SESSION_USER');
   m_body_filename      CONSTANT VARCHAR2 (100) := 'GRAPHIC_UPDATE.prc';
   m_package_name       CONSTANT VARCHAR2 (30)  := 'graphic_update';
   m_caller_class       CONSTANT VARCHAR2 (100) := 'lm_export';
   m_log_level                   VARCHAR2 (30)  := 'INFO';
BEGIN
  DBMS_APPLICATION_INFO.SET_MODULE(m_package_name,m_package_name);
  DBMS_APPLICATION_INFO.SET_CLIENT_INFO('(PUBL_ID,EPSFILE)=('||pa_publ_id ||','||pa_epsfile||')');

  UPDATE EXPORT 
    SET graphic_last_modified = pa_last_date 
  WHERE epsfile= pa_epsfile 
  AND  publ_id = pa_publ_id
  ;
  IF SQL%ROWCOUNT = 0
  THEN
  pkg_logging.log_message
                   (pa_message  => 'No EXPORT found trying to set GRAPHIC_LAST_MODIFIED for (PUBL_ID,EPSFILE,GRAPHIC_LAST_MODIFIED)=('
                  ||pa_publ_id ||','||pa_epsfile||','||TO_CHAR(pa_last_date,'YYYYMMDDHH24MISS')||')'
          ,pa_level_string         => 'WARN',
                    pa_loggername           => m_loggername,
                    pa_threadname           => m_threadname,
                    pa_caller_filename      => m_body_filename,
                    pa_caller_class         => m_caller_class,
                    pa_caller_method        => 'graphic_update'
                   );
  ELSE
  pkg_logging.log_message
                   (pa_message  => 'Set GRAPHIC_LAST_MODIFIED for (PUBL_ID,EPSFILE,GRAPHIC_LAST_MODIFIED)=('
                  ||pa_publ_id ||','||pa_epsfile||','||TO_CHAR(pa_last_date,'YYYYMMDDHH24MISS')||')'
          ,pa_level_string         => 'DEBUG',
                    pa_loggername           => m_loggername,
                    pa_threadname           => m_threadname,
                    pa_caller_filename      => m_body_filename,
                    pa_caller_class         => m_caller_class,
                    pa_caller_method        => 'graphic_update'
                   );
  END IF;          
  DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
EXCEPTION
  WHEN OTHERS THEN
      pkg_logging.log_error (pa_loggername           => m_loggername,
                                  pa_threadname           => m_threadname,
                                  pa_caller_filename      => m_body_filename,
                                  pa_caller_class         => m_caller_class,
                                  pa_caller_method        => 'graphic_update'
                                 );
      pkg_logging.log_message
                       (pa_message  => 'Problem setting GRAPHIC_LAST_MODIFIED for (PUBL_ID,EPSFILE,GRAPHIC_LAST_MODIFIED)=('
              ||pa_publ_id ||','||pa_epsfile||','||TO_CHAR(pa_last_date,'YYYYMMDDHH24MISS')||')'
            ,pa_level_string         => 'ERROR',
                        pa_loggername           => m_loggername,
                        pa_threadname           => m_threadname,
                        pa_caller_filename      => m_body_filename,
                        pa_caller_class         => m_caller_class,
                        pa_caller_method        => 'graphic_update'
                       );
     DBMS_APPLICATION_INFO.SET_MODULE(NULL,NULL);
     RAISE;
END prc_before_as;
/

SHOW ERRORS 

