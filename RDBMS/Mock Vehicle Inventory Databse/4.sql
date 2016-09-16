-- Inquire Vehicle Inventory Record
-- Shahood Mirza
-- 4.sql

ACCEPT p_serial PROMPT 'Please enter serial #: '
ACCEPT p_ocode  PROMPT 'Please enter option code: '
VARIABLE g_output VARCHAR2(4000)

DECLARE
   v_DATA NUMBER(4);
   v_checkdata NUMBER(4);
   v_ocode options.ocode%TYPE;
   v_odesc options.odesc%TYPE;
   v_olist options.olist%TYPE;
   v_nodataExists  EXCEPTION;
   CURSOR seriallist IS
   SELECT *
   FROM car
   WHERE serial = '&p_serial';

BEGIN
   SELECT COUNT(*)
   INTO v_DATA  
   FROM car
   WHERE serial = '&p_serial';

   SELECT o.ocode,odesc,olist
   INTO v_ocode,v_odesc,v_olist
   FROM options o,baseoption b
   WHERE o.ocode = b.ocode
   AND serial = '&p_serial';

   IF v_checkdata = '0' THEN
  
      RAISE v_nodataExists;
   ELSE
  
      FOR v_serial IN seriallist LOOP
	 :g_output := :g_output|| lpad('Vehicle Inventory Record',60)|| CHR(10);    
	 :g_output := :g_output||'Serial'|| CHR(9)||'  '|| CHR(9)||'Make'|| CHR(9)||'Model'|| CHR(10);
	 :g_output := :g_output||TRIM(v_serial.serial)|| CHR(9);
         :g_output := :g_output||TRIM(v_serial.make)||' ';
         :g_output := :g_output||TRIM(v_serial.model)||' ';
         :g_output := :g_output||TRIM(v_serial.cyear)||' ';
         :g_output := :g_output||TRIM(v_serial.color)||' ';
         :g_output := :g_output||TRIM(v_serial.trim)||' ';
         :g_output := :g_output||TRIM(v_serial.purchfrom)||' ';
         :g_output := :g_output||TRIM(v_serial.purchinv)||' ';
         :g_output := :g_output||TRIM(v_serial.purchdate)||' ';
         :g_output := :g_output||TO_CHAR(v_serial.purchcost,'9999.99')||' ';
         :g_output := :g_output||TO_CHAR(v_serial.listprice,'999999.99')||CHR(10);
         :g_output := :g_output||TRIM(v_ocode)||' ';
         :g_output := :g_output||TRIM(v_odesc)||' ';
         :g_output := :g_output||TO_CHAR(v_olist,'999999.99')||CHR(10);
         
      END LOOP;
   END IF;

EXCEPTION
   WHEN v_nodataExists THEN
      ROLLBACK;
      -- no data or row found with data entered
      :g_output := 'No data found for the sales invoice entered.';
   WHEN OTHERS THEN
      ROLLBACK WORK;
      -- check error message
      :g_output := 'Error occurred'||CHR(10);
      :g_output := :g_output||'Error code: '||SQLCODE||CHR(10);
      :g_output := :g_output||'Error message: '||SQLERRM;
END;
/
PRINT g_output
