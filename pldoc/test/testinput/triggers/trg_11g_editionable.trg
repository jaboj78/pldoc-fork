 
  CREATE OR REPLACE EDITIONABLE TRIGGER "TESTUSER"."TRG_11G_EDITIONABLE" 
  /**
   Test Parsing NEW keyword as an alias and NEW keyword as Object Constructor.
  **/
   AFTER UPDATE
   ON testuser.testtable
   FOR EACH ROW
     WHEN (NEW.delflag = 'Y' and old.delflag='N') DECLARE

 l_location TY_LOCATION;
BEGIN

 l_location :=  NEW TY_LOCATION(
			   pa_name     
			  ,pa_latitude 
			  ,pa_longitude 
			  ,pa_datum 
			  ) ;
 l_location.delete;
END TRG_11G_EDITIONABLE;

/
 


