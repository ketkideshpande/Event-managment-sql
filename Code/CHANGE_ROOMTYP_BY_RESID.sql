--INPUT: Reservation ID, Room Type(Instead of actually passing reservation id customer name, street name, city name, state code, zip code, start and end dates are passed to be able to use find_reservation_id function)
--OUTPUT: Change Room Type Based on the availability between the specific date of the event 

create or replace procedure CHANGE_ROOMTYP_BY_RESID(
            I_CUSTOMER_NAME IN CUSTOMERS.CUSTOMER_NAME%TYPE,I_STREET_NAME IN hotel.street_name%type , I_CITY_NAME IN hotel.city_name%type,
        	I_STATE_CODE IN hotel.state_code%type, I_ZIP_CODE IN hotel.zip_code%type, I_START_DATE IN events.start_date%type,
            I_END_DATE IN events.end_date%type,i_room_type event_room1.room_type%type) is
v_reservation_id events.reservation_id%type;
v_start_date events.start_date%type; 
v_end_date events.start_date%type;
v_room_id1 event_room1.room_id1%type;
v_room_type1 event_room1.room_type%type;
v_room_id roomreservation.room_id%type;
v_room_type roomreservation.room_type%type;
v_booked_room_cnt number;
v_avail_room_cnt number;
v_cnt number := 1;
--Cursor to Fetch the available rooms during the event reservation date
cursor c1 is 
select room_id1,room_type from event_room1 where 
room_id1 not in(select room_id from roomreservation where Room_date>=v_start_date and room_date<=v_end_date) 
AND
hotel_id=(select events.hotel_id from events where events.reservation_id=v_reservation_id)
AND
upper(room_type)=upper(i_room_type);
--Cursor to fetch Rooms booked for given Reservation ID
cursor c2 is select room_id,room_type from roomreservation where reservation_id=v_reservation_id;
BEGIN
dbms_output.put_line('-- Change Event Room Type Based on Availability : Started--');
dbms_output.put_line('--Input--');
dbms_output.put_line('Customer name : '||I_CUSTOMER_NAME||' Street name : '|| I_STREET_NAME||' City name : '|| I_CITY_NAME||' State Code : '|| I_STATE_CODE||' Zip code : '||I_ZIP_CODE|| ' Start date: '||I_START_DATE||' End Date : '||I_END_DATE);
--Call FIND_RESERVATION_ID to fetch Reservation ID
v_reservation_id := FIND_RESERVATION_ID(I_CUSTOMER_NAME, I_STREET_NAME, I_CITY_NAME, I_STATE_CODE, I_ZIP_CODE, I_START_DATE, I_END_DATE);
--Given the Reservation ID returns Start date and End date of the Event
DATE_INTERVAL_BY_RESID(v_reservation_id,v_start_date,v_end_date);
--Display Number of Rooms Booked
select count(room_id) into v_booked_room_cnt from roomreservation 
where reservation_id=v_reservation_id ;
dbms_output.put_line('Number of rooms booked : '||v_booked_room_cnt);
--Display Number of Rooms Available
select count(room_id1) into v_avail_room_cnt from event_room1 where 
room_id1 not in(select room_id from roomreservation where Room_date>=v_start_date and room_date<=v_end_date) 
AND
hotel_id=(select events.hotel_id from events where events.reservation_id=v_reservation_id)
AND
upper(room_type)=upper(i_room_type);
dbms_output.put_line('Number of rooms available : '||v_avail_room_cnt);
    if v_booked_room_cnt=0 then
        dbms_output.put_line('Room is not booked for the given event ');
    elsif v_avail_room_cnt=0 then
        dbms_output.put_line('Bookings Full. Room is not available for Room Type : '||i_room_type);
    elsif v_booked_room_cnt>v_avail_room_cnt then
        dbms_output.put_line('Number of room booked is greater than available rooms count ');    
    else
    --For each booked room update the Room ID and Room Type if there is availability
        open c2;
            loop
            fetch c2 into v_room_id,v_room_type;
            exit when c2%notfound;
            dbms_output.put_line('Booked Room id : '||v_room_id||' Booked Room Type : '||v_room_type);
                open c1;
                    loop
                    fetch c1 into v_room_id1,v_room_type1;
                    exit when c1%notfound or v_cnt=2;  
                    dbms_output.put_line('Available Room id : '||v_room_id1||' Available Room Type : '||v_room_type1);
                    if(v_room_type1<>v_room_type) then
                    --Update the Room Id and Room Type
                    update roomreservation set room_id=v_room_id1,room_type= upper(i_room_type) 
                    where reservation_id=v_reservation_id and room_id=v_room_id;
                    dbms_output.put_line('Room id : '||v_room_id||' Updated into : '||v_room_id1);
                    else
                    dbms_output.put_line('Booked room type : '||v_room_type||' and '||' Available room type : '||v_room_type1||' are same. Thus, no change required');
                    end if;
                    v_cnt:=v_cnt+1;
                    end loop;
                v_cnt:=1;
                close c1;
            end loop;
        close c2;
    end if;
dbms_output.put_line('-- Change Event Room Type Based on Availability : Completed--');
exception
when no_data_found then
dbms_output.put_line('-- Change Event Room Type Based on Availability : Failed--');
dbms_output.put_line('Data not found');
when too_many_rows then
dbms_output.put_line('-- Change Event Room Type Based on Availbility : Failed--');
dbms_output.put_line('Too Many Rows returned');
raise;
when others then
raise;
end CHANGE_ROOMTYP_BY_RESID;
