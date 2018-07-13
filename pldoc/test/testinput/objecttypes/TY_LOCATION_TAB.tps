CREATE OR REPLACE
TYPE ty_location_tab 
/**
BEFORE AS Collection of {@link ty_location} - used to retrieve generic collections of IDs  via BULK collection.
@headcom
*/
AS
/**
AFTER AS Collection of {@link ty_location} - used to retrieve generic collections of IDs  via BULK collection.
@headcom
*/
TABLE OF ty_location ;
/


SHOW ERRORS 
