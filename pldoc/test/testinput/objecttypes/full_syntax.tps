CREATE OR REPLACE TYPE ty_full_syntax  AS OBJECT
(
/**
 <DS>
 inheritance clause

 subprogram_space | constructor_spec | map_order_function_spec 
 
 inheritance clause:
 (NOT )+ ( OVERRIDING | FINAL | INSTANTIABLE) 

 subprogram_space :

  ( member | static ) ( procedure_spec | function_spec )  
 
 constructor_spec  :
  
  ( final )? ( INSTANTIABLE )? CONSTRUCTOR FUNCTION datatype "(" SELF IN OUT datatype , (parameter parameter type )+ ")" 
 
 map_order_function_spec :

 (map | order ) member function_spec


 procedure_spec :
 
 procedure name "(" parameter parametertype, ... ")" ( as call_spec )? 
 
 function_spec :

 function name "(" parameter parametertype, ... ")" return_clause 


 return_clause :

 return datatype ( as call_spec )? 
 
 *@headcom
 </DS>
**/
/**
* single_field comment
**/
single_field NUMBER(9),
/**
* CONSTRUCTOR FUNCTION  ty_full_syntax (single_field NUMBER) RETURN SELF AS RESULT, comment
**/
CONSTRUCTOR FUNCTION  ty_full_syntax (single_field NUMBER) RETURN SELF AS RESULT,
/**
* MEMBER FUNCTION  to_string  RETURN VARCHAR2, comment
**/
MEMBER FUNCTION  to_string  RETURN VARCHAR2,
STATIC FUNCTION  class_string  RETURN VARCHAR2,
MAP MEMBER FUNCTION  mapping (parameter ty_full_syntax)  RETURN NUMBER,
ORDER MEMBER FUNCTION  ordering (parameter ty_full_syntax)  RETURN NUMBER,


INSTANTIABLE CONSTRUCTOR FUNCTION  ty_full_syntax (single_field NUMBER, second_field NUMBER ) RETURN SELF AS RESULT,
INSTANTIABLE MEMBER FUNCTION  instantiable_to_string  RETURN VARCHAR2,
INSTANTIABLE STATIC FUNCTION  instantiable__class_string  RETURN VARCHAR2,
INSTANTIABLE MAP MEMBER FUNCTION  instantiable_mapping (parameter ty_full_syntax)  RETURN NUMBER,
INSTANTIABLE ORDER MEMBER FUNCTION  instantiable_ordering (parameter ty_full_syntax)  RETURN NUMBER,


FINAL INSTANTIABLE CONSTRUCTOR FUNCTION  ty_full_syntax (single_field NUMBER, second_field NUMBER, td NUMBER) RETURN SELF AS RESULT,
FINAL INSTANTIABLE MEMBER FUNCTION  full_to_string  RETURN VARCHAR2,
FINAL INSTANTIABLE STATIC FUNCTION  full__class_string  RETURN VARCHAR2,
FINAL INSTANTIABLE MAP MEMBER FUNCTION  full_mapping (parameter ty_full_syntax)  RETURN NUMBER,
/**
* final instantiABLE order MeMBER FUnctiON  full_ordering (parameter ty_full_syntax)  RETURN NUMBER comment
**/
final instantiABLE order MeMBER FUnctiON  full_ordering (parameter ty_full_syntax)  RETURN NUMBER
)
NOT FINAL NOT INSTANTIABLE 
;

