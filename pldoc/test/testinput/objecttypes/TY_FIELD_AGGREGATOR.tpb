CREATE OR REPLACE TYPE BODY ty_field_aggregator IS
/**
* Implementation of {@link TY_STRING_AGGREGATOR} that separates values by a hash(#) character.
*@headcom
**/

/**
* Specify value separator as hash ('#') character.
*
<ds>
<pre>
         initialize object instances persistent variables:-
		   separator = pipe character
		   ,start_delimiter
		   ,end_delimiter
		   ,and list 
</pre>
</ds>
		
* @parameter listCtx base object to be initialised 
* @return ODCIConst.success on success.
*
*/
  STATIC FUNCTION ODCIAggregateInitialize( listCtx       IN OUT 
ty_string_aggregator)
        RETURN NUMBER is

  BEGIN
        --Separate values with field (hash-'#') characters 
        /* initialize our persistent variables:
		   separator = pipe character
		   ,start_delimiter
		   ,end_delimiter
		   ,and list 
		*/
        listCtx := ty_string_aggregator('#',NULL,NULL,NULL);
        RETURN ODCIConst.success;
  END;
  
  
END;
/

