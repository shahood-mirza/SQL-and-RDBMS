-- Inquire Service Work Order
-- Shahood Mirza
-- 8.sql

ACCEPT p_servinv PROMPT 'Please enter service invoice #: '
VARIABLE g_output VARCHAR2(4000)
DECLARE
   v_servwork   servwork%ROWTYPE;
   v_servinv	servinv%ROWTYPE;
   v_customer	customer%ROWTYPE;
   v_car	car%ROWTYPE;

   BEGIN
      SELECT *
	INTO v_servinv
	FROM servinv
	  WHERE servinv = '&p_servinv';

      SELECT * 
        INTO v_servwork
        FROM servwork
          WHERE servinv = '&p_servinv';

      SELECT * 
        INTO v_customer
        FROM customer
          WHERE v_servinv.cname = customer.cname;

      SELECT * 
        INTO v_car
        FROM car
          WHERE v_servinv.serial = car.serial;


	:g_output := :g_output|| lpad('Service Work Order',50)|| CHR(10); 
 	:g_output := :g_output||  CHR(10);    
	:g_output := :g_output || '' ||'Service Invoice No: ' || ' ' ||TRIM(v_servinv.servinv)||'       Date   '||TRIM(v_servinv.serdate)|| CHR(10); 
	:g_output := :g_output || '' ||'Service for: Name: ' || ' ' ||TRIM(v_customer.cname)|| CHR(10); 
	:g_output := :g_output || '' ||'        Address:   ' || ' ' ||TRIM(v_customer.cstreet)|| CHR(10); 
	:g_output := :g_output || '' ||'        City: ' || ' ' ||TRIM(v_customer.ccity)||'	        Postalcode:  '||TRIM(v_customer.cpostal)|| CHR(10);
	:g_output := :g_output || '' ||'Telephone Work: ' || ' ' ||TRIM(v_customer.cbphone)||'     Home: '||TRIM(v_customer.chphone)|| CHR(10);
	:g_output := :g_output || '' ||'Serial Number    ' || ' ' ||'make   '||'    model'||'   Year'||'   Color'|| CHR(10); 
	:g_output := :g_output||TRIM(v_car.serial)||'          ';
         :g_output := :g_output||TRIM(v_car.make)||'   ';
         :g_output := :g_output||TRIM(v_car.model)||'     ';
         :g_output := :g_output||TRIM(v_car.cyear)||'   ';
         :g_output := :g_output||TRIM(v_car.color)||'      '|| CHR(10);
	 :g_output := :g_output || '' ||'Work to be Done: ' ||TRIM(v_servwork.workdesc)|| CHR(10); 
	 :g_output := :g_output || '' ||' Parts:    ' ||TO_CHAR(v_servinv.partscost,'9999999.99')|| CHR(10)|| ' ' ||' Labor:   '||TO_CHAR(v_servinv.laborcost,'999999.99')||' '|| CHR(10)||' Tax:     '||TO_CHAR(v_servinv.tax,'999999.99')||' '|| CHR(10)||' Total: '||TO_CHAR(v_servinv.totalcost,'9999.99')||'' || CHR(10); 
	

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	:g_output := 'No Data Found';

   END;
   /
   PRINT g_output
