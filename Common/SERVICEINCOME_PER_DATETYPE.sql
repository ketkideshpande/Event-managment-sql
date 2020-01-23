create or replace procedure SERVICEINCOME_PER_DATETYPE(I_resrv_id in events.reservation_id%type)
is
V_serv_date servicereservation.service_date%type;
V_serv_type servicereservation.service_type%type;
V_cost_per_service number;
V_print_head number :=0;
--Fetch Amount base on date and type of service rendered
cursor c1 is select
    sc.service_date,sc.service_type, 
    sum(CASE
    WHEN s.service_applicability = 'P'
    THEN e.people_attending * s.service_rate
    ELSE s.service_rate
    END) SERVICE_COST 
    from servicereservation sc,service s,events e
    where sc.reservation_id=I_resrv_id and e.reservation_id=I_resrv_id and s.service_type=sc.service_type group by sc.service_date,sc.service_type order by sc.service_date;
begin
    dbms_output.put_line('--Services rendered given the Reservation ID : Started--');
    --Validate the input
    VALIDATE_RES_ID(I_resrv_id);
    dbms_output.put_line('Input Reservation ID : '||I_resrv_id );
    open c1;
    loop 
    fetch c1 into v_serv_date,v_serv_type,v_cost_per_service;
    if c1%notfound and v_serv_date is null then
    dbms_output.put_line('No services is found for given reservation id');
    end if;
    exit when c1%notfound;
    if(V_print_head=0) then
    dbms_output.put_line(LPAD('Service Date | ',15)||LPAD('Service Type | ',15)||LPAD('Cost Per Service | ',15));
    dbms_output.put_line(LPAD(v_serv_date,15)||LPAD(v_serv_type,15)||LPAD(v_cost_per_service,15));
    V_print_head:=V_print_head+1;
    else
    dbms_output.put_line(LPAD(v_serv_date,15)||LPAD(v_serv_type,15)||LPAD(v_cost_per_service,15));
    V_print_head:=V_print_head+1;
    end if;
    end loop;
    close c1;
    dbms_output.put_line('--Services rendered given the Reservation ID : Completed--');
exception
    when others then
    dbms_output.put_line('--ERROR--');
    dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
    dbms_output.put_line('--Services rendered given the Reservation ID : Failed--');
    raise;
end SERVICEINCOME_PER_DATETYPE;

