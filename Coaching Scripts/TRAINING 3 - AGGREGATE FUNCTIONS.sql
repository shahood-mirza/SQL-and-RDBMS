-- Shahood Mirza

create unique index pkcustomer on customer(custno);
create index fkpart on part(partdesc);

drop index fkpart on part;

-- aggregate functions
-- DISPLAY THE TOTAL NO OF RECORDS/ROWS IN A TABLE
SELECT COUNT(*) FROM PART;

-- DISPLAY THE LAST UNIT PRICE FROM PART
SELECT MIN(UNITPRICE) FROM PART;
SELECT MAX(UNITPRICE) FROM PART;
SELECT AVG(ONHAND) FROM PART;

SELECT SUM(UNITPRICE * ONHAND) FROM PART;