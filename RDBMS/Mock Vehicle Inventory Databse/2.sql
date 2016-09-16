-- Display Sales Invoice
-- Shahood Mirza
-- 2.sql

ACCEPT p_saleinv PROMPT 'Enter Sales Invoice Number (XXXXXX): '
VARIABLE g_output VARCHAR2(4000)
DECLARE
   v_saleinv   saleinv%ROWTYPE;
   v_customer  customer%ROWTYPE;
   v_car       car%ROWTYPE;
   v_tcar      car%ROWTYPE;
   v_invoption invoption%ROWTYPE;
   v_options   options%ROWTYPE;
BEGIN
   SELECT *
      INTO v_saleinv
      FROM saleinv
         WHERE saleinv = UPPER('&p_saleinv');
   SELECT *
      INTO v_customer
      FROM customer
         WHERE v_saleinv.cname = customer.cname;
   SELECT *
      INTO v_car
      FROM car
         WHERE v_saleinv.serial = car.serial;
   SELECT *
      INTO v_tcar
      FROM car
         WHERE v_saleinv.tradeserial = car.serial;
   SELECT *
      INTO v_invoption
      FROM invoption
         WHERE v_saleinv.saleinv = invoption.saleinv;
   SELECT *
      INTO v_options
      FROM options
         WHERE v_invoption.ocode = options.ocode;

   :g_output := CHR(9) || CHR(9) ||  CHR(9) || 'SPECIALTY IMPORTS';
   :g_output := :g_output || CHR(10) || CHR(9) || CHR(9) ||  CHR(9) || 'SALES INVOICE';
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || 'Invoice No.  ' || v_saleinv.saleinv || CHR(9) || CHR(9) ||  CHR(9) ||  CHR(9) || 'Date:  ' || v_saleinv.saledate;
   :g_output := :g_output || CHR(10) || 'SOLD TO:   Name:  ' || v_saleinv.cname;
   :g_output := :g_output || CHR(10) || CHR(9) || '   Address:  ' || v_customer.cstreet;
   :g_output := :g_output || CHR(10) || CHR(9) || '   City:  ' || v_customer.ccity;
   :g_output := :g_output || CHR(10) || CHR(9) || '   Province:  ' || v_customer.cprov || 'Postal Code:  ' || v_customer.cpostal;
   :g_output := :g_output || CHR(10) || CHR(9) || '   Telephone:  ' || v_customer.chphone;
   :g_output := :g_output || CHR(10) || 'Salesman:  ' || v_saleinv.salesman;
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || '----------------------------------------------------------------------';
   :g_output := :g_output || CHR(10) || '| Serial Number   ' || '|   Make    ' || '|   Model   ' ||  '|   Year   ' || '|   Colour      |';
   :g_output := :g_output || CHR(10) || '| '||v_car.serial || '        | ' || v_car.make || '|   ' || v_car.model ||  '|   ' || v_car.cyear ||  '   |   ' || v_car.color || '|';
   :g_output := :g_output || CHR(10) || '----------------------------------------------------------------------';
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || CHR(9) || CHR(9) || 'Insurance Coverage Includes';
   :g_output := :g_output || CHR(10) || CHR(9) || 'Fire and Theft' || CHR(9) || '[' || v_saleinv.fire || ']' || CHR(9) || 'Liability' || CHR(9) || '[' || v_saleinv.liability || ']';
   :g_output := :g_output || CHR(10) || CHR(9) || 'Collision' || CHR(9) || '[' || v_saleinv.collision || ']' || CHR(9) || 'Property Damage' || CHR(9) || '[' || v_saleinv.property || ']';
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || CHR(9) || CHR(9) || CHR(9) || 'OPTIONS';
   :g_output := :g_output || CHR(10) || 'Code' || CHR(9) ||  CHR(9) || 'Description' || CHR(9) || CHR(9) || CHR(9) || CHR(9) || 'Price';
   :g_output := :g_output || CHR(10) || v_invoption.ocode || CHR(9) ||  CHR(9) || v_options.odesc || CHR(9) || CHR(9) || v_invoption.saleprice;
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || CHR(9) || CHR(9) || CHR(9) || 'TRADE-IN';
   :g_output := :g_output || CHR(10) || CHR(9) || 'Serial No.' || CHR(9) || 'Make' || CHR(9) ||  '  Model' || CHR(9) ||  '  Year'  || CHR(9) ||  'Allowance';
   :g_output := :g_output || CHR(10) || CHR(9) || v_saleinv.tradeserial || CHR(9) || v_tcar.make || v_tcar.model || v_tcar.cyear  || CHR(9) || v_saleinv.tradeallow;
   :g_output := :g_output || CHR(10);
   :g_output := :g_output || CHR(10) || '       Total Price: $' || v_saleinv.totalprice;
   :g_output := :g_output || CHR(10) || 'Trade-in Allowance: $' || v_saleinv.tradeallow;
   :g_output := :g_output || CHR(10) || '          Discount: $' || v_saleinv.discount;
   :g_output := :g_output || CHR(10) || '               Net: $' || v_saleinv.net;
   :g_output := :g_output || CHR(10) || '             Taxes: $' || v_saleinv.tax;
   :g_output := :g_output || CHR(10) || '     Total Payable: $' || (v_saleinv.net+v_saleinv.tax);

   EXCEPTION
      WHEN NO_DATA_FOUND THEN
      :g_output := 'Sales Invoice No.&p_saleinv Could Not Be Found';
END;
/
PRINT g_output

ACCEPT p_return PROMPT 'Press ENTER to continue...'
@menu