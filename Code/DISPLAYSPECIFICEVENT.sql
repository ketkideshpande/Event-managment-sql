--INPUT: Event Type
--OUTPUT: All Events in all hotels along with address and date of the event

create or replace procedure DISPLAYSPECIFICEVENT(I_Event_type in varchar)as
V_event_name events.event_name%type;
V_start_date events.start_date%type;
V_end_date events.end_date%type;
V_hotel_name hotel.hotel_name%type;
V_hotel_address varchar(250);
v_cnt number:=1;
--Fetches the address and date of the event
cursor curs1 (c_EventType_in Events.Event_type%type)is 
select event_name,start_date,end_date,hotel_name,street_name||','||city_name||','||state_code||','||Zip_code as HotelAddress 
from events,hotel where events.hotel_id=hotel.hotel_id and lower(events.event_type)=lower(c_EventType_in);
begin
dbms_output.put_line('--Display Specifc Event : Started--');
--Check whether input is empty
if I_Event_type is null then
dbms_output.put_line('Input Event Type : NULL');
raise_application_error(-20010,'INVALID : Event Type cannot be null');
else
dbms_output.put_line('Input Event Type : '||I_Event_type);
end if;
open curs1(I_Event_type);   
loop
fetch curs1 into V_event_name,V_start_date,V_end_date,V_hotel_name,V_hotel_address;
if curs1%notfound and V_event_name is null then
dbms_output.put_line('No events for given event type exists');
end if;
exit when curs1%notfound;
if(v_cnt=1)then
dbms_output.put_line(LPAD('Event name | ',25)||LPAD('Hotel Name | ',15)||LPAD('Hotel Address | ',30)||LPAD('Start Date | ',15)||LPAD('End Date | ',15));
dbms_output.put_line(LPAD(V_event_name,25)||LPAD(V_hotel_name,15)||LPAD(V_hotel_address,30)||LPAD(V_start_date,15)||LPAD(V_end_date,15));
v_cnt:=v_cnt+1;
else
dbms_output.put_line(LPAD(V_event_name,25)||LPAD(V_hotel_name,15)||LPAD(V_hotel_address,30)||LPAD(V_start_date,15)||LPAD(V_end_date,15));
v_cnt:=v_cnt+1;
end if;
end loop;
close curs1;
dbms_output.put_line('--Display Specifc Event : Completed--');
exception
when others then
dbms_output.put_line('--ERROR--');
dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
dbms_output.put_line('--Display Specifc Event : Failed--');
raise;
end DISPLAYSPECIFICEVENT;
