

CREATE TRIGGER trg_11g_compound_trigger
/**
<pre>
*<code>
*<pre>
*   CREATE TABLE compound_trigger_test (
*     id           NUMBER,
*     description  VARCHAR2(50)
*   );
*</code>
*</pre>
By issuing several insert, update and delete statements against the test table we can see that the compound trigger is working as expected.

    SQL> SET SERVEROUTPUT ON
    SQL> INSERT INTO compound_trigger_test VALUES (1, 'ONE');
    BEFORE STATEMENT - INSERT
    BEFORE EACH ROW - INSERT (new.id=1)
    AFTER EACH ROW - INSERT (new.id=1)
    AFTER STATEMENT - INSERT

    1 row created.

    SQL> INSERT INTO compound_trigger_test VALUES (2, 'TWO');
    BEFORE STATEMENT - INSERT
    BEFORE EACH ROW - INSERT (new.id=2)
    AFTER EACH ROW - INSERT (new.id=2)
    AFTER STATEMENT - INSERT

    1 row created.

    SQL> UPDATE compound_trigger_test SET id = id;
    BEFORE STATEMENT - UPDATE
    BEFORE EACH ROW - UPDATE (new.id=2 old.id=2)
    AFTER EACH ROW - UPDATE (new.id=2 old.id=2)
    BEFORE EACH ROW - UPDATE (new.id=1 old.id=1)
    AFTER EACH ROW - UPDATE (new.id=1 old.id=1)
    AFTER STATEMENT - UPDATE

    2 rows updated.

    SQL> DELETE FROM compound_trigger_test;
    BEFORE STATEMENT - DELETE
    BEFORE EACH ROW - DELETE (old.id=2)
    AFTER EACH ROW - DELETE (old.id=2)
    BEFORE EACH ROW - DELETE (old.id=1)
    AFTER EACH ROW - DELETE (old.id=1)
    AFTER STATEMENT - DELETE

    2 rows deleted.

    SQL>

Don't forget to clean up the test table.

    DROP TABLE compound_trigger_test;

For a more practical use of compound triggers, we can take the example quoted in the Mutating Table Exceptions article and replace the two triggers and the package with a single compound trigger, as shown below.

    <code>
    CREATE OR REPLACE TRIGGER tab1_compound_trigger
      FOR INSERT OR UPDATE ON tab1
        COMPOUND TRIGGER

      TYPE t_change_tab IS TABLE OF tab1_audit%ROWTYPE;
      g_change_tab  t_change_tab := t_change_tab();

      AFTER EACH ROW IS
      BEGIN
        g_change_tab.extend;
        g_change_tab(g_change_tab.last).id           := tab1_audit_seq.NEXTVAL;
        IF INSERTING THEN
          g_change_tab(g_change_tab.last).action     := 'INSERT';
        ELSE
          g_change_tab(g_change_tab.last).action     := 'UPDATE';
        END IF;
        g_change_tab(g_change_tab.last).tab1_id      := :new.id;
        g_change_tab(g_change_tab.last).created_time := SYSTIMESTAMP;
      END AFTER EACH ROW;

      AFTER STATEMENT IS
        l_count  NUMBER(10);
      BEGIN
        FOR i IN g_change_tab.first .. g_change_tab.last LOOP
          SELECT COUNT(*)
          INTO   g_change_tab(i).record_count
          FROM   tab1;
        END LOOP;
        
        FORALL i IN g_change_tab.first .. g_change_tab.last
          INSERT INTO tab1_audit VALUES g_change_tab(i);

        g_change_tab.delete;
      END AFTER STATEMENT;
    END tab1_compound_trigger;
    <code>

</pre>
*/
FOR INSERT OR UPDATE OR DELETE ON compound_trigger_test
COMPOUND TRIGGER
      /** Global declaration. */
      /** String Collection. */
      TYPE t_tab IS TABLE OF VARCHAR2(50);
      /** List of actions performed on the table/row. */
      l_tab t_tab := t_tab();

      /** Clear down l_tab */
      PROCEDURE clear_down
      IS
      BEGIN
        l_tab.delete;
      END clear_down;

      /** Display l_tab */
      PROCEDURE display
      IS
      BEGIN
        FOR i IN l_tab.first .. l_tab.last LOOP
          DBMS_OUTPUT.put_line(l_tab(i));
        END LOOP;
      END display;

      /** Before statement action */
      BEFORE STATEMENT IS
      BEGIN
	clear_down;

        l_tab.extend;
        CASE
          WHEN INSERTING THEN
            l_tab(l_tab.last) := 'BEFORE STATEMENT - INSERT';
          WHEN UPDATING THEN
            l_tab(l_tab.last) := 'BEFORE STATEMENT - UPDATE';
          WHEN DELETING THEN
            l_tab(l_tab.last) := 'BEFORE STATEMENT - DELETE';
        END CASE;
      END BEFORE STATEMENT;

      /** Before Each Row action */
      BEFORE EACH ROW IS
      BEGIN
        l_tab.extend;
        CASE
          WHEN INSERTING THEN
            l_tab(l_tab.last) := 'BEFORE EACH ROW - INSERT (new.id=' || :new.id || ')';
          WHEN UPDATING THEN
            l_tab(l_tab.last) := 'BEFORE EACH ROW - UPDATE (new.id=' || :new.id || ' old.id=' || :old.id || ')';
          WHEN DELETING THEN
            l_tab(l_tab.last) := 'BEFORE EACH ROW - DELETE (old.id=' || :old.id || ')';
        END CASE;
      END BEFORE EACH ROW;

      /** After Each Row action */
      AFTER EACH ROW IS
      BEGIN
        l_tab.extend;
        CASE
          WHEN INSERTING THEN
            l_tab(l_tab.last) := 'AFTER EACH ROW - INSERT (new.id=' || :new.id || ')';
          WHEN UPDATING THEN
            l_tab(l_tab.last) := 'AFTER EACH ROW - UPDATE (new.id=' || :new.id || ' old.id=' || :old.id || ')';
          WHEN DELETING THEN
            l_tab(l_tab.last) := 'AFTER EACH ROW - DELETE (old.id=' || :old.id || ')';
        END CASE;
      END AFTER EACH ROW;

      /** After statement action */
      AFTER STATEMENT IS
      BEGIN
        l_tab.extend;
        CASE
          WHEN INSERTING THEN
            l_tab(l_tab.last) := 'AFTER STATEMENT - INSERT';
          WHEN UPDATING THEN
            l_tab(l_tab.last) := 'AFTER STATEMENT - UPDATE';
          WHEN DELETING THEN
            l_tab(l_tab.last) := 'AFTER STATEMENT - DELETE';
        END CASE;
        display;
        clear_down;
      END AFTER STATEMENT;


END trg_11g_compound_trigger;
/

