
CREATE OR REPLACE TYPE ty_string_aggregator AS OBJECT
(
 /**
  The basic type for a User-Defined Aggregate Function that concatenates strings, separating them with hash characters ('#')
  
  See <a href="http://download-west.oracle.com/docs/cd/B10501_01/appdev.920/a96595/dci11agg.htm">Oracle 9i Data Cartridge Developers Guide</a> for more details.

  This TYPE implements the ODCIAggregate Interface necessary for the aggregate function.

<h3>Overview</h3>

<p>You create a user-defined aggregate function by implementing a set of routines collectively referred to as the ODCIAggregate routines. You implement the routines as methods within an object type, so the implementation can be in any Oracle-supported language for type methods, such as PL/SQL, C/C++ or Java. When the object type is defined and the routines are implemented in the type body, you use the CREATE FUNCTION statement to create the aggregate function.
</p>

<p>Each of the four ODCIAggregate routines required to define a user-defined aggregate function codifies one of the internal operations that any aggregate function performs, namely:
</p>

    <ol>
    <li>Initialize  - ODCIAggregateInitialize</li>
    <li>Iterate     - ODCIAggregateIterate</li>
    <li>Merge       - ODCIAggregateMerge</li>
    <li>Terminate   - ODCIAggregateTerminate</li>
    </ol>
<h3>Enhancements</h3>

<p>In order to create different concatenation methods, 
create a new subtype with a custom ODCIAggregateInitialize function (to have different separators, and delimiters),
or a custom ODCIAggregateIterate (to process each value before contatenation).
</p>
  --@headcom
 */

 -- String placed between every value pair.
 separator        VARCHAR2(1000),
 -- String placed before every value .
 start_delimiter  VARCHAR2(4000),
 -- String placed after every value .
 end_delimiter    VARCHAR2(4000),
 -- String placed after every value .
 list             VARCHAR2(32767),
 --CONSTRUCTOR FUNCTION ty_string_aggregator() RETURN SELF AS RESULT,
 --CONSTRUCTOR FUNCTION ty_string_aggregator(pa_separator VARCHAR2:= ',', pa_delimiter_start VARCHAR2 := '', pa_delimiter_end VARCHAR2 := ''  ) RETURN SELF AS RESULT,
 STATIC FUNCTION ODCIAggregateInitialize(listCtx IN OUT ty_string_aggregator)
       RETURN NUMBER,
 MEMBER FUNCTION ODCIAggregateIterate(self IN OUT ty_string_aggregator,
       value IN VARCHAR2)
       RETURN NUMBER,
 MEMBER FUNCTION ODCIAggregateMerge(self IN OUT ty_string_aggregator,
       ctx2 IN ty_string_aggregator)
       RETURN NUMBER,
 MEMBER function ODCIAggregateTerminate(self     IN ty_string_aggregator,
       returnValue OUT VARCHAR2, flags IN STRING)
       RETURN NUMBER
)
NOT FINAL
;
/
