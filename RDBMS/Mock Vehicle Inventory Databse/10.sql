-- Inquire Customer
-- Shahood Mirza
-- 10.sql

ACCEPT p_servinv PROMPT 'Please customer name: '
VARIABLE g_output VARCHAR2(4000)
DECLARE
 
   v_servinv	servinv%ROWTYPE;
   v_customer	customer%ROWTYPE;

   BEGIN
     SELECT * 
        INTO v_customer
        FROM customer
          WHERE v_servinv.cname = customer.cname;

	
	:g_output := :g_output || '' ||'Service for: Name: ' || ' ' ||TRIM(v_customer.cname)|| CHR(10); 
	:g_output := :g_output || '' ||'        Address:   ' || ' ' ||TRIM(v_customer.cstreet)|| CHR(10); 
	:g_output := :g_output || '' ||'        City: ' || ' ' ||TRIM(v_customer.ccity)||'	        Postalcode:  '||TRIM(v_customer.cpostal)|| CHR(10);
	:g_output := :g_output || '' ||'Telephone Work: ' || ' ' ||TRIM(v_customer.cbphone)||'     Home: '||TRIM(v_customer.chphone)|| CHR(10);
	
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	:g_output := 'No Data Found';

   END;
   /
   PRINT g_output
