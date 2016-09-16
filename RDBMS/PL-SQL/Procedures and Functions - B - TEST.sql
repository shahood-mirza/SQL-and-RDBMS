-- PL/SQL Procedures & Functions
-- Shahood Mirza

ACCEPT p_serial PROMPT "Enter a serial #: "
set heading off
set termout off
VATIABLE g_output VARCHAR2(2000)
DECLARE
   v_make   car.make%TYPE;
   v_model  car.model%TYPE;
BEGIN
   SELECT make, model
      INTO v_make, v_model
      FROM car
         WHERE serial = '&p_serial';
   :g_output := v_make || ' ' || v_model || ' ' || '&p_serial';
   :g_output := :g_output || CHR(10) || 'Number of Options: ' || OPTIONCOUNT('&p_serial');
END;
/
set termout on
PRINT g_output
set heading on

---------------------OUTPUT---------------------------

Enter a serial #: A12BTSX5
more...

ACURA        TSX    A12BTSX5
Number of Options: 2


Input truncated to 14 characters
