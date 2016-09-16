-- Create Sales Accounting Supplement
-- Shahood Mirza
-- 5.sql

--Sequence From 1.sql is Used

--CUSTOMER TABLE INPUT
ACCEPT p_cname       PROMPT 'Enter Customer Name: '
ACCEPT p_cstreet     PROMPT 'Enter Customer Street with Number: '
ACCEPT p_ccity       PROMPT 'Enter Customer City: '
ACCEPT p_cprov       PROMPT 'Enter Customer Province: '
--CAR TABLE INPUT
ACCEPT p_serial      PROMPT 'Enter Car Serial Number (MYYCMDL#): '
ACCEPT p_make        PROMPT 'Enter Car Make: '
ACCEPT p_model       PROMPT 'Enter Car Model: '
ACCEPT p_cyear       PROMPT 'Enter Car Year: '
ACCEPT p_color       PROMPT 'Enter Car Colour: '
ACCEPT p_freight     PROMPT 'Enter Car Freight Cost: '
ACCEPT p_totalcost   PROMPT 'Enter Car Total Cost: '
--INVOPTION TABLE INPUT
ACCEPT p_ocode       PROMPT 'Enter Option Code: '
ACCEPT p_saleprice   PROMPT 'Enter Option Sale Price: '
--SALEINV TABLE INPUT
ACCEPT p_salesman    PROMPT 'Enter Salesman Name: '
ACCEPT p_totalprice  PROMPT 'Enter Total Sale Price: '
ACCEPT p_discount    PROMPT 'Enter Discount Amount: '
ACCEPT p_licfee      PROMPT 'Enter License Fee: '
ACCEPT p_commission  PROMPT 'Enter Commission: '
VARIABLE g_output VARCHAR2(4000)

DECLARE
   v_checkserial NUMBER(1,0);
   v_carsold  EXCEPTION;

BEGIN
   INSERT INTO customer (cname, cstreet, ccity, cprov)
      VALUES ('&p_cname', '&p_cstreet', '&p_ccity', '&p_cprov');

   INSERT INTO car (serial, cname, make, model, cyear, color, trim, enginetype, freightcost, totalcost)
      VALUES (UPPER('&p_serial'), '&p_cname', UPPER('&p_make'), UPPER('&p_model'), '&p_cyear', '&p_color', 'Standard', 'Standard', '&p_freight', '&p_totalcost');

   INSERT INTO saleinv (saleinv, cname, salesman, saledate, serial, totalprice, discount, net, tax, licfee, commission)
      VALUES (TO_CHAR(salesinvseq.NEXTVAL,'FM099999'), '&p_cname', '&p_salesman', SYSDATE, '&p_serial', &p_totalprice, &p_discount, (&p_totalprice - &p_discount), ((&p_totalprice - &p_discount) * 0.13), &p_licfee, &p_commission);

   INSERT INTO invoption (saleinv,ocode,saleprice)
      VALUES (TO_CHAR(salesinvseq.CURRVAL,'FM099999'), UPPER('&p_ocode'), &p_saleprice);

   SELECT COUNT(serial)
      INTO v_checkserial
      FROM saleinv
         WHERE serial = UPPER('&p_serial');

   IF (v_checkserial > 1) THEN
      RAISE v_carsold;
   END IF;
   :g_output := 'Sales Accounting Supplement Successfully Created.';
   COMMIT;

   EXCEPTION
      WHEN v_carsold THEN
         ROLLBACK;
         :g_output := 'ERROR: Car Already Sold';
END;
/
PRINT g_output

ACCEPT p_return PROMPT 'Press ENTER to continue...'
@menu