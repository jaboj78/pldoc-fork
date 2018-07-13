CREATE OR REPLACE PACKAGE split_operators
IS
/**
Ensure that split operators such as "! =" are coped with 
@headcom 
*/


/** Split != operator* */
c_not_equal_shriek BOOLEAN := (1 ! -- Comment 
= 2);

/** Split <> operator* */
c_not_equal_pip BOOLEAN := (1 < -- Comment 
> 2);

/** Split <= operator* */
c_less_than_equal BOOLEAN := (1 < -- Comment 
= 2);

/** Split >= operator* */
c_greater_than_equal BOOLEAN := (1 > -- Comment 
= 2);

/** Split := operator* */
c_assignment BOOLEAN :
= (1 =  2);


/**  < operator* */
c_less_than BOOLEAN := (1 < -- Comment 
 2);

/** > operator* */
c_greater_than BOOLEAN := (1 > -- Comment 
 2);

END;
/


