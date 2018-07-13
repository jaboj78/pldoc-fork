CREATE OR REPLACE TYPE pldoc_bug.testcase_3510415 AS OBJECT (
	ROUTE VARCHAR2(400),
	PRIORITY NUMBER,
CONSTRUCTOR FUNCTION AAL2_AP_ROUTE(ROUTE VARCHAR2) RETURN SELF AS RESULT,
MEMBER FUNCTION RemoveAal2Ap RETURN VARCHAR2,
MEMBER FUNCTION AddAal2Ap RETURN VARCHAR2,
MEMBER FUNCTION SHOW RETURN VARCHAR2,
MAP MEMBER FUNCTION getId RETURN VARCHAR2)
/** 
* Class to model AAL2 Access Point (AP) reference used in AAL2 Routing Case
* @author Wernfried
* @headcom
*/
/


CREATE OR REPLACE TYPE BODY pldoc_bug.testcase_3510415  IS   

/** 
* Constructor for Aal2Ap if priority is not known
* @param ROUTE Full Distinguished Name (FDN) of Aal2Ap
* @return New instance of Aal2ApRoute
*/
CONSTRUCTOR FUNCTION AAL2_AP_ROUTE(ROUTE VARCHAR2) RETURN SELF AS RESULT IS
BEGIN
	SELF.ROUTE := ROUTE;
	SELF.PRIORITY := NULL;
	RETURN;
END AAL2_AP_ROUTE;

/** 
* Generates a unique Id string for this object
* @return Unique ID for Aal2Ap
*/
MAP MEMBER FUNCTION getId RETURN VARCHAR2 IS
BEGIN
	RETURN SELF.ROUTE||'-'||SELF.PRIORITY;
END getId;

/** 
* XML string for action removeAal2ApFromRc on Aal2RoutingCase
* Removes the identified Aal2Ap MO from the routeList.
* @return XML string which removed this Aal2Ap from Aal2RoutingCase
*/
MEMBER FUNCTION RemoveAal2Ap RETURN VARCHAR2 IS
BEGIN
	RETURN '<es:removeAal2ApFromRc><es:route>'||SELF.ROUTE||'</es:route></es:removeAal2ApFromRc>';
END RemoveAal2Ap;

/** 
* XML string for action addAal2ApToRc on Aal2RoutingCase
* Adds the identified (and existing) Aal2Ap MO to the routeList
* @return XML string which adds this Aal2Ap to Aal2RoutingCase
*/
MEMBER FUNCTION AddAal2Ap RETURN VARCHAR2 IS
BEGIN
	RETURN '<es:addAal2ApToRc><es:route>'||SELF.ROUTE||'</es:route><es:priority>'||SELF.PRIORITY||'</es:priority></es:addAal2ApToRc>';
END AddAal2Ap;

/** 
* String which is used to display this Aal2Ap in GUI
* @return User-Friendly string for this Aal2Ap 
*/
MEMBER FUNCTION SHOW RETURN VARCHAR2 IS
BEGIN
	RETURN SELF.PRIORITY||' - '||SELF.ROUTE;
END SHOW;
END;
/
