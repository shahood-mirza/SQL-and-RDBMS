-- Creating Tables for Oracle Database
-- Shahood Mirza

DROP TABLE employee;
DROP TABLE prospect;
DROP TABLE servwork;
DROP TABLE servinv;
DROP TABLE invoption;
DROP TABLE baseoption;
DROP TABLE options;
DROP TABLE saleinv;
DROP TABLE car;
DROP TABLE customer;

CREATE TABLE customer
(     cname       CHAR(20)    CONSTRAINT customer_cname_pk PRIMARY KEY,
      cstreet     CHAR(20)    NOT NULL,
      ccity       CHAR(20)    NOT NULL,
      cprov       CHAR(20)    NOT NULL,
      cpostal     CHAR(10),
      chphone     CHAR(13),
      cbphone     CHAR(13));

CREATE TABLE car
(     serial      CHAR(8)     CONSTRAINT car_serial_pk PRIMARY KEY,
      cname       CHAR(20)    CONSTRAINT car_cname_fk REFERENCES customer(cname),
      make        CHAR(10)    NOT NULL,
      model       CHAR(8)     NOT NULL,
      cyear       CHAR(4)     NOT NULL,
      color       CHAR(12)    NOT NULL,
      trim        CHAR(16)    NOT NULL,
      enginetype  CHAR(10)    NOT NULL,
      purchinv    CHAR(6),
      purchdate   DATE,
      purchform   CHAR(12),
      purchcost   NUMBER(9,2),
      freightcost NUMBER(7,2),
      totalcost   NUMBER(9,2),
      listprice   NUMBER(9,2));

CREATE TABLE saleinv
(     saleinv     CHAR(6)     CONSTRAINT saleinv_saleinv_pk PRIMARY KEY,
      cname       CHAR(20)    CONSTRAINT saleinv_cname_fk NOT NULL REFERENCES customer(cname),
      salesman    CHAR(20),
      saledate    DATE        NOT NULL CHECK (saledate > TO_DATE ('01-JAN-1990','DD-MON-YYYY')),
      serial      CHAR(8)     CONSTRAINT saleinv_serial_fk NOT NULL REFERENCES car(serial),
      totalprice  NUMBER(9,2),
      discount    NUMBER(9,2),
      net         NUMBER(9,2),
      tax         NUMBER(8,2),
      licfee      NUMBER(6,2),
      commission  NUMBER(8,2),
      tradeserial CHAR(8)     CONSTRAINT saleinv_tradeserial_fk REFERENCES car(serial),
      tradeallow  NUMBER(9,2),
      fire        CHAR(1)     CHECK (fire IN ('Y','N')),
      collision   CHAR(1)     CHECK (collision IN ('Y','N')),
      liability   CHAR(1)     CHECK (liability IN ('Y','N')),
      property    CHAR(1)     CHECK (property IN ('Y','N')));

CREATE TABLE options
(     ocode       CHAR(4)     CONSTRAINT options_ocode_pk PRIMARY KEY,
      odesc       CHAR(30),
      ocost       NUMBER(7,2),
      olist       NUMBER(7,2));

CREATE TABLE baseoption
(     serial      CHAR(8)     CONSTRAINT baseoption_serial_fk REFERENCES car(serial),
      ocode       CHAR(4)     CONSTRAINT baseoption_ocode_fk REFERENCES options(ocode),
                              CONSTRAINT baseoption_pk PRIMARY KEY(serial,ocode));

CREATE TABLE invoption
(     saleinv     CHAR(6)     CONSTRAINT invoption_saleinv_fk NOT NULL REFERENCES saleinv(saleinv),
      ocode       CHAR(4)     CONSTRAINT invoption_ocode_fk NOT NULL REFERENCES options(ocode),
      saleprice   NUMBER(7,2) NOT NULL,
                              UNIQUE (saleinv,ocode));

CREATE TABLE servinv
(     servinv     CHAR(5)     CONSTRAINT servinv_servinv_pk PRIMARY KEY,
      serdate     DATE        NOT NULL,     
      cname       CHAR(20)    CONSTRAINT serinv_cname_fk NOT NULL REFERENCES customer(cname),
      serial      CHAR(8)     CONSTRAINT servinv_serial_fk NOT NULL REFERENCES car(serial),
      partscost   NUMBER(7,2),
      laborcost   NUMBER(7,2),
      tax         NUMBER(6,2),
      totalcost   NUMBER(8,2));

CREATE TABLE servwork
(     servinv     CHAR(5)     CONSTRAINT servwork_servinv_fk REFERENCES servinv(servinv),
      workdesc    CHAR(80),
                              CONSTRAINT servwork_pk PRIMARY KEY (servinv,workdesc));

CREATE TABLE prospect
(     cname       CHAR(20)    CONSTRAINT prospect_cname_fk NOT NULL REFERENCES customer(cname),
      make        CHAR(10)    NOT NULL CHECK (make IN ('ACURA','MERCEDES','LAND ROVER','JAGUAR')),
      model       CHAR(8),
      cyear       CHAR(4),
      color       CHAR(12),
      trim        CHAR(16),
      ocode       CHAR(4)     CONSTRAINT prospect_ocode_fk REFERENCES OPTIONS(OCODE),
                              UNIQUE (cname,make,model,cyear,color,trim,ocode));

CREATE TABLE employee
(     empname     CHAR(20)    CONSTRAINT employee_empname_pk PRIMARY KEY,
      startdate   DATE        NOT NULL,
      manager     CHAR(20)    CONSTRAINT employee_manager_fk REFERENCES employee(empname),
      commissionrate NUMBER(2),
      title       CHAR(26));