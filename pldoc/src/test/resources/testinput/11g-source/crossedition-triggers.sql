CREATE OR REPLACE TRIGGER Contacts_default_Xed
/**
*Create default CROSSEDITION trigger 
*@SEE http://www.morganslibrary.org/reference/crossedition_trigger.html
*/
BEFORE INSERT OR UPDATE ON Contacts_Table
FOR EACH ROW
CROSSEDITION
DISABLE
BEGIN
  Set_First_And_Last_Name(:NEW.Name_1, :NEW.First_Name_2, :NEW.Last_Name_2);
  Set_Country_Code_And_Phone_No(:NEW.Phone_Number_1, :NEW.Country_Code_2, :NEW.Phone_Number_2);
END Contacts_Fwd_Xed;
/

CREATE OR REPLACE TRIGGER Contacts_Fwd_Xed
/**
* Create FORWARD Editioning Trigger.	
*@SEE http://www.morganslibrary.org/reference/crossedition_trigger.html
*/
BEFORE INSERT OR UPDATE ON Contacts_Table
FOR EACH ROW
FORWARD CROSSEDITION
DISABLE
BEGIN
  Set_First_And_Last_Name(:NEW.Name_1, :NEW.First_Name_2, :NEW.Last_Name_2);
  Set_Country_Code_And_Phone_No(:NEW.Phone_Number_1, :NEW.Country_Code_2, :NEW.Phone_Number_2);
END Contacts_Fwd_Xed;
/



CREATE OR REPLACE TRIGGER Contacts_Rvrs_Xed
/**
*Create Reverse Editioning Trigger.	
*@SEE http://www.morganslibrary.org/reference/crossedition_trigger.html
*/
BEFORE INSERT OR UPDATE ON Contacts_Table
FOR EACH ROW
REVERSE CROSSEDITION
DISABLE
BEGIN
  :NEW.Name_1 := :NEW.Last_Name_2||', '||:NEW.First_Name_2;
  :NEW.Phone_Number_1 := 
     CASE :New.Country_Code_2 WHEN '+1' THEN
       REPLACE(:NEW.Phone_Number_2, '-', '.')
     ELSE
       '011.'||LTRIM(:NEW.Country_Code_2, '+')||'.'|| REPLACE(:NEW.Phone_Number_2, '-', '.')
     END;
END Contacts_Rvrs_Xed;
/

CREATE OR REPLACE TRIGGER follows_test
/**
*FORWARD CROSSEDITION witk FOLLOWS CLAUSE.	
*@SEE http://www.morganslibrary.org/reference/crossedition_trigger.html
*/
BEFORE INSERT OR UPDATE ON person_tab
FOR EACH ROW
FORWARD CROSSEDITION
FOLLOWS ebradmin.person_fwd_xed
ENABLE
BEGIN
  dbms_output.put_line('FOLLOWS_TEST');
END person_fwd_xed;
/

CREATE OR REPLACE TRIGGER precedes_test
/**
*REVERSE CROSSEDITION with PRECEDES CLAUSE.	
*@SEE http://www.morganslibrary.org/reference/crossedition_trigger.html
*/
BEFORE INSERT OR UPDATE ON person_tab
FOR EACH ROW
REVERSE CROSSEDITION
PRECEDES ebradmin.person_rev_xed
ENABLE
BEGIN
  dbms_output.put_line('PRECEDES_TEST');
END person_rev_xed;
/
