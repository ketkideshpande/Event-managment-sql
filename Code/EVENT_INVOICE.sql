--INPUT: Reservation ID (Instead of actually passing reservation id customer name, street name, city name, state code, zip code, start and end dates are passed to be able to use find_reservation_id function)
--OUTPUT1: Customer name
--OUTPUT2: Amount to be paid for booked rooms per day
--OUTPUT3: Amount to be paid for services per type and per day
--Output 4 & 5: Any Discounts Applied and Total Amount to be paid


create or replace procedure EVENT_INVOICE(I_CUSTOMER_NAME IN CUSTOMERS.CUSTOMER_NAME%TYPE,I_STREET_NAME IN hotel.street_name%type , I_CITY_NAME IN hotel.city_name%type,
        	I_STATE_CODE IN hotel.state_code%type, I_ZIP_CODE IN hotel.zip_code%type, I_START_DATE IN events.start_date%type,
            I_END_DATE IN events.end_date%type)
is
I_resrv_id events.reservation_id%type;
v_cust_name customers.customer_name%type;
begin
    dbms_output.put_line('--Event Invoice : Started--');
    --Call FIND_RESERVATION_ID to fetch Reservation ID
    I_resrv_id := FIND_RESERVATION_ID(I_CUSTOMER_NAME, I_STREET_NAME, I_CITY_NAME, I_STATE_CODE, I_ZIP_CODE, I_START_DATE, I_END_DATE);
    dbms_output.put_line('Input Reservation ID : '||I_resrv_id );
    --Function to fetch the Name of the customer
    v_cust_name:=CUST_NAME_BY_RESERV_ID(I_resrv_id);
    --Procedure to Display the Invoice of Room for given Event
    ROOMINCOME_PER_DAY(I_resrv_id);
    --Procedure to Display the Invoice of Service rendered for given Event
    SERVICEINCOME_PER_DATETYPE(I_resrv_id);
    --Procedure to Display the Total Amount with Discounts (if applicable) for given Event
    AMOUNT_DISC_BY_RESID(I_resrv_id);
    dbms_output.put_line('--Event Invoice : Completed--');
exception
    when others then
    dbms_output.put_line('--ERROR--');
    dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
    dbms_output.put_line('--Event Invoice : Failed--');
    raise;
end EVENT_INVOICE;
