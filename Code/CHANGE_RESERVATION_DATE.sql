--input-Reservation ID, event Type(Instead of actually passing reservation id customer name, street name, city name, state code, zip code, start and end dates are passed to be able to use find_reservation_id function)
--output-events date will be changed specified by the customer 

create or replace PROCEDURE Change_Reservation_Date
(I_STREET_NAME IN VARCHAR,
I_CITY_NAME IN VARCHAR,
I_STATE_CODE IN VARCHAR,
I_ZIP_CODE IN VARCHAR,
I_START_DATE IN DATE,
I_END_DATE IN DATE,
I_CUSTOMER_NAME IN VARCHAR,
I_EVENT_TYPE IN VARCHAR)
is
RESVF int;
cid CUSTOMERS.CUSTOMER_ID%type;
HID EVENTS.HOTEL_ID%type;
RID EVENTS.RESERVATION_ID%TYPE;
BEGIN
dbms_output.Put_line('Entering procedure ChangeReservationDate..');
RESVF :=AVAILABLE_ROOM(I_STREET_NAME,I_CITY_NAME,I_STATE_CODE,I_ZIP_CODE,I_START_DATE,I_END_DATE,I_CUSTOMER_NAME,I_EVENT_TYPE);--variable to store the 
if RESVF = 0 then
HID:= FIND_A_HOTEL(I_STREET_NAME,I_CITY_NAME,I_STATE_CODE,I_ZIP_CODE);

select customer_id into cid from customers where CUSTOMER_NAME=I_CUSTOMER_NAME;
UPDATE EVENTS
SET start_date=I_START_DATE,
end_date =I_END_DATE
where CUSTOMER_ID = cid and hotel_Id=HID and event_type= I_event_type;
if SQL%FOUND then
dbms_output.Put_line('FOR THE GIVEN PERIOD,ROOM IS ALREADY AVAILABLE. UPDATED RESERVATION SUCCEESFULLY');
dbms_output.Put_line('Customer Name: '||I_CUSTOMER_name);
dbms_output.Put_line('Event Type: '||I_event_type);
dbms_output.Put_line('Hotel Address: '||I_STREET_NAME ||','||I_CITY_NAME||','||I_STATE_CODE||','||I_ZIP_CODE);
dbms_output.Put_line('New Start Date: '||I_START_DATE);
dbms_output.Put_line('New End Date: '||I_END_DATE);
else
dbms_output.Put_line('CUSTOMER HAS NOT REGISTERED ANY EVENT FOR THE MENTIONED HOTEL ADDRESS');
end if;
RID := FIND_RESERVATION_ID(I_CUSTOMER_NAME, I_STREET_NAME, I_CITY_NAME, I_STATE_CODE, I_ZIP_CODE, I_START_DATE, I_END_DATE);
DBMS_OUTPUT.PUT_LINE(RID);
UPDATE ROOMRESERVATION SET ROOM_DATE = I_START_DATE 
WHERE RESERVATION_ID = RID;
if SQL%FOUND then
dbms_output.Put_line('UPDATED ROOMRESERVATION SUCCEESFULLY');

else
dbms_output.Put_line('UPDATE FAILED');
end if;

else
dbms_output.Put_line('NO ROOMS AVAILABLE ...SORRY' );
end if;

EXCEPTION --exception handling
    WHEN NO_DATA_FOUND THEN 
    DBMS_OUTPUT.PUT_LINE('NO DATA IS SELECTED VARIABLE');
	WHEN others then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
	DBMS_OUTPUT.PUT_LINE('Invalid Hotel Id provided.');
	RAISE;


END Change_Reservation_Date;-----PROCEDURE ENDING
