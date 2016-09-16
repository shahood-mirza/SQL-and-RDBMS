-- PL/SQL Queries
-- Shahood Mirza

ACCEPT p_serial PROMPT 'ENTER CAR SERAIL: '
VARIABLE g_output VARCHAR2(200)
DECLARE
   v_make         s7.car.make%TYPE;
   v_model        s7.car.model%TYPE;
   v_cyear        s7.car.cyear%TYPE;
   v_color        s7.car.color%TYPE;
   v_enginetype   s7.car.enginetype%TYPE;
BEGIN
   SELECT make, model, cyear, color, enginetype
      INTO v_make, v_model, v_cyear, v_color, v_enginetype 
      FROM s7.car
         WHERE serial = UPPER('&p_serial');
   :g_output := '&p_serial' || ' ' || v_make || ' ' || v_model || ' ' || v_cyear;
   :g_output := :g_output || ' ' || v_color || ' ' || v_enginetype;
END;
/
PRINT g_output

---------------------OUTPUT---------------------------

ENTER CAR SERAIL: ACU45TSX
old  11:          WHERE serial = UPPER('&p_serial');
new  11:          WHERE serial = UPPER('ACU45TSX');
old  12:    :g_output := '&p_serial' || ' ' || v_make || ' ' || v_model || ' ' || v_cyear;
new  12:    :g_output := 'ACU45TSX' || ' ' || v_make || ' ' || v_model || ' ' || v_cyear;

PL/SQL procedure successfully completed.

more...

G_OUTPUT
---------------------------------------------------------------------------
ACU45TSX ACURA      TSX      2010 Gold         v7
