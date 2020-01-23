--Generates Monthly Report of All hotels based on Event and Service


create or replace PROCEDURE MONTHLY_INC_REPORT IS
v_month varchar(20);
v_event_type events.event_type%type;
v_service_type varchar(50);
v_total number;
V_print_head number :=0;
--Cursor to display the Month and Income based on Event type and service type
cursor c1 is select to_Char(end_date,'Month') as MONTH , event_type,Service_type,
sum(
case when months>= 2 
then ((R_Cost)- (R_Cost/100)* 10)
else (R_Cost) 
end) as total_income
from
--Room Income of all hotels
((select events.reservation_id,hotel.hotel_name,reservation_date, start_date,
end_date, event_type, room.room_type as Service_type ,sum(room.room_price) as R_cost,
round(months_between(start_date,reservation_date),0)as months
from events, room,roomreservation,hotel
where events.reservation_id = roomreservation.reservation_id and roomreservation.hotel_id=hotel.hotel_id and events.EVENT_STATUS<>0 AND roomreservation.room_type=room.room_type
group by events.reservation_id,reservation_date, start_date,
end_date, event_type, room.room_type,hotel.hotel_name)

union all
--Service Income of all hotels
 (select events.reservation_id,hotel_name, reservation_date, start_date,
end_date, event_type, service.service_type, 
sum(
case when service_applicability='P'
then events.people_attending*service.service_rate 
else service.service_rate 
end) as S_cost,
round(months_between(start_date,reservation_date),0)as month
from events,service, hotel,servicereservation
where events.reservation_id = servicereservation.reservation_id 
and events.hotel_id = hotel.hotel_id and events.EVENT_STATUS<>0 AND  service.service_type=servicereservation.service_type
group by events.reservation_id,hotel_name, reservation_date, start_date,
end_date, event_type, service.service_type))

group by reservation_id,to_Char(end_date,'Month'),event_type,Service_type
order by to_Char(end_date,'Month'),event_type;
BEGIN
dbms_output.put_line('--Total Monthly Income Report--');
open c1;
loop
fetch c1 into v_month ,v_event_type ,v_service_type,v_total;
exit when c1%notfound;
if(V_print_head=0) then
dbms_output.put_line(LPAD('MONTH | ',15)||LPAD('EVENT TYPE | ',15)||LPAD('SERVICE TYPE | ',15)||LPAD('TOTAL | ',15));
dbms_output.put_line(LPAD(v_month,15)||LPAD(v_event_type,15)||LPAD(v_service_type,15)||LPAD(v_total,15));
V_print_head:=V_print_head+1;
else
dbms_output.put_line(LPAD(v_month,15)||LPAD(v_event_type,15)||LPAD(v_service_type,15)||LPAD(v_total,15));
V_print_head:=V_print_head+1;
end if;
end loop;
close c1;
exception
WHEN OTHERS THEN
dbms_output.put_line('--ERROR--');
dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
dbms_output.put_line('--Total Monthly Income Report : Failed--');
RAISE;
end MONTHLY_INC_REPORT;
