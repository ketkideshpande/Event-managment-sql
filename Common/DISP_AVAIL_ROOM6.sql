create or replace PROCEDURE  DISP_AVAIL_ROOM6(I_CUSTOMER_NAME IN CUSTOMERS.CUSTOMER_NAME%TYPE,I_STREET_NAME IN hotel.street_name%type , I_CITY_NAME IN hotel.city_name%type,
        	I_STATE_CODE IN hotel.state_code%type, I_ZIP_CODE IN hotel.zip_code%type, I_START_DATE IN events.start_date%type,
            I_END_DATE IN events.end_date%type,i_room_type event_room1.room_type%type) AS
    v_reservation_id events.reservation_id%type;
    TEMP NUMBER;
    CURSOR avail_room IS 
		select count(room_id1) from event_room1 where 
    room_id1 not in(select room_id from roomreservation where Room_date>=I_START_DATE and room_date<=I_END_DATE) 
    AND
    hotel_id=(select events.hotel_id from events where events.reservation_id=v_reservation_id)
    AND
    upper(room_type)=upper(i_room_type);

BEGIN

    DBMS_OUTPUT.PUT_LINE('---SHOW AVAILABLE ROOMS STARTING---');
    v_reservation_id := FIND_RESERVATION_ID(I_CUSTOMER_NAME, I_STREET_NAME, I_CITY_NAME, I_STATE_CODE, I_ZIP_CODE, I_START_DATE, I_END_DATE);

    DBMS_OUTPUT.PUT_LINE('---Reservation ID :---'||v_reservation_id);

    OPEN avail_room;
    LOOP
    FETCH avail_room INTO TEMP;
    EXIT WHEN avail_room%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(' Available room Count '|| TEMP);
    END LOOP;
    CLOSE avail_room;

    DBMS_OUTPUT.PUT_LINE('---SHOW AVAILABLE ROOMS SUCCESSFUL---');

EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    DBMS_OUTPUT.PUT_LINE('-- SHOW AVAILABLE ROOMS - FAILED');
    RAISE;

END DISP_AVAIL_ROOM6 ;