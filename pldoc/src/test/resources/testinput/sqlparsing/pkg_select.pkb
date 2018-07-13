
DECLARE 
	l_dummy VARCHAR2(1);
BEGIN

--INSERT 
INSERT INTO dual
(dummy)
SELECT dummy 
FROM dual
RETURNING dummy INTO l_dummy
;

--INSERT 
INSERT INTO dual
(dummy)
SELECT *
FROM dual
RETURNING dummy INTO l_dummy
;

--SELECT 
SELECT dummy
INTO l_dummy
FROM dual
;


--SELECT 
SELECT MAX(dummy)
INTO l_dummy
FROM dual
HAVING COUNT(*) > 0 
;


--SELECT 
SELECT *
INTO l_dummy
FROM dual
WHERE dummmy IN (
		SELECT dummy 
		FROM Dual
		)
;


--SELECT 
SELECT *
FROM dual o
WHERE EXISTS (
		SELECT NULL 
		FROM dual i
		WHERE i.dummy = o.dummy  
	)
;


END;
/

