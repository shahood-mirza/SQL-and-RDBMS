-- PL/SQL Exceptions & Cursors
-- Shahood Mirza

ACCEPT p_make PROMPT 'Enter make: '
ACCEPT p_model PROMPT 'Enter model: '
VARIABLE g_output VARCHAR2(200)
DECLARE
   v_count  NUMBER(3);
   v_avg    NUMBER(6);
   v_toofew EXCEPTION;
BEGIN
SELECT COUNT(servinv), AVG(s.totalcost) 
   INTO v_count, v_avg
   FROM s7.servinv s, s7.car c
      WHERE s.serial = c.serial
      AND c.make = UPPER('&p_make')
      AND c.model = UPPER('&p_model');
   IF v_count < 3 THEN
      RAISE v_toofew;
   END IF;
   :g_output := 'Times &p_make &p_model in for service: '|| v_count || CHR(10)
   ||'Average cost of service: $' || v_avg;
EXCEPTION
   WHEN v_toofew THEN
      :g_output := 'Number of times &p_make &p_model in for service: '|| v_count;
END;
/
PRINT g_output

---------------------OUTPUT 1---------------------------

Enter make: ACURA
Enter model: TSX
old  10:       AND c.make = UPPER('&p_make')
new  10:       AND c.make = UPPER('acura')
old  11:       AND c.model = UPPER('&p_model');
new  11:       AND c.model = UPPER('tsx');
old  15:    :g_output := 'Times &p_make &p_model in for service: '|| v_count || CHR(10)
new  15:    :g_output := 'Times acura tsx in for service: '|| v_count || CHR(10)
old  19:       :g_output := 'Number of times &p_make in for service: '|| v_count;
new  19:       :g_output := 'Number of times acura in for service: '|| v_count;

PL/SQL procedure successfully completed.

Input truncated to 14 characters
more...

G_OUTPUT
-----------------------------------
Times ACURA TSX in for service: 23
Average cost of service: $2884

---------------------OUTPUT 2---------------------------

Enter make: ACURA
Enter model: XFX
old  10:       AND c.make = UPPER('&p_make')
new  10:       AND c.make = UPPER('acura')
old  11:       AND c.model = UPPER('&p_model');
new  11:       AND c.model = UPPER('Xfx');
old  15:    :g_output := 'Times &p_make &p_model in for service: '|| v_count || CHR(10)
new  15:    :g_output := 'Times acura Xfx in for service: '|| v_count || CHR(10)
old  19:       :g_output := 'Number of times &p_make in for service: '|| v_count;
new  19:       :g_output := 'Number of times acura in for service: '|| v_count;

PL/SQL procedure successfully completed.

Input truncated to 14 characters
more...

G_OUTPUT
---------------------------------------
Number of times ACURA XFX in for service: 1