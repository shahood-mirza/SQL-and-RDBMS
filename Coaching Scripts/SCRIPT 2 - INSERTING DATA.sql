-- Shahood Mirza

INSERT INTO PART
   VALUES
      ('1000', 'Drill', 51, 'HW', 7.99);
INSERT INTO PART
   VALUES
      ('1001', 'Wrench', 43, 'HW', 3.97);
INSERT INTO PART
   VALUES
      ('1002', 'Pliers', 87, 'HW', 2.45);
INSERT INTO PART
   VALUES
      ('1003', 'Toolbox', 22, 'HW', 12.99);

INSERT INTO SALESREP
   VALUES
      ('100', 'Martin', '392 Red Deer Rd', 'Brampton', 'ON', 'L5W2R5', 5000, 0.10);
INSERT INTO SALESREP
   VALUES
      ('101', 'Amy', '227 Stonehill Rd', 'Brampton', 'ON', 'L3Q3E3', 7500, 0.10);

INSERT INTO CUSTOMER
   VALUES
      ('100', 'Shahood', '12 Glory Dr', 'Brampton', 'ON', 'L4T2B8', 10.0, 0, 0, 101);
INSERT INTO CUSTOMER
   VALUES
      ('101', 'George', '32 Ferns Ave', 'Mississauga', 'ON', 'L8M9Z9', 4.0, 100, 200, 100);

INSERT INTO ORDERS
   VALUES
      ('58495', '2011-08-22', '100');
INSERT INTO ORDERS
   VALUES
      ('58543', '2011-10-16', '100');

INSERT INTO ORDERPROD
   VALUES
      ('58495', '1002', 5, 2.45);
INSERT INTO ORDERPROD
   VALUES
      ('58543', '1003', 3, 12.99);

INSERT INTO INVOICE
   VALUES
      ('38430', '2011-08-23', '58495');

INSERT INTO INVPROD
   VALUES
      ('58543', '1002', 5);