
WITH identifiers AS
(
SELECT   
ids.*
,DENSE_RANK() OVER (PARTITION BY  SIGNATURE  ORDER BY  USAGE DESC) priority  /* Prefer DEFINITION (OBJECT BODY) to DECLARATION (OBJECT SPECIFICATION)*/
FROM ALL_IDENTIFIERS ids
WHERE  ids.USAGE IN ( 'DECLARATION', 'DEFINITION') 
AND TYPE IN  ( 'CONSTANT',  'FUNCTION', 'PROCEDURE' , 'VARIABLE' , 'TRIGGER'  , 'SUBTYPE' , 'PACKAGE', 'OBJECT' , 'EXCEPTION' ) 
ORDER BY OWNER, OBJECT_TYPE,OBJECT_NAME,LINE,COL
)
,
calls AS
(
select 
 signature
,owner caller_owner 
,object_type caller_object_type
,object_name caller_object_name
,type caller_type
,usage_id caller_usage_id
,line caller_line
,col caller_col
,usage_context_id caller_context_id
FROM ALL_IDENTIFIERS
WHERE  USAGE = 'CALL' 
)
SELECT 
identifiers.*
,caller_owner 
,caller_object_type
,caller_object_name
,caller_type
,caller_usage_id
,caller_line
,caller_col
,caller_context_id
,DENSE_RANK() OVER (PARTITION BY  identifiers.SIGNATURE  ORDER BY identifiers.priority) call_priority  /* Prefer DEFINITION (OBJECT BODY) to DECLARATION (OBJECT SPECIFICATION)*/
FROM 
identifiers 
LEFT OUTER JOIN calls  ON (identifiers.signature = calls.signature)
ORDER BY
,caller_owner 
,caller_object_type 
,caller_object_name 
,caller_line 
,caller_col 
