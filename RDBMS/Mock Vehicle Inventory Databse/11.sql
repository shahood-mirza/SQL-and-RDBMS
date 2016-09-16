-- Create Prospect Entry
-- Shahood Mirza
-- 11.sql

ACCEPT p_cname PROMPT 'Enter Customer Name: '
ACCEPT p_make  PROMPT 'Enter Prospect Car Make: '
ACCEPT p_model PROMPT 'Enter Prospect Car Model: '
ACCEPT p_cyear PROMPT 'Enter Prospect Car Year: '
ACCEPT p_color PROMPT 'Enter Prospect Car Colour: '
ACCEPT p_trim  PROMPT 'Enter Prospect Car Trim: '
ACCEPT p_ocode PROMPT 'Enter Prospect Car Option Code: '
VARIABLE g_output VARCHAR2(100)

DECLARE
   v_cyear NUMBER(4);
   v_invalidcyear EXCEPTION;

BEGIN
   INSERT INTO prospect (cname, make, model, cyear, color, trim, ocode)
   VALUES ('&p_cname', UPPER('&p_make'), UPPER('&p_model'), '&p_cyear', '&p_color', '&p_trim', UPPER('&p_ocode'));

   SELECT cyear
      INTO v_cyear
      FROM prospect
         WHERE cyear = '&p_cyear';
   
   IF (v_cyear < 1900) THEN
      RAISE v_invalidcyear;
   END IF;
   
   IF (v_cyear > 2013) THEN
      RAISE v_invalidcyear;
   END IF;
   
   COMMIT;

   EXCEPTION
      WHEN v_invalidcyear THEN
         ROLLBACK;
         :g_output := 'Invalid Vehicle Year';
END;
/
PRINT g_output

ACCEPT p_return PROMPT 'Press ENTER to continue...'
@menu