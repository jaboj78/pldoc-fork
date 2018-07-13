/**
*<P>Comment placed before the CREATE keyword . </p>
*
*/
CREATE TRIGGER trg_before_create
AFTER INSERT ON T4
REFERENCING NEW AS newRow
FOR EACH ROW
WHEN (newRow.a <= 10)
BEGIN
INSERT INTO T5 VALUES(:newRow.b, :newRow.a);
END trg_before_create;
/

