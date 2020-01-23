create or replace procedure display_hotel_info(i_hotel_id in int) as
v_hotel_id int;
V_hotel_name hotel.hotel_name%type;
V_hotel_phone hotel.hotel_phone%type;
V_street_name hotel.street_name%type;
V_city_name hotel.city_name%type;
V_state_code hotel.state_code%type;
V_zip_code hotel.zip_code%type;


begin 
    DBMS_OUTPUT.PUT_LINE('-- DISPLAY_HOTEL_INFO');
    DBMS_OUTPUT.PUT_LINE('Given Hotel ID is: '||i_hotel_id);

    if i_hotel_id is null
    then 
    dbms_output.put_line('Hotel ID cannot be null!');
    end if;

    BEGIN
    select hotel_id into v_hotel_id
    from hotel
    where hotel_id=i_hotel_id;

    exception
        when no_data_found then
        dbms_output.put_line('Hotel_id '||i_hotel_id||' not found');

    end;
    SELECT HOTEL_NAME,HOTEL_PHONE,STREET_NAME,CITY_NAME,STATE_CODE,ZIP_CODE 
    INTO V_HOTEL_NAME,V_HOTEL_PHONE,V_STREET_NAME,V_CITY_NAME,V_STATE_CODE,V_ZIP_CODE
    FROM HOTEL
    WHERE HOTEL_ID = I_HOTEL_ID;

    DBMS_OUTPUT.PUT_LINE('INFORMATION ON ' || V_HOTEL_NAME);
    DBMS_OUTPUT.PUT_LINE('HOTEL ID:' || I_HOTEL_ID);
    DBMS_OUTPUT.PUT_LINE('ADDRESS: ' || V_STREET_NAME || ',' || V_CITY_NAME || ',' || V_STATE_CODE || '-' || V_ZIP_CODE);
    DBMS_OUTPUT.PUT_LINE('PHONE: ' || V_HOTEL_PHONE);
    
    DBMS_OUTPUT.PUT_LINE('-- DISPLAY_HOTEL_INFO SUCCESSFUL');

exception

    when no_data_found then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    dbms_output.put_line('-- NO SUCH HOTEL PRESENT');
    RAISE;
    when too_many_rows then
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    dbms_output.put_line('too many rows');
    RAISE;
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    DBMS_OUTPUT.PUT_LINE('-- FIND_HOTEL_ID - FAILED');
    RAISE;
end;
