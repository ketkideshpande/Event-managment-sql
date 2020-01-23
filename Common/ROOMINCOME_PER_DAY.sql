create or replace procedure ROOMINCOME_PER_DAY(I_resrv_id in events.reservation_id%type)
is
V_room_id ROOMRESERVATION.room_id%type;
V_cost_per_room number;
V_print_head number :=0;
--Fetch Room ID and Rate per day
cursor c1 is SELECT rr.room_id,SUM(R.ROOM_PRICE) 
FROM ROOMRESERVATION RR, EVENTS E, ROOM R
WHERE RR.RESERVATION_ID = E.RESERVATION_ID
AND RR.ROOM_TYPE = R.ROOM_TYPE
AND E.RESERVATION_ID = I_resrv_id
GROUP BY RR.RESERVATION_ID,RR.room_date,rr.room_id;
begin
    dbms_output.put_line('--Event Room Price given the Reservation ID : Started--');
    VALIDATE_RES_ID(I_resrv_id);
    dbms_output.put_line('Input Reservation ID : '||I_resrv_id );
    open c1;
    loop
    fetch c1 into v_room_id,v_cost_per_room;
    exit when c1%notfound;
    if(V_print_head=0) then
    dbms_output.put_line(LPAD('Room id | ',15)||LPAD('Cost per Room | ',15));
    dbms_output.put_line(LPAD(v_room_id,15)||LPAD(v_cost_per_room,15));
    V_print_head:=V_print_head+1;
    else
    dbms_output.put_line(LPAD(v_room_id,15)||LPAD(v_cost_per_room,15));
    V_print_head:=V_print_head+1;
    end if;
    end loop;
    close c1;
    dbms_output.put_line('--Event Room Price given the Reservation ID : Completed--');
exception
    when others then
    dbms_output.put_line('--ERROR--');
    dbms_output.put_line('--CHECK THE ERROR REPORT FOR MORE DETAILS--');
    dbms_output.put_line('--Event Room Price given the Reservation ID : Failed--');
    raise;
end ROOMINCOME_PER_DAY;
