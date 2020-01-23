create or replace procedure date_interval_by_resid(
i_reservation_id in events.reservation_id%type,o_resrv_s_date out events.start_date%type,o_resrv_e_date out events.end_date%type) as

begin
dbms_output.put_line('-- Event Reservation Date : Started--');
dbms_output.put_line('Reservation id : '||i_reservation_id);
validate_res_id(i_reservation_id);
select start_date,end_date into o_resrv_s_date,o_resrv_e_date from events where reservation_id=i_reservation_id;
dbms_output.put_line('Start Date of the Event : '||o_resrv_s_date);
dbms_output.put_line('End Date of the Event : '||o_resrv_e_date);
dbms_output.put_line('-- Event Reservation Date : Completed--');
exception
when no_data_found then
dbms_output.put_line('-- Event Reservation Date : Failed--');
dbms_output.put_line('Event dates not found');
when too_many_rows then
dbms_output.put_line('-- Event Reservation Date : Failed--');
dbms_output.put_line('Too Many Rows returned');
raise;
when others then
raise;
end date_interval_by_resid;
