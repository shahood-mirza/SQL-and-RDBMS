-- PL/SQL Queries
-- Shahood Mirza

ACCEPT p_make PROMPT 'ENTER MAKE: '
SELECT COUNT(DISTINCT cname) FROM s7.prospect
   WHERE make = UPPER('&p_make');

---------------------OUTPUT---------------------------

ENTER MAKE: acura
Input truncated to 33 characters
old   2:    WHERE make = UPPER('&p_make')
new   2:    WHERE make = UPPER('acura')
more...

COUNT(DISTINCTCNAME)
--------------------
                 102

1 row selected.
