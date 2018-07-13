
CREATE TRIGGER trg_fires_first
/**
*<P>Comment placed before the CREATE keyword . </p>
*
*/
AFTER INSERT ON T4
REFERENCING NEW AS newRow
FOR EACH ROW
WHEN (newRow.a <= 10)
BEGIN
INSERT INTO T5 VALUES(:newRow.b, :newRow.a);
END trg_fires_first;
/


CREATE TRIGGER trg_fires_next
/**
*<P>Comment placed before the CREATE keyword . </p>
*
*/
AFTER INSERT ON T4
REFERENCING NEW AS newRow
FOR EACH ROW
FOLLOWS trg_first_first
WHEN (newRow.a <= 10)
BEGIN
UPDATE  T5 SET col1 = :newRow.b, col2 = :newRow.a;
END trg_fires_nextt;
/

