


CREATE 
TRIGGER 
trg_before_definition
/**
*<P>Comment placed between the trigger name and the first keyword of the declaration section.</p>
*
*/
AFTER INSERT ON T4
REFERENCING NEW AS newRow
FOR EACH ROW
WHEN (newRow.a <= 10)
BEGIN
INSERT INTO T5 VALUES(:newRow.b, :newRow.a);
END trg_before_definition;
/

