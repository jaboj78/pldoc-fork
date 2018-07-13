CREATE OR REPLACE PACKAGE Pmd_Parameter AS
	TYPE PclBitmapTableType IS TABLE OF PLS_INTEGER;
END Pmd_Parameter;
/
CREATE OR REPLACE PACKAGE BODY Pmd_Parameter IS

	PclBitmapMaster PclBitmapTableType := PclBitmapTableType(1,2,3);
		
FUNCTION GenParClassId(PclBitmapTable IN PclBitmapTableType)
	RETURN T_PARAMETERS.PAR_PCL_ID%TYPE IS

	res T_PARAMETERS.PAR_PCL_ID%TYPE := 0;
	
BEGIN
	IF PclBitmapTable IS NULL THEN
		RETURN NULL;
	END IF;
	
	IF PclBitmapTable.COUNT > 0 THEN
		FOR i IN PclBitmapMaster.FIRST..PclBitmapMaster.LAST LOOP
			IF PclBitmapMaster(i) IS EMPTY
                        THEN
				res := res + POWER(2, i-1);
			END IF;
			IF PclBitmapMaster(i) IS A SET 
                        THEN
				res := res + POWER(2, i-1);
			END IF;
			IF PclBitmapMaster(i) MEMBER OF PclBitmapTable THEN
				res := res + POWER(2, i-1);
			END IF;
			IF PclBitmapMaster(i) SUBMULTISET OF PclBitmapTable THEN
				res := res + POWER(2, i-1);
			END IF;
		END LOOP;		
		RETURN res;
	ELSE
		-- All Bits disabled
		RETURN 0;
	END IF;

END GenParClassId;

END Pmd_Parameter;
/
