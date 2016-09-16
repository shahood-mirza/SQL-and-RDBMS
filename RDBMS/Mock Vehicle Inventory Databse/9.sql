-- Create Customer View
-- Shahood Mirza
-- 9.sql

ACCEPT p_cname       PROMPT 'Please enter customer name: '
ACCEPT p_cstreet     PROMPT 'Please enter street: '
ACCEPT p_ccity       PROMPT 'Please enter city: '
ACCEPT p_cprov       PROMPT 'Please enter province '
ACCEPT p_cpostal      PROMPT 'Please enter postal code: '
ACCEPT p_chphone     PROMPT 'Please enter home phone number: '
ACCEPT p_cbphone     PROMPT 'Please enter business phone number: '


VARIABLE g_output VARCHAR2(4000)

DECLARE
   v_DATA NUMBER(4);
   v_check NUMBER(4);
   v_datacheck EXCEPTION;

BEGIN
   
   SELECT COUNT(*)
   INTO v_DATA  
   FROM customer
   WHERE cname = '&p_cname';

   
   IF v_check != 0 THEN
      RAISE v_datacheck;
   ELSE
     
      INSERT INTO customer (cname,ccity,cprov,cpostal,chphone,cbphone)
      VALUES ('&p_cname','&p_ccity','&p_cprov','&p_cpostal','&p_chphone','&p_cbphone')
      COMMIT work;
      
   END IF;

EXCEPTION
   WHEN v_datacheck THEN
      ROLLBACK work;
      
      :g_output := 'Data already exists';
   
   WHEN OTHERS THEN
      ROLLBACK WORK;
      
      :g_output := 'Error occurred'||CHR(10);
      :g_output := :g_output||'Error code: '||SQLCODE||CHR(10);
      :g_output := :g_output||'Error message: '||SQLERRM;
END;
/
PRINT g_output
