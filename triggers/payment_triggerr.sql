create or replace TRIGGER payment_triggerr
AFTER INSERT ON payment 
FOR EACH ROW 
WHEN(new.py_id > 0)
DECLARE
    row_count int;
  order_id int;
  addr varchar(255); 
  CURSOR o_order IS 
      SELECT o_id FROM order_info WHERE c_id = :new.c_id;
  cursor c_cust IS
       SELECT address FROM customer WHERE c_id = :new.c_id;
BEGIN
    OPEN o_order;
    OPEN c_cust; 
    LOOP 
        FETCH o_order INTO order_id; 
        FETCH c_cust INTO addr;
        select count(*) into row_count from tracking;
        INSERT INTO tracking VALUES(row_count+1, order_id, :new.c_id, 'in process', addr);
        EXIT WHEN o_order%NOTFOUND OR c_cust%NOTFOUND; 
    END LOOP; 
    CLOSE o_order;
    CLOSE c_cust; 
END;
-- insert into payment values(50,3,12,323);
/