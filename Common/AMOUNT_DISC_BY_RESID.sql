create or replace procedure AMOUNT_DISC_BY_RESID(I_RESERVATION_ID EVENTS.RESERVATION_ID%TYPE)
is
V_total_cost number;
V_room_cost number;
V_service_cost number;
v_discount number;
BEGIN
dbms_output.put_line('-- Display Discount : Started--');
--Validate Input Reservation ID
VALIDATE_RES_ID(I_RESERVATION_ID);
--Fetch Room Cost
V_room_cost:=ROOM_INCOME_BY_RESID(I_RESERVATION_ID);
--Fetch cost of services utilized
V_service_cost:=SERVICE_INCOME_BY_RESID(I_RESERVATION_ID);
--Calculate the total cost
V_total_cost:=V_room_cost+V_service_cost;
dbms_output.put_line('Total Amount for the event : '||V_total_cost);
--Call function to return discount Amount if applicable
v_discount:=APPLY_DISCOUNT(I_RESERVATION_ID,V_total_cost);
if v_discount=V_total_cost then
dbms_output.put_line('No Discounts Applied');
dbms_output.put_line('Total Amount for the event : '||V_total_cost);
else
dbms_output.put_line('Discount Applied : '||v_discount);
--Calculate the total cost
V_total_cost:=V_total_cost-v_discount;
dbms_output.put_line('Total Amount for the event : '||V_total_cost);
end if;
EXCEPTION
WHEN OTHERS
THEN RAISE;
END AMOUNT_DISC_BY_RESID;
