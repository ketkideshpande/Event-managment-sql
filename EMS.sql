@DDL.sql
-- Compile Common Procedures/Functions
@Common/FIND_A_HOTEL.sql
@Common/VALIDATE_RES_ID.sql
@Common/SHOW_AVAILABLE_ROOMS.sql
@Common/INSERT_RES.sql
@Common/AVAILABLE_ROOM.sql
@Common/DATE_INTERVAL_BY_RESID.sql
@Common/CUST_NAME_BY_RESERV_ID.sql
@Common/ROOMINCOME_PER_DAY.sql
@Common/SERVICEINCOME_PER_DATETYPE.sql
@Common/AMOUNT_DISC_BY_RESID.sql
@Common/SERVICE_INCOME_BY_RESID.sql
@Common/ROOM_INCOME_BY_RESID.sql
@Common/APPLY_DISCOUNT.sql
@Common/DISP_AVAIL_ROOM6.sql
-- Compile Member 1 Procedures/Functions
@Member-1/ADD_A_NEW_HOTEL.sql -- Feature - 1
@Member-1/FIND_HOTEL_ID.sql -- Feature - 2
@Member-1/DISPLAY_HOTEL_INFO.sql -- Feature - 3
@Member-1/ADD_EVENT_ROOM.sql -- Feature - 4
@Member-1/REPORT_HOTEL_N_ROOM_STATE.sql -- Feature - 5
@Member-1/SHOW_ROOM.sql -- Feature - 6
-- Compile Member 2 Procedures/Functions
@Member-2/MAKE_EVENT_RESERVATION.sql -- Feature - 7
@Member-2/FIND_RESERVATION_ID.sql -- Feature - 8
@Member-2/CANCEL_EVENT.sql -- Feature - 9
@Member-2/SHOW_CANCELATION.sql -- Feature - 10
@Member-2/CHANGE_RESERVATION_DATE.sql -- Feature - 11
-- Compile Member 3 Procedures/Functions
@Member-3/CHANGE_ROOMTYP_BY_RESID.sql -- Feature - 12
@Member-3/DISPLAYSPECIFICEVENT.sql -- Feature - 13
@Member-3/SHOW_EVENTS_BYCUSTNAME.sql -- Feature - 14
@Member-3/MONTHLY_INC_REPORT.sql -- Feature - 15
@Member-3/EVENT_INVOICE.sql -- Feature - 16
-- Compile Member 4 Procedures/Functions
@Member-4/ADD_SERVICE_TO_EVENT.sql -- Feature - 17
@Member-4/RESERVATION_SERVICES_REPORT.sql -- Feature - 18
@Member-4/SHOW_SPECIFIC_SERVICE_REPORT.sql -- Feature - 19
@Member-4/SERVICES_INCOME_REPORT.sql -- Feature - 20
@Member-4/INCOME_BY_STATE_REPORT.sql -- Feature - 21