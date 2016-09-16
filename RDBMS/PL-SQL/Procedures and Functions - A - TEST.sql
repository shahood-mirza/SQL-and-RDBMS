-- PL/SQL Procedures & Functions
-- Shahood Mirza

ACCEPT p_fletter PROMPT 'Enter first letter in customer name: '
ACCEPT p_lletter PROMPT 'Enter last letter in customer name: '
VARIABLE g_output VARCHAR2(2000)
DECLARE
   CURSOR custspent IS
      SELECT cname FROM saleinv
         WHERE cname BETWEEN '&p_fletter' AND '&p_lletter';
   v_total  saleinv.totalprice%TYPE;
   v_cname  saleinv.cname%TYPE;
BEGIN
   OPEN custspent;
   LOOP
      FETCH custspent INTO v_cname;
      EXIT WHEN custspent%NOTFOUND;
      CustSpend(v_cname, v_total);
      :g_output := v_cname || 'Spent: $' || v_total;
      :g_output := :g_output || CHR(10);
   END LOOP;
END;   
/
PRINT g_output

---------------------OUTPUT---------------------------

Enter first letter in customer name: S
Enter last letter in customer name: a
old   4:          WHERE cname BETWEEN '&p_fletter' AND '&p_lletter';
new   4:          WHERE cname BETWEEN 'S' AND 'a';

PL/SQL procedure successfully completed.

Input truncated to 14 characters
more...

G_OUTPUT
-------------------------------------
Shahood Mirza       Spent: $10989.54