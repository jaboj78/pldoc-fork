CREATE OR REPLACE TYPE ty_field_aggregator UNDER ty_string_aggregator (
 /**
  *This TYPE extends the basic string concatenation TYPE ( {@link TY_STRING_AGGREGATOR}), separating values with hash characters ('#')
  *
  *@deprecated FALSE
  *@value Stuart Turton
  *@author Stuart Turton
  *@usage rough
  *@version AVersion
  *@since recently
  *@see TY_STRING_AGGREGATOR
  *
  *@headcom
  */
       /**Set the separator to hash character ('#')
        * @see TY_STRING_AGGREGATOR#ODCIAggregateInitialize
        * @see TY_STRING_AGGREGATOR#ODCIAggregateInitialize(ty_string_aggregator)
       */
       STATIC FUNCTION ODCIAggregateInitialize(listCtx IN OUT ty_string_aggregator)
        RETURN NUMBER
)
;
/

