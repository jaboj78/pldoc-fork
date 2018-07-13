CREATE OR REPLACE TYPE BODY ty_subfield_aggregator IS

  STATIC FUNCTION ODCIAggregateInitialize( listCtx       IN OUT 
ty_string_aggregator)
        RETURN NUMBER is

  BEGIN
        --Separate values with subfield (pipe-'|') characters 
        /* initialize our persistent variables:
		   separator = pipe character
		   ,start_delimiter
		   ,end_delimiter
		   ,and list 
		*/
        listCtx := ty_string_aggregator('|',NULL,NULL,NULL);
        RETURN ODCIConst.success;
  END;
  
  
END;
/

