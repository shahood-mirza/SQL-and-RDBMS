-- PL/SQL Procedures & Functions
-- Shahood Mirza

CREATE OR REPLACE FUNCTION optioncount (v_serial IN car.serial%TYPE)
   RETURN NUMBER
IS
   v_bcount NUMBER;
   v_icount NUMBER;
BEGIN
   SELECT COUNT(*)
      INTO v_bcount
      FROM baseoption
         WHERE serial = v_serial;
   SELECT COUNT(*)
      INTO v_icount
      FROM saleinv s, invoption i
         WHERE s.saleinv = i.saleinv
            AND serial = v_serial;
   RETURN v_bcount + v_icount;
END;
/

---------------------OUTPUT---------------------------

Input truncated to 1 characters

Function created.