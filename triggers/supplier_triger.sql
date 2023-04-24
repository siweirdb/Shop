create or replace TRIGGER supplier_triger
BEFORE INSERT ON supplier 
FOR EACH ROW 
WHEN(new.p_id > 0)
declare
v_exception EXCEPTION;
  PRAGMA EXCEPTION_INIT(v_exception, -2291);
BEGIN
    update stock set quantity = quantity + :new.quantity where stock.p_id = :new.p_id;
    exception
    WHEN  v_exception THEN
      insert into stock values(:new.sp_id, :new.quantity, :new.p_id);  
       
END;
/