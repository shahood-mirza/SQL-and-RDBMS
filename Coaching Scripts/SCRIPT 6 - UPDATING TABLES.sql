-- Shahood Mirza

-- UPDATING PRIMARY KEY TABLE
INSERT INTO ORDERS
(SELECT '99999', ORDERDATE, CUSTNO
FROM ORDERS
WHERE ORDERNO = '58495');

-- UPDATING CHILD TABLES
UPDATE ORDERPROD
SET ORDERNO = '99999'
WHERE ORDERNO = '58495';

UPDATE INVOICE
SET ORDERNO = '99999'
WHERE ORDERNO = '58495';

-- DELETING OLD RECORD FROM ORIGINAL TABLE
DELETE FROM ORDERS
WHERE ORDERNO = '58495';