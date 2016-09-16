-- Delete Prospect Entry
-- Shahood Mirza
-- 12.sql

ACCEPT p_cname PROMPT 'Enter Customer Name: '
ACCEPT p_make  PROMPT 'Enter Prospect Car Make: '
ACCEPT p_model PROMPT 'Enter Prospect Car Model: '
ACCEPT p_cyear PROMPT 'Enter Prospect Car Year: '
ACCEPT p_color PROMPT 'Enter Prospect Car Colour: '
ACCEPT p_trim  PROMPT 'Enter Prospect Car Trim: '
ACCEPT p_ocode PROMPT 'Enter Prospect Car Option Code: '
VARIABLE g_output VARCHAR2(100)

BEGIN
   DELETE FROM prospect
      WHERE cname = '&p_cname'
      AND   make  = UPPER('&p_make')
      AND   model = UPPER('&p_model')
      AND   cyear = '&p_cyear'
      AND   color = '&p_color'
      AND   trim  = '&p_trim'
      AND   ocode = UPPER('&p_ocode');

   COMMIT;

   EXCEPTION
      WHEN VALUE_ERROR THEN
         :g_output := 'Invalid Data Entry';
END;
/
PRINT g_output

ACCEPT p_return PROMPT 'Press ENTER to continue...'
@menu