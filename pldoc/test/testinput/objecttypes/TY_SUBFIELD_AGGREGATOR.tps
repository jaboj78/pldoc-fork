CREATE OR REPLACE TYPE ty_subfield_aggregator UNDER ty_string_aggregator (
 /**
  This TYPE extends the basic string concatenation TYPE ( {@link TY_STRING_AGGREGATOR}), separating values with pipe characters ('|')
  
  --@headcom
 */
       --Set the separator to pipe character ('|')
       STATIC FUNCTION ODCIAggregateInitialize(listCtx IN OUT 
ty_string_aggregator)
        RETURN NUMBER
)
;
/

