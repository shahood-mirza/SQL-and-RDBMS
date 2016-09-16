-- PL/SQL Queries
-- Shahood Mirza

ACCEPT p_serialOld PROMPT 'ENTER OLD CAR SERIAL: '
ACCEPT p_serialNew PROMPT 'ENTER NEW CAR SERIAL: '
INSERT INTO s7.car
(SELECT '&p_serialNew', cname, make, model, cyear, color, trim, enginetype, purchinv, purchdate,
purchfrom, purchcost, freightcost, totalcost, listprice
   FROM s7.car
      WHERE serial='&p_serialOld');
UPDATE s7.saleinv
   SET serial = '&p_serialNew', tradeserial = '&p_serialNew'
      WHERE serial = '&p_serialOld';
UPDATE s7.baseoption
   SET serial = '&p_serialNew'
      WHERE serial = '&p_serialOld';
UPDATE s7.servinv
   SET serial = '&p_serialNew'
      WHERE serial = '&p_serialOld';
DELETE FROM s7.car
   WHERE serial = '&p_serialOld';
COMMIT;

---------------------OUTPUT---------------------------

ENTER OLD CAR SERIAL: ACU55TSX
ENTER NEW CAR SERIAL: ACU99TSX
old   2: (SELECT '&p_serialNew', cname, make, model, cyear, color, trim, enginetype, purchinv, 
          purchdate, purchfrom, purchcost, freightcost, totalcost, listprice
new   2: (SELECT 'ACU99TSX', cname, make, model, cyear, color, trim, enginetype, purchinv, 
          purchdate, purchfrom, purchcost, freightcost, totalcost, listprice
old   4:       WHERE serial='&p_serialOld')
new   4:       WHERE serial='ACU55TSX')

1 row created.

old   2:    SET serial = '&p_serialNew', tradeserial = '&p_serialNew'
new   2:    SET serial = 'ACU99TSX', tradeserial = 'ACU99TSX'
old   3:       WHERE serial = '&p_serialOld'
new   3:       WHERE serial = 'ACU55TSX'

0 rows updated.

old   2:    SET serial = '&p_serialNew'
new   2:    SET serial = 'ACU99TSX'
old   3:       WHERE serial = '&p_serialOld'
new   3:       WHERE serial = 'ACU55TSX'

1 row updated.

old   2:    SET serial = '&p_serialNew'
new   2:    SET serial = 'ACU99TSX'
old   3:       WHERE serial = '&p_serialOld'
new   3:       WHERE serial = 'ACU55TSX'

1 row updated.

old   2:    WHERE serial = '&p_serialOld'
new   2:    WHERE serial = 'ACU55TSX'
DELETE FROM s7.car
               *
ERROR at line 1:
ORA-01031: insufficient privileges



Commit complete.
