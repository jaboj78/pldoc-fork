
CREATE 
/**
*<P>Comment placed between the CREATE keyword and the TRIGGER keyword . </p>
*
*/
TRIGGER trg_before_keyword
AFTER INSERT ON T4
REFERENCING NEW AS newRow
FOR EACH ROW
WHEN (newRow.a <= 10)
BEGIN
INSERT INTO T5 VALUES(:newRow.b, :newRow.a);
END trg_before_keyword;
/

