-- PL/SQL Exceptions & Cursors
-- Shahood Mirza

ACCEPT p_make PROMPT 'Enter Make: '
ACCEPT p_model PROMPT 'Enter Model: '
ACCEPT p_year PROMPT 'Enter Year: '
ACCEPT p_colour PROMPT 'Enter Colour: '
VARIABLE g_output VARCHAR2(4000)
DECLARE
   v_cname     s7.customer.cname%TYPE;
   v_cstreet   s7.customer.cstreet%TYPE;
   v_ccity     s7.customer.ccity%TYPE;
   v_cprov     s7.customer.cprov%TYPE;
   v_cpostal   s7.customer.cpostal%TYPE;
CURSOR prospects IS
   SELECT c.cname, cstreet, ccity, cprov, cpostal
      FROM s7.customer c, s7.prospect p
         WHERE p.cname = c.cname
         AND make = UPPER('&p_make')
         AND model = UPPER('&p_model')
         AND cyear = UPPER('&p_year')
         AND color = UPPER('&p_colour');
BEGIN
   OPEN prospects;
   :g_output := '&p_make &p_model' || CHR(10) || '&p_year &p_colour' || CHR(10) || CHR(10);
   LOOP
      FETCH prospects INTO v_cname, v_cstreet, v_ccity, v_cprov, v_cpostal;
      EXIT WHEN prospects%NOTFOUND;
      :g_output := :g_output || v_cname || CHR(10) || v_cstreet || CHR(10) || v_ccity
      || ', ' || v_cprov || ' ' || v_cpostal || CHR(10) || CHR(10);
   END LOOP;      
END;
/
PRINT g_output

---------------------OUTPUT---------------------------

Enter Make: MERCEDES
Enter Model: SLK
Enter Year: 2008
Enter Colour: Silver
old  11:          AND make = UPPER('&p_make')
new  11:          AND make = UPPER('mercedes')
old  12:          AND model = UPPER('&p_model')
new  12:          AND model = UPPER('slk')
old  13:          AND cyear = UPPER('&p_year')
new  13:          AND cyear = UPPER('2008')
old  14:          AND color = UPPER('&p_colour');
new  14:          AND color = UPPER('silver');
old  17:    :g_output := '&p_make &p_model' || CHR(10) || '&p_year &p_colour' || CHR(10) || CHR(10);
new  17:    :g_output := 'mercedes slk' || CHR(10) || '2008 silver' || CHR(10) || CHR(10);

PL/SQL procedure successfully completed.

Input truncated to 14 characters
more...

G_OUTPUT
-------------------------------
MERCEDES SLK
2008 Silver

STEVE YZERMAN
600 CIVIC CENTER DR.
DETROIT, MICHIGAN 48226

RODRIGO LIMA
123 FAKE STREET
MISSISSAUGA, ONTARIO L5L 5L5
