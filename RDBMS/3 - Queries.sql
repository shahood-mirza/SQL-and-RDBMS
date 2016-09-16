-- Select statements
-- Shahood Mirza


SELECT * FROM s7.customer;
SELECT * FROM s7.car;
SELECT * FROM s7.saleinv;
SELECT * FROM s7.options;
SELECT * FROM s7.baseoption;
SELECT * FROM s7.invoption;
SELECT * FROM s7.servinv;
SELECT * FROM s7.servwork;
SELECT * FROM s7.prospect;
SELECT * FROM s7.employee;


SELECT COUNT(*) FROM s7.saleinv s
WHERE fire = 'Y'
OR collision = 'Y'
OR liability = 'Y'
OR property = 'Y';


SELECT DISTINCT c.* FROM s7.customer c, s7.prospect p
WHERE c.cname = p.cname
AND make = UPPER('jaguar')
AND color = UPPER('blue');


SELECT DISTINCT cu.cname, cu.chphone FROM s7.customer cu, s7.car c, s7.saleinv s
WHERE cu.cname = s.cname
AND s.serial = c.serial
AND make = UPPER('jaguar')
AND model = UPPER('xjr')
AND cbphone IS NULL
ORDER BY cname DESC;


SELECT AVG(s.totalcost) FROM s7.servinv s, s7.car c
WHERE s.serial = c.serial
AND make = UPPER('mercedes')
AND cyear = '2009';


SELECT cu.cname, cu.chphone, cu.cbphone FROM s7.customer cu, s7.car c, s7.saleinv s
WHERE cu.cname = s.cname
AND s.serial = c.serial
AND cu.cname NOT IN (SELECT cname FROM s7.servinv);


SELECT cu.cname || CHR(10) || cu.cstreet || CHR(10) || TRIM(cu.ccity) || ', ' || 
   TRIM(cu.cprov) || ' ' || TRIM(cu.cpostal) || CHR(10) || TRIM(c.make) || ', ' || TRIM(c.model)
AS "HIGHEST SALE" FROM s7.customer cu, s7.car c
WHERE cu.cname = c.cname
AND totalcost = (SELECT MAX(totalcost) FROM s7.car);
