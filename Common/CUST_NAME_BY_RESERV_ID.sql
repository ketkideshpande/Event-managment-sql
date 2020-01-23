create or replace function CUST_NAME_BY_RESERV_ID(I_resrv_id in events.reservation_id%type)
return customers.customer_name%type
is
V_Cust_name customers.customer_name%type;
begin
    dbms_output.put_line('--Customer Name By Reservation ID : Started--');
    --Validate the input reservation ID
    VALIDATE_RES_ID(I_resrv_id);
    dbms_output.put_line('Input Reservation ID : '||I_resrv_id );
    --Fetch Customer Name
    select customer_name into V_Cust_name 
    from customers,events 
    where events.customer_id=customers.customer_id and events.reservation_id=I_resrv_id;
    dbms_output.put_line('Customer Name : '||V_Cust_name );
    dbms_output.put_line('--Customer Name By Reservation ID : Completed--');
    return V_Cust_name;   
exception
    when no_data_found then
    dbms_output.put_line('--ERROR : Customer name not found--');
    dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
    dbms_output.put_line('--Customer Name By Reservation ID : Failed--');
    raise;
    return null;
    when too_many_rows then
    dbms_output.put_line('--ERROR : For given Reservation ID there are more than one customer name--');
    dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
    dbms_output.put_line('--Customer Name By Reservation ID : Failed--');
    raise;
    return null;
    when others then
    dbms_output.put_line('--ERROR--');
    dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
    dbms_output.put_line('--Customer Name By Reservation ID : Failed--');
    raise;
end CUST_NAME_BY_RESERV_ID;
