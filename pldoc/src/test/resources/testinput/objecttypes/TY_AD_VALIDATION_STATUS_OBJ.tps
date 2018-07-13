CREATE OR REPLACE 
TYPE ty_validation_status_obj
AS OBJECT (
    adseq             VARCHAR2(42) -- ad.ad_id%TYPE
   ,displayad_id      VARCHAR2(10) -- ad.displayad_id%TYPE
   ,status            VARCHAR2(40) -- tdo_ad.status%TYPE
   );
/

SHOW ERRORS
