-- More Select statements
-- Shahood Mirza


SELECT make, AVG(totalprice), COUNT(servinv) FROM s7.servinv s, s7.car c, s7.saleinv sl
 WHERE s.serial = c.serial
  AND c.serial = sl.serial
  AND make IN('JAGUAR', 'LAND ROVER', 'MERCEDES')
  AND saledate BETWEEN '01-FEB-2009' AND '31-JAN-2012'
   GROUP BY make;


SELECT salesman, COUNT(serial) FROM s7.saleinv
 GROUP BY salesman
 HAVING COUNT(serial) < 3;


SELECT cname, odesc FROM s7.saleinv s, s7.baseoption b, s7.options o
 WHERE s.serial = b.serial
  AND o.ocode = b.ocode
  AND odesc LIKE '%SUN ROOF%'
UNION
SELECT cname, odesc FROM s7.saleinv s, s7.invoption i, s7.options o
 WHERE s.saleinv = i.saleinv
  AND i.ocode = o.ocode
  AND odesc LIKE '%SUN ROOF%';


SELECT c.serial, make, model, o.ocode, odesc, olist FROM s7.car c, s7.options o, s7.baseoption b
 WHERE c.serial = b.serial (+)
  AND b.ocode = o.ocode (+)
  AND cyear = '2010'
  AND c.cname IS NULL;


SELECT s.cname, ccity, SUM(saleprice) AS TotalAmount
 FROM s7.customer c, s7.saleinv s, s7.invoption i
  WHERE c.cname = s.cname
   AND s.saleinv = i.saleinv
   AND ccity = UPPER('BRAMPTON')
    GROUP BY s.cname, ccity
    HAVING SUM(saleprice)>=1000
    ORDER BY TotalAmount ASC;


SELECT DISTINCT p.cname, cstreet, ccity, cprov, cpostal, chphone, p.make, p.model, p.cyear, p.color
 FROM s7.customer c, s7.car cr, s7.saleinv s, s7.prospect p
  WHERE c.cname = p.cname
   AND cr.cname IS NULL
   AND cr.serial NOT IN (SELECT DISTINCT s.serial FROM s7.saleinv)
   AND cr.make = p.make
   AND cr.model = p.model
   AND cr.cyear = p.cyear
   AND cr.color = p.color;