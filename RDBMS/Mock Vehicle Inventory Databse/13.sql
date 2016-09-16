-- Generate Prospect List
-- Shahood Mirza
-- 13.sql

VARIABLE g_output VARCHAR2(4000)
DECLARE
   v_prospect  prospect%ROWTYPE;
   v_options   options%ROWTYPE;
   CURSOR allprospects IS
      SELECT *
         FROM prospect;
   CURSOR alloptions IS
      SELECT o.*
         FROM options o, prospect p
            WHERE o.ocode = p.ocode;
BEGIN
   :g_output := CHR(9) || CHR(9) || CHR(9) || 'PROSPECT LIST';
   :g_output := :g_output || CHR(10)|| 'Name______________' || CHR(9) || 'Want___________________________________________';
   OPEN allprospects;
   OPEN alloptions;
   LOOP
      FETCH allprospects INTO v_prospect;
      EXIT WHEN allprospects%NOTFOUND;
      FETCH alloptions INTO v_options;
      EXIT WHEN alloptions%NOTFOUND;
      :g_output := :g_output || CHR(10) || v_prospect.cname || CHR(9) || v_prospect.cyear || ' ' || TRIM(v_prospect.color) || ' ' || TRIM(v_prospect.make) || ' w/' || TRIM(v_options.odesc)||'('|| TRIM(v_prospect.ocode) || ')';
   END LOOP;
END;
/
PRINT g_output

ACCEPT p_return PROMPT 'Press ENTER to continue...'
@menu