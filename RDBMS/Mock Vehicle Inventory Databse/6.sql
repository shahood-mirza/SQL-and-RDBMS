-- Display Accounting Sales Supplement
-- Shahood Mirza
-- 6.sql

ACCEPT p_saleinv PROMPT 'Enter Sales Invoice Number (XXXXXX): '
VARIABLE g_output VARCHAR2(4000)
DECLARE
   v_saleinv   saleinv%ROWTYPE;
   v_car       car%ROWTYPE;
   v_invoption invoption%ROWTYPE;
   v_options   options%ROWTYPE;
BEGIN
   SELECT *
      INTO v_saleinv
      FROM saleinv
         WHERE saleinv = UPPER('&p_saleinv');
   SELECT *
      INTO v_car
      FROM car
         WHERE v_saleinv.serial = car.serial;
   SELECT *
      INTO v_invoption
      FROM invoption
         WHERE v_saleinv.saleinv = invoption.saleinv;
   SELECT *
      INTO v_options
      FROM options
         WHERE v_invoption.ocode = options.ocode;

   :g_output := CHR(9) || CHR(9) ||  CHR(9) || 'VEHICLE SALES ACCOUNTING SUPPLEMENT';
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || 'Invoice No.  ' || v_saleinv.saleinv || CHR(9) || 'Customer:  ' || v_saleinv.cname ||  CHR(9) || 'Date:  ' || v_saleinv.saledate;
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || CHR(9) || CHR(9) || 'Item' || CHR(9) || CHR(9) || 'Cost' || CHR(9) || CHR(9) || 'Sale';
   :g_output := :g_output || CHR(10) || 'Serial# '|| CHR(9) || v_car.serial || CHR(9) || v_car.totalcost || CHR(9) || CHR(9) || v_saleinv.net;
   :g_output := :g_output || CHR(10) || CHR(9) || CHR(9) || v_invoption.ocode || CHR(9) || CHR(9) || v_options.ocost || CHR(9) || CHR(9) || v_invoption.saleprice;
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || 'Freight and Preperation' || CHR(9) || CHR(9) || v_car.freightcost || CHR(9) || CHR(9) || v_car.freightcost;
   :g_output := :g_output || CHR(10) || 'Tax' || CHR(9) || CHR(9) || CHR(9) || CHR(9) || v_saleinv.tax || CHR(9) || CHR(9) || v_saleinv.tax;
   :g_output := :g_output || CHR(10) || 'License Fees' || CHR(9) || CHR(9) || CHR(9) || v_saleinv.licfee || CHR(9) || CHR(9) || v_saleinv.licfee;
   :g_output := :g_output || CHR(10) || 'Other';
   :g_output := :g_output || CHR(10) || 'Commission' || CHR(9) || CHR(9) || CHR(9) || v_saleinv.commission;
   :g_output := :g_output || CHR(10) || 'TOTAL' || CHR(9) || CHR(9) || CHR(9) || CHR(9) || (v_car.totalcost+v_options.ocost+v_car.freightcost+v_saleinv.tax) || CHR(9) || CHR(9) || (v_saleinv.net+v_invoption.saleprice+v_car.freightcost+v_saleinv.tax);

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
      :g_output := 'Sales Invoice No.&p_saleinv Could Not Be Found';
END;
/
PRINT g_output

ACCEPT p_return PROMPT 'Press ENTER to continue...'
@menu