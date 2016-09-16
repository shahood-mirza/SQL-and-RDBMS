-- PL/SQL Procedures & Functions
-- Shahood Mirza

CREATE OR REPLACE PROCEDURE CustSpend
   (v_cname IN    saleinv.cname%TYPE,
    v_total OUT   saleinv.totalprice%TYPE)
   AS
BEGIN
   SELECT SUM(totalprice)
      INTO v_total
      FROM saleinv
         WHERE cname = v_cname;
END;
/

---------------------OUTPUT---------------------------

Input truncated to 1 characters

Procedure created.