CREATE OR REPLACE TYPE BODY ty_string_aggregator IS

 STATIC FUNCTION ODCIAggregateInitialize( listCtx       IN OUT ty_string_aggregator)
       RETURN NUMBER is

 BEGIN
       /* initialize our persistent variables, separator and list */
       listCtx := ty_string_aggregator(NULL,NULL,NULL,NULL);
       RETURN ODCIConst.success;

 END;


 MEMBER FUNCTION ODCIAggregateIterate( self      IN OUT ty_string_aggregator,
       value IN VARCHAR2)
       return NUMBER IS
/**
  Append the value to the existing string.
*/

 BEGIN
       IF (self.list is null) THEN
              self.list   := self.start_delimiter || value || self.end_delimiter ;
       ELSE
              --Append this value to the list, including any specified separator and delimiters
              self.list   := self.list || self.separator 
                             || self.start_delimiter || value || self.end_delimiter ;
       END IF;
       RETURN ODCIConst.success;

 END;


 MEMBER FUNCTION ODCIAggregateTerminate( self    IN ty_string_aggregator,
       returnValue OUT VARCHAR2, flags IN STRING)
       RETURN NUMBER is

 BEGIN
       returnValue := self.list;
       return ODCIConst.success;

 END;


MEMBER FUNCTION ODCIAggregateMerge(  self              IN OUT ty_string_aggregator,
                                  ctx2      IN ty_string_aggregator)
       RETURN NUMBER is

 BEGIN
       IF (self.list > '' AND ctx2.list > '') THEN
              self.list := self.list || self.separator || ctx2.list;
       ELSE IF (self.list > '' and ctx2.list = '') THEN
                     null;
              ELSE
                     self.list := ctx2.list;
              END IF;
       END IF;
       return ODCIConst.success;

END;


END;
/
