--1146263	create - or replace trigger not parsed	



CREATE 
/**
*<P>This uses the default aliases to refer to old and new values. </p>
*
*/
TRIGGER trg_DEFAULT_ALIASes
AFTER UPDATE ON T4
FOR EACH ROW
WHEN (a <= 10)
BEGIN
UPDATE T5 log
SET
a = :NEW.b
,old_a = :OLD
,LASTUPDATED = :NEW.lastmodified
WHERE log.id = :NEW.ID
;
END trg_default_aliases;
/


