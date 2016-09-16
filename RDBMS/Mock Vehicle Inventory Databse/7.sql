-- Create Service Work Order
-- Shahood Mirza
-- 7.sql

ACCEPT p_servinv    PROMPT 'Please enter service invoice #: '
ACCEPT p_serdate   PROMPT 'Please enter service date (DD-MM-YYYY): '
ACCEPT p_cname	    PROMPT 'Please enter customer name: '
ACCEPT p_serial	    PROMPT 'Please enter serial #: '
ACCEPT p_partscost  PROMPT 'Please enter parts cost: '
ACCEPT p_laborcost  PROMPT 'Please enter labor cost '
ACCEPT p_tax        PROMPT 'Please enter tax: '
ACCEPT p_totalcost  PROMPT 'Please enter total cost: '
ACCEPT p_workdesc   PROMPT 'Please enter work description: '

VARIABLE g_output VARCHAR2(4000)
DECLARE
   v_DATA NUMBER(4);
   v_chkRec NUMBER(4);
   v_dataExists EXCEPTION;
BEGIN
   SELECT COUNT(*)
   INTO v_DATA
   FROM servinv
   WHERE servinv = '&p_servinv';


   IF v_chkRec != 0 THEN
      RAISE v_dataExists;
   ELSE	      
      INSERT INTO servinv (servinv,serdate,cname,serial,partscost,laborcost,tax,totalcost)
      VALUES ('&p_servinv','&p_serdate','&p_cname','&p_serial','&p_partscost','&p_laborcost','&p_tax','&p_totalcost');

      INSERT INTO servwork(servinv,workdesc)
      VALUES('&p_servinv','&p_workdesc');

   END IF;

EXCEPTION
   WHEN v_dataExists THEN
      ROLLBACK;
      
      :g_output := 'data already exists';
   
   WHEN OTHERS THEN
      COMMIT;
      
      :g_output := 'Error occurred'||CHR(10);
      :g_output := :g_output||'Error code: '||SQLCODE||CHR(10);
      :g_output := :g_output||'Error message: '||SQLERRM;
END;
/
PRINT g_output
      




