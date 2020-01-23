create or replace FUNCTION AVAILABLE_ROOM 
(I_STREET_NAME IN VARCHAR,
I_CITY_NAME IN VARCHAR,
I_STATE_CODE IN VARCHAR,
I_ZIP_CODE IN VARCHAR,
I_START_DATE IN DATE,
I_END_DATE IN DATE,
I_CUSTOMER_NAME IN VARCHAR,
I_EVENT_TYPE IN VARCHAR)
RETURN NUMBER --datatype of the variable that is returned
IS
RESID EVENTS.RESERVATION_ID%TYPE; 
CID EVENTS.CUSTOMER_ID%type;
HID EVENTS.HOTEL_ID%type;
BEGIN

---call function to get the hotel id
HID := FIND_A_HOTEL(I_STREET_NAME,I_CITY_NAME,I_STATE_CODE,I_ZIP_CODE);
DBMS_OUTPUT.PUT_LINE('HOTEL ID'|| HID);
select CUSTOMER_ID into CID from CUSTOMERS where CUSTOMER_NAME=I_CUSTOMER_NAME;
select count(*) into RESID from EVENTS where HOTEL_ID=HID and 
START_DATE=I_START_DATE and END_DATE=I_END_DATE and EVENT_TYPE= I_EVENT_TYPE and CUSTOMER_ID = CID ;
return RESID;
exception
	when no_data_found then
	dbms_output.put_line('No Dates Available to register for an event');
	return -1; -- returns -1 when there is exception
END AVAILABLE_ROOM;

