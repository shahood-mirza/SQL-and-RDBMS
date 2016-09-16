-- PL/SQL Trigger
-- Shahood Mirza

--Trigger 1--

CREATE OR REPLACE TRIGGER tt
BEFORE INSERT OR UPDATE OF serial, make, model, color ON car
FOR EACH ROW
BEGIN
   :new.cname  := UPPER(:new.cname);
   :new.make   := UPPER(:new.make);
   :new.model  := UPPER(:new.model);
   :new.color  := UPPER(:new.color);
END;
/

--Trigger 2--

CREATE OR REPLACE TRIGGER cartrig
BEFORE DELETE OR INSERT OR UPDATE
ON carlog
FOR EACH ROW
BEGIN
   IF INSERTING THEN
      INSERT INTO CARLOG
      VALUES ('INSERT', USER, SYSDATE, :NEW.SERIAL);
   END IF;
   IF UPDATING THEN
      INSERT INTO CARLOG
      VALUES ('UPDATE', USER, SYSDATE, :OLD.SERIAL);
   END IF;
   IF DELETING THEN
      INSERT INTO CARLOG
      VALUES ('DELETE', USER, SYSDATE, :OLD.SERIAL);
   END IF;
END;
/