CREATE OR REPLACE package pldoc_bug.testcase_3440459 as
/**
Provides services to consumers that need to create & delete seats and enroll customers in UCDE classes
*<br/> <br/>
*<b>Semantics</b> <br/>
*<blockquote>
*<b>Reserve:</b> lock a seat; other consumers cannot reserve it; consumer intends to hold it for an order or enrollment in progress<br/>
*<b>Hold:</b> hold a seat by linking it to an enrollment or a web order<br/>
*<b>Assign:</b>  write a web order ID to a seat previously held by a web customer<br/>
*<b>Release:</b> return seats to the free pool</blockquote> 
* @headcom
*/
    function seats_exist (s_id in unex.section.section_id%type) return boolean;
    --test for existence of rows in the section seat table for a single section (project)
    function get_pending_enroll_count (s_id in unex.section.section_id%type) return pls_integer;
    --gets a count = sum of locked seats and pending web enrollments
    function hold_seat(
        sect_id in unex.section_seat.section_id%type,
        enroll_id in unex.section_seat.enrollment_id%type,
        web_order_id in unex.section_seat.web_order_id%type) return pls_integer;
    --The EBS holds a seat for a real enrollment
    function hold_seat(
        sect_id in unex.section_seat.section_id%type,
        reservation_id out unex.section_seat.seat_reservation_id%type) RETURN pls_integer;
  --the web site is holding a seat for a web entrollment request
        function release_seat (
        sect_id   in unex.section_seat.section_id%type,
        enroll_id in unex.section_seat.enrollment_id%type) return pls_integer;
    --releases seats reserved by get_seat_post
    function release_seat (reservation_id in unex.section_seat.seat_reservation_id%type) return pls_integer;
    --the web site is releasing a seat
    function seat_reserved (
        s_id in unex.section_seat.section_id%type,
        row_id out rowid) RETURN boolean;
    --locks an available seat row, typucally from the web site   
    function seat_reserved (
        s_id in unex.section_seat.section_id%type,
        row_id out rowid,
        web_ord_id in unex.section_seat.web_order_id%type) RETURN boolean;
    --locks an available seat row, caller may be completing a web entrollment request
    function seat_held (
        enroll_id in unex.section_seat.enrollment_id%type,
        row_id in rowid,
        error_code out pls_integer) return boolean;
    --writes an enroll_id to a previously reserved seat row
    function seat_held (
        row_id in rowid,
        reservation_id out unex.section_seat.seat_reservation_id%type,
        error_code out pls_integer) return boolean;
    --for web orders, writes a rerveration_id to a previously reserved seat row
    --and returs the reservation_id to the caller
    procedure assign_web_seat(
    sect_id in unex.section_seat.section_id%type,
    web_ord_id in unex_web.web_enrollment.web_enrollment_id%type);
    --the old version of assigning a set to a web order
    procedure assign_seat_to_web_order(
        sect_id in unex.section_seat.section_id%type,
        reservation_id in unex.section_seat.seat_reservation_id%type,
        web_ord_id in unex_web.web_enrollment.web_enrollment_id%type);
    --writes a real web order id to a previously reserved seat
    function get_seats_available (sect_id in unex.section_seat.section_id%type) return pls_integer;
    function insert_into_section_seat (
        sect_id in unex.section_seat.section_id%type,
        max_enr in unex.section.maximum_enrollments%type) return pls_integer;
    function delete_from_section_seat (
        sect_id in unex.section_seat.section_id%type,
        max_enr in unex.section.maximum_enrollments%type) return pls_integer;
/**Releases seats reserved but not yet held by the web site - web customers have not completed their orders<br>
*within a pre-determined expiration time that dicates when the seats are returned to the free pool.<br>
*/
    procedure release_elapsed_seats;
    procedure release_web_order_seats (web_ord_id in unex_web.web_enrollment.web_enrollment_id%type);
end testcase_3440459;
/
