
VARIABLE b_dummy VARCHAR2(10; 

EXECUTE :b_dummy := 'Y'; 

--INSERT 
INSERT INTO dual
(dummy)
VALUES(:b_dummy)
;

--SELECT 
SELECT dummy
INTO :b_dummy
FROM dual
;

--UPDATE 
UPDATE dual
SET dummy - 'X'
WHERE dummy = :b_dummy
;

--DELETE 
DELETE dual
WHERE dummy = :b_dummy
;

CREATE OR REPLACE PACKAGE BODY pkg_simplest
AS
	l_dummy dual.dummy%TYPE;

BEGIN
	--INSERT 
	INSERT INTO dual
	(dummy)
	VALUES(l_dummy)
	;

	--SELECT 
	SELECT dummy
	INTO l_dummy
	FROM dual
	;

	--UPDATE 
	UPDATE dual
	SET dummy - 'X'
	WHERE dummy = l_dummy
	;

	--DELETE 
	DELETE dual
	WHERE dummy = l_dummy
	;

END;
/

