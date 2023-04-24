create or replace TRIGGER product_trigger
BEFORE INSERT ON product
FOR EACH ROW
DECLARE
  name_length NUMBER;
  prod_name product.name%TYPE;
  too_short EXCEPTION;
BEGIN
  prod_name := :new.name;
  name_length := LENGTH(prod_name);
  
  IF name_length < 5 THEN
    RAISE too_short;
    
  END IF;
  
EXCEPTION
  WHEN too_short THEN
    raise_application_error(-20001
                , 'Error: name must bet more than 5 characters');
    
END;

-- insert into product values(33, 'Test', 5, 100, 1);
/