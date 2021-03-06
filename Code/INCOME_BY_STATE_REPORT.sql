create or replace PROCEDURE INCOME_BY_STATE_REPORT(I_STATE_CODE IN VARCHAR) AS
    CURSOR FIND_RES_ID(C_STATE_CODE IN VARCHAR) IS
    SELECT E.RESERVATION_ID FROM EVENTS E, HOTEL H
    WHERE E.HOTEL_ID = H.HOTEL_ID 
    AND H.STATE_CODE = C_STATE_CODE; 
    
    V_RESERVATION_ID EVENTS.RESERVATION_ID%TYPE;
    V_ROOM_COST NUMBER;
    V_SERVICE_COST NUMBER;
    V_DISCOUNT NUMBER(10,2);
    V_TOTAL_COST NUMBER(10,2);
    V_GRAND_TOTAL NUMBER(10,2) := 0;
    
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('-- INCOME_BY_STATE_REPORT');
    IF I_STATE_CODE IS NULL
    THEN
        RAISE_APPLICATION_ERROR(-20031, 'INVALID STATE CODE : CANNOT BE NULL');
    END IF;
    
    OPEN FIND_RES_ID(I_STATE_CODE);
    LOOP
        FETCH FIND_RES_ID INTO V_RESERVATION_ID;
            EXIT WHEN FIND_RES_ID%NOTFOUND;
            
            V_ROOM_COST := ROOM_INCOME_BY_RESID(V_RESERVATION_ID);
            V_SERVICE_COST := SERVICE_INCOME_BY_RESID(V_RESERVATION_ID);
            
            V_DISCOUNT := APPLY_DISCOUNT(V_RESERVATION_ID, V_ROOM_COST + V_SERVICE_COST);
                        
            V_TOTAL_COST := V_ROOM_COST + V_SERVICE_COST - V_DISCOUNT;
            V_GRAND_TOTAL := V_GRAND_TOTAL + V_TOTAL_COST;            
            
            DBMS_OUTPUT.PUT_LINE('THE TOTAL INCOME FROM EVENT ID: ' || V_RESERVATION_ID 
                                || ' IS: ' || V_TOTAL_COST);
            DBMS_OUTPUT.PUT_LINE('INCOME FROM ROOMS: ' || V_ROOM_COST);
            DBMS_OUTPUT.PUT_LINE('INCOME FROM SERVICES: ' || V_SERVICE_COST);
            DBMS_OUTPUT.PUT_LINE('DISCOUNT  : ' ||  V_DISCOUNT);
            DBMS_OUTPUT.PUT_LINE('TOTAL COST : ' || V_TOTAL_COST);
            
    END LOOP;
    CLOSE FIND_RES_ID;
    DBMS_OUTPUT.PUT_LINE('THE TOTAL INCOME FROM ALL THE EVENTS IN THE STATE: ' || I_STATE_CODE 
                        || ' IS: ' || V_GRAND_TOTAL);
    DBMS_OUTPUT.PUT_LINE('-- INCOME_BY_STATE_REPORT SUCCESSFUL');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        DBMS_OUTPUT.PUT_LINE('-- INCOME_BY_STATE_REPORT - FAILED');
        RAISE;
        
END INCOME_BY_STATE_REPORT;