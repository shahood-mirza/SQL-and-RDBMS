CREATE OR REPLACE PROCEDURE getcar
   (v_serial   IN    car.serial%TYPE,
    v_make     OUT   car.make%TYPE,
    v_model    OUT   car.model%TYPE,
    v_year     OUT   car.cyear%TYPE,
    v_color    OUT   car.color%TYPE,
    v_list     OUT   car.listprice%TYPE)
AS
BEGIN
   SELECT make, model, cyear, color, listprice
      INTO v_make, v_model, v_year, v_color, v_list
      FROM car
   WHERE serial=v_serial;
END;