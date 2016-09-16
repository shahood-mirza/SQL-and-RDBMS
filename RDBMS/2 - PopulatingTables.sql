-- Populating Tables for Oracle Database
-- Shahood Mirza

INSERT INTO customer (cname, cstreet, ccity, cprov, cpostal, chphone, cbphone)
VALUES ('Shahood Mirza', 'RedWood Rd.', 'Toronto', 'Ontario', 'M5W 3R9', '905-430-3233', '905-276-8793');

INSERT INTO customer (cname, cstreet, ccity, cprov, cpostal, chphone, cbphone)
VALUES ('John Smith', 'GreenWood Rd.', 'Brampton', 'Ontario', 'M6D 2X2', '905-654-5231', '905-323-7565');

INSERT INTO car (serial, cname, make, model, cyear, color, trim, enginetype)
VALUES ('A12BTSX5', 'Shahood Mirza', 'ACURA', 'TSX', '2012', 'Blue', 'AMC', 'V6');

INSERT INTO car (serial, cname, make, model, cyear, color, trim, enginetype)
VALUES ('J11SJAG9', 'Shahood Mirza', 'JAGUAR', 'JAG', '2011', 'Silver', 'AMC', 'V6');

UPDATE car 
   SET freightcost = 2400 
      WHERE serial = 'J11SJAG9';

UPDATE car 
   SET totalcost = 40000 
      WHERE serial = 'J11SJAG9';

INSERT INTO car (serial, cname, make, model, cyear, color, trim, enginetype)
VALUES ('M12BSLR3', 'John Smith', 'MERCEDES', 'SLR', '2012', 'Black', 'AMC', 'V8');

INSERT INTO saleinv (saleinv, cname, salesman, saledate, serial, totalprice)
VALUES ('SM4934', 'Shahood Mirza', 'Steve Seller', sysdate, 'A12BTSX5', 10989.54);

INSERT INTO baseoption (serial, ocode)
VALUES ('A12BTSX5','CD2');

INSERT INTO invoption (saleinv,ocode,saleprice)
VALUES ('SM4934', 'CD2', 24673.93);

--must have value for saleinv before inserting this
--INSERT INTO invoption (saleinv,ocode,saleprice)
--VALUES ('SP9841', 'R14', 2673.93);

INSERT INTO servinv (servinv, serdate, cname, serial)
VALUES ('SV323', '02-MAR-2012', 'Shahood Mirza', 'A12BTSX5');

INSERT INTO servinv (servinv, serdate, cname, serial)
VALUES ('SV349', '05-MAR-2012', 'John Smith', 'M12BSLR3');

INSERT INTO servinv (servinv, serdate, cname, serial)
VALUES ('SV221', '25-DEC-2011', 'Shahood Mirza', 'J11SJAG9');

INSERT INTO servwork (servinv, workdesc)
VALUES ('SV323', 'Windshield Replacement');

INSERT INTO servwork (servinv, workdesc)
VALUES ('SV349', 'Wheel Alignment');

INSERT INTO servwork (servinv, workdesc)
VALUES ('SV221', 'Engine Overhaul');

INSERT INTO prospect (cname, make, model, cyear, color, trim, ocode)
VALUES ('Shahood Mirza', 'MERCEDES', 'CLK-GTR', '2011', 'Silver', 'CQC', 'S22');

INSERT INTO prospect (cname, make, model, cyear, color, trim, ocode)
VALUES ('Shahood Mirza', 'MERCEDES', 'SLR', '2012', 'Silver', 'CQB', 'H35');

COMMIT;