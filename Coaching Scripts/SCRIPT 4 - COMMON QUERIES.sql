-- Shahood Mirza

-- 1.	List all the data in all tables.  (Submit query only.  Do NOT submit output.)
SELECT * FROM CUSTOMER C LEFT OUTER JOIN ORDERS O
ON C.CUSTNO = O.CUSTNO
LEFT OUTER JOIN ORDERPROD OP
ON O.ORDERNO = OP.ORDERNO
LEFT OUTER JOIN PART P
ON OP.PARTNO = P.PARTNO
LEFT OUTER JOIN INVPROD IP
ON P.PARTNO = IP.PARTNO
LEFT OUTER JOIN INVOICE I
ON IP.INVNO = I.INVNO
LEFT OUTER JOIN SALESREP SR
ON C.SREPNO = SR.SREPNO;

-- 2.	List the customer number and name of customers who live in Mississauga (descending name order).
SELECT CUSTNO, CUSTNAME FROM CUSTOMER
WHERE CUSTCITY = 'MISSISSAUGA'
ORDER BY CUSTNAME DESC;

-- 3.	List the name and number of customers who have placed orders but  who do not have a sales rep number (ascending name order).
SELECT C.CUSTNO, CUSTNAME FROM ORDERS O, CUSTOMER C
WHERE O.CUSTNO = C.CUSTNO
AND SREPNO IS NULL
ORDER BY CUSTNAME ASC;

-- 4.	List the average unit price of all appliances on file.
SELECT AVG(UNITPRICE) FROM PART
WHERE PARTCLASS = 'AP';

-- 5.	How many sports items are on file?
SELECT COUNT(PARTCLASS) FROM PART
WHERE PARTCLASS = 'SP';

-- 6.	What is the total number of appliances that are on hand?
SELECT SUM(ONHAND) FROM PART
WHERE PARTCLASS = 'AP';

-- 7.	What is the average order price of sports items sold between January 2009 and November 2009 (inclusive).
SELECT AVG(ORDERPRICE) FROM ORDERS O, ORDERPROD OP, PART P
WHERE O.ORDERNO = OP.ORDERNO
AND OP.PARTNO = P.PARTNO
AND P.PARTCLASS = 'SP'
AND O.ORDERDATE >= '2009-01-01' AND O.ORDERDATE <= '2009-11-30';

-- 8.	What is the minimum and maximum unit price of the parts?  Change the column headings.
SELECT MIN(UNITPRICE) AS 'MINIMUM PRICE', MAX(UNITPRICE) AS 'MAXIMUM PRICE' FROM PART;

-- 9.	What is the part number and description of the part(s) with that maximum price?  Do not use a constant.
SELECT PARTNO, PARTDESC FROM PART
WHERE UNITPRICE = (SELECT MAX(UNITPRICE) FROM PART);

-- 10.	List the name and full address of customers who have never placed an order?
SELECT CUSTNAME, CUSTSTREET, CUSTCITY, CUSTPROV, CUSTPCODE FROM CUSTOMER
WHERE CUSTNO NOT IN (SELECT CUSTNO FROM ORDERS);

-- 11.	List all parts for which the part description starts with an A, C or S. (partno, desc, price)
SELECT PARTNO, PARTDESC, UNITPRICE FROM PART
WHERE PARTDESC LIKE 'A%' OR PARTDESC LIKE 'C%' OR PARTDESC LIKE 'S%';

-- 12.	List the same set of parts as #11 but add (orderno, orderdate) if they were ordered.
SELECT P.PARTNO, PARTDESC, UNITPRICE, OP.ORDERNO, ORDERDATE FROM PART P LEFT OUTER JOIN ORDERPROD OP
ON P.PARTNO = OP.PARTNO
LEFT OUTER JOIN ORDERS O
ON O.ORDERNO = OP.ORDERNO
WHERE PARTDESC LIKE 'A%' OR PARTDESC LIKE 'C%' OR PARTDESC LIKE 'S%';

-- 13.	Print a list of all the sales reps who represent anyone with '________A________' in their name.
-- Do not print the same sales rep more than once. Ask your teacher for the name to use.
SELECT DISTINCT S.SREPNO, SREPNAME FROM SALESREP S, CUSTOMER C
WHERE C.SREPNO = S.SREPNO
AND C.CUSTNAME LIKE '%A%';

-- 14.	What is the total amount of each order placed by customers living in Brampton?
SELECT CUSTNAME, OP.ORDERNO, SUM(ORDERPRICE * ORDERQTY) AS 'TOTAL' FROM ORDERPROD OP, ORDERS O, CUSTOMER C
WHERE OP.ORDERNO = O.ORDERNO
AND O.CUSTNO = C.CUSTNO
AND CUSTCITY = 'BRAMPTON'
GROUP BY O.ORDERNO;

-- 15.	What is the price of the cheapest part in each part class?
SELECT PARTNO, PARTDESC, PARTCLASS, MIN(UNITPRICE) FROM PART
GROUP BY PARTCLASS;

-- 16.	Determine the customer number, name and address of customers living in Brampton who have 
-- purchased $500 or more of a part. Include the total amount of each part in the output. (Ascending total amount order)
SELECT C.CUSTNO, CUSTNAME, CUSTSTREET, CUSTCITY, CUSTPROV, CUSTPCODE, ORDERPRICE * ORDERQTY AS 'TOTAL OF PARTS' FROM CUSTOMER C, ORDERPROD OP, ORDERS O
WHERE C.CUSTNO = O.CUSTNO
AND O.ORDERNO = OP.ORDERNO
AND CUSTCITY = 'BRAMPTON'
AND (ORDERPRICE * ORDERQTY) >= 500
ORDER BY (ORDERPRICE * ORDERQTY) ASC;