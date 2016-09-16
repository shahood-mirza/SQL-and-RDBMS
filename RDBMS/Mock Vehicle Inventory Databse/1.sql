-- Create Sales Invoice
-- Shahood Mirza
-- 1.sql

--Sequence Creation; Should only be run once
--CREATE SEQUENCE salesinvseq INCREMENT BY 1 START WITH 245926;

--CUSTOMER TABLE INPUT
ACCEPT p_cname       PROMPT 'Enter Customer Name: '
ACCEPT p_cstreet     PROMPT 'Enter Customer Street with Number: '
ACCEPT p_ccity       PROMPT 'Enter Customer City: '
ACCEPT p_cprov       PROMPT 'Enter Customer Province: '
ACCEPT p_cpostal     PROMPT 'Enter Customer Postal Code: '
ACCEPT p_chphone     PROMPT 'Enter Customer Home Phone #: '
--CAR TABLE INPUT
ACCEPT p_serial      PROMPT 'Enter Car Serial Number (MYYCMDL#): '
ACCEPT p_make        PROMPT 'Enter Car Make: '
ACCEPT p_model       PROMPT 'Enter Car Model: '
ACCEPT p_cyear       PROMPT 'Enter Car Year: '
ACCEPT p_color       PROMPT 'Enter Car Colour: '
--INVOPTION TABLE INPUT
ACCEPT p_ocode       PROMPT 'Enter Option Code: '
ACCEPT p_saleprice   PROMPT 'Enter Option Sale Price: '
--SALEINV TABLE INPUT
ACCEPT p_salesman    PROMPT 'Enter Salesman Name: '
ACCEPT p_totalprice  PROMPT 'Enter Total Sale Price: '
ACCEPT p_discount    PROMPT 'Enter Discount Amount: '
ACCEPT p_licfee      PROMPT 'Enter License Fee: '
ACCEPT p_commission  PROMPT 'Enter Commission: '
ACCEPT p_tradeserial PROMPT 'Enter Trade-in Serial: '
ACCEPT p_tradeallow  PROMPT 'Enter Trade-in Allowance: '
ACCEPT p_fire        PROMPT 'Fire Insurance Coverage (Y/N): '
ACCEPT p_collision   PROMPT 'Collision Insurance Coverage (Y/N): '
ACCEPT p_liability   PROMPT 'Liability Insurance Coverage (Y/N): '
ACCEPT p_property    PROMPT 'Property Insurance Coverage (Y/N): '
VARIABLE g_output VARCHAR2(4000)

DECLARE
   v_checkserial NUMBER(1,0);
   v_carsold  EXCEPTION;

BEGIN
   INSERT INTO customer (cname, cstreet, ccity, cprov, cpostal, chphone)
      VALUES ('&p_cname', '&p_cstreet', '&p_ccity', '&p_cprov', '&p_cpostal', '&p_chphone');

   INSERT INTO car (serial, cname, make, model, cyear, color, trim, enginetype)
      VALUES (UPPER('&p_serial'), '&p_cname', UPPER('&p_make'), UPPER('&p_model'), '&p_cyear', '&p_color', 'Standard', 'Standard');

   INSERT INTO saleinv (saleinv, cname, salesman, saledate, serial, totalprice, discount, net, tax, licfee, commission, tradeserial, tradeallow, fire, collision, liability, property)
      VALUES (TO_CHAR(salesinvseq.NEXTVAL,'FM099999'), '&p_cname', '&p_salesman', SYSDATE, '&p_serial', &p_totalprice, &p_discount, (&p_totalprice - &p_discount), ((&p_totalprice - &p_discount) * 0.13), &p_licfee, &p_commission, UPPER('&p_tradeserial'), &p_tradeallow, UPPER('&p_fire'), UPPER('&p_collision'), UPPER('&p_liability'), UPPER('&p_property'));

   INSERT INTO invoption (saleinv,ocode,saleprice)
      VALUES (TO_CHAR(salesinvseq.CURRVAL,'FM099999'), UPPER('&p_ocode'), &p_saleprice);

   SELECT COUNT(serial)
      INTO v_checkserial
      FROM saleinv
         WHERE serial = UPPER('&p_serial');

   IF (v_checkserial > 1) THEN
      RAISE v_carsold;
   END IF;
   :g_output := 'Sales Invoice Successfully Created.';
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