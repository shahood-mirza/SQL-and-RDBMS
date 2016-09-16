-- print the customer list along with addresses

DECLARE

CURSOR allcust IS
   SELECT cname, cstreet, ccity, cprov, cpostal
      FROM s7.customer;

BEGIN

FOR v_cus in all_customer

LOOP

DBMS_OUTPUT.PUT_LINE('Customer Name:'||v_cus.cname);

DBMS_OUTPUT.PUT_LINE('Customer Address:'||v_cus.cstreet||v_cus.ccity
||v_cus.cprov||v_cus.cpostal);

END LOOP;

END;