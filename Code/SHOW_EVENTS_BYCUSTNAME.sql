--INPUT: Customer Name 
--OUTPUT: Events booked by the Customer

create or replace PROCEDURE SHOW_EVENTS_BYCUSTNAME(I_Customer_name in varchar) AS
v_event_name events.event_name%type;
v_res_id events.reservation_id%type;
v_cnt number :=1;
--Cursor to fetch EventName booked by a customer
cursor curs1 is
select event_name , reservation_id from events,customers
where events.customer_id=customers.customer_id and customers.customer_id in
(select customer_id from customers where lower(customer_name)=lower(I_Customer_name));
begin
dbms_output.put_line('--Events under a customer : Started--');
--Input Customer Name is Empty
if I_Customer_name is null
then
dbms_output.put_line('Input Customer Name : NULL');
raise_application_error(-20010,'INVALID : Customer Name cannot be null');
else
dbms_output.put_line('Input Customer Name : '||I_Customer_name);
end if;
open curs1;
loop
fetch curs1 into V_event_name, v_res_id;
if curs1%notfound and V_event_name is null then
dbms_output.put_line('No events under the given name');
end if;
exit when curs1%notfound;
if v_cnt=1 then
dbms_output.put_line(LPAD('Event name',25) || LPAD('Reservation Id',30));
dbms_output.put_line(LPAD(V_event_name,30) || LPAD(v_res_id,30));
v_cnt:=v_cnt+1;
else
dbms_output.put_line(LPAD(V_event_name,30) || LPAD(V_res_id,30) );
v_cnt:=v_cnt+1;
end if;
end loop;
close curs1;
dbms_output.put_line('--Events under a customer : Completed--');
exception
when others then
dbms_output.put_line('--ERROR--');
dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
dbms_output.put_line('--Display Specifc Event : Failed--');
raise;
END SHOW_EVENTS_BYCUSTNAME;
