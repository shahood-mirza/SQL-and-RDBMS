-- Create Vehicle Inventory Record
-- Shahood Mirza
-- 3.sql

ACCEPT p_serial      PROMPT 'Please enter serial#: '
ACCEPT p_make        PROMPT 'Please enter make: '
ACCEPT p_model       PROMPT 'Please enter model: '
ACCEPT p_cyear       PROMPT 'Please enter car year: '
ACCEPT p_color       PROMPT 'Please enter color: '
ACCEPT p_trim        PROMPT 'Please enter trim: '
ACCEPT p_purchinv    PROMPT 'Please enter purchase invoice#: '
ACCEPT p_purchdate   PROMPT 'Please enter purchase date (DD-MM-YYYY): '
ACCEPT p_purchfrom   PROMPT 'Please enter purchase from: '
ACCEPT p_purchcost   PROMPT 'Please enter purchase cost: '
ACCEPT p_listprice   PROMPT 'Please enter list  price: '
ACCEPT p_ocode       PROMPT 'Please enter options code: '
ACCEPT p_odesc       PROMPT 'Please enter options description: '
ACCEPT p_olist       PROMPT 'Please enter options list: '


VARIABLE g_output VARCHAR2(4000)

DECLARE
   v_DATA NUMBER(4);
   v_EXCP EXCEPTION;
   v_check NUMBER(4);
BEGIN
   SELECT COUNT(*)
   INTO v_check  
   FROM car
   WHERE serial = '&p_serial';
  
   IF v_DATA != 0 THEN
      RAISE v_EXCP;
   ELSE
      
      INSERT INTO car (serial,make,model,cyear,color,trim,purchinv,purchdate,purchfrom,purchcost,listprice)
      VALUES ('&p_serial','&p_make','&p_model','&p_cyear','&p_color','&p_trim','&p_purchinv',
              '&p_purchdate','&p_purchfrom','&p_purchcost','&p_listprice');

      INSERT INTO options(ocode,odesc,olist)
      VALUES ('&p_ocode','&p_odesc','&p_olist');

      INSERT INTO baseoption(serial,ocode)
      VALUES ('&p_serial','&p_ocode');
   
   END IF;

EXCEPTION
   WHEN v_EXCP THEN
      ROLLBACK;
      
      :g_output := 'Data already exists';
   
   WHEN OTHERS THEN
      COMMIT;
      
      :g_output := 'Error occurred'||CHR(10);
      :g_output := :g_output||'Error code: '||SQLCODE||CHR(10);
      :g_output := :g_output||'Error message: '||SQLERRM;
END;
/
PRINT g_output