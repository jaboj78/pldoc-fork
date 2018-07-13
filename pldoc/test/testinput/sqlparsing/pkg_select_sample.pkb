

DECLARE 
	l_dummy VARCHAR2(1);
BEGIN

--INSERT 
INSERT INTO dual
(dummy)
SELECT dummy 
FROM dual
SAMPLE (10)
RETURNING dummy INTO l_dummy
;

--INSERT 
INSERT INTO dual
(dummy)
SELECT *
FROM dual
SAMPLE (10)
RETURNING dummy INTO l_dummy
;

--SELECT 
SELECT dummy
INTO l_dummy
FROM dual
SAMPLE (10)
;


--SELECT 
SELECT MAX(dummy)
INTO l_dummy
FROM dual
SAMPLE (10)
HAVING COUNT(*) > 0 
;


--SELECT 
SELECT *
INTO l_dummy
FROM dual
SAMPLE (10)
WHERE dummmy IN (
		SELECT dummy 
		FROM Dual
		)
;


--SELECT 
SELECT *
FROM dual o
SAMPLE (10)
WHERE EXISTS (
		SELECT NULL 
		FROM dual i
		WHERE i.dummy = o.dummy  
	)
;



--INSERT 
INSERT INTO dual
(dummy)
SELECT dummy 
FROM dual
SAMPLE BLOCK (20, 8621)
RETURNING dummy INTO l_dummy
;

--INSERT 
INSERT INTO dual
(dummy)
SELECT *
FROM dual
SAMPLE BLOCK (20, 8621)
RETURNING dummy INTO l_dummy
;

--SELECT 
SELECT dummy
INTO l_dummy
FROM dual
SAMPLE BLOCK (20, 8621)
;


--SELECT 
SELECT MAX(dummy)
INTO l_dummy
FROM dual
SAMPLE BLOCK (20, 8621)
HAVING COUNT(*) > 0 
;


--SELECT 
SELECT *
INTO l_dummy
FROM dual
SAMPLE BLOCK (20, 8621)
WHERE dummmy IN (
		SELECT dummy 
		FROM Dual
		)
;


--SELECT 
SELECT *
FROM dual o
SAMPLE BLOCK (20, 8621)
WHERE EXISTS (
		SELECT NULL 
		FROM dual i
		WHERE i.dummy = o.dummy  
	)
;

END;
/

