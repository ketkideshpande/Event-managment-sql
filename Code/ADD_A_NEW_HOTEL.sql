create or replace procedure add_a_new_hotel(i_hotel_name varchar,i_hotel_phone varchar,i_street_name varchar,i_city_name varchar,
i_state_code varchar,i_zip_code varchar)
is
begin
    DBMS_OUTPUT.PUT_LINE('-- ADD A NEW HOTEL ');
    DBMS_OUTPUT.PUT_LINE('HOTEL_NAME : ' || I_hotel_name);

IF I_hotel_name IS NULL
    THEN
        RAISE_APPLICATION_ERROR(-20010, 'INVALID HOTEL NAME : CANNOT BE NULL');
    END IF;

    IF I_HOTEL_PHONE IS NULL
    THEN
        RAISE_APPLICATION_ERROR(-20020, 'INVALID HOTEL PHONE NUMBER: CANNOT BE NULL');
    END IF;
    
    IF I_STATE_CODE IS NULL
    THEN
        RAISE_APPLICATION_ERROR(-20030, 'STATE_CODE : CANNOT BE NULL');
    END IF;
    
   insert into hotel values (
   hotel_seq.nextval,
   UPPER(i_hotel_name),
   i_hotel_phone,
   UPPER(i_street_name),
   UPPER(i_city_name),
   UPPER(i_state_code),
   UPPER(i_zip_code));
   
   DBMS_OUTPUT.PUT_LINE('-- INSERT SUCCESSFUL ');
   DBMS_OUTPUT.PUT_LINE('-- ADD A NEW HOTEL COMPLETED SUCCESSFULLY ');
  
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE('-- ADD A NEW HOTEL - FAILED');
        RAISE;
end ADD_A_NEW_HOTEL;