create or replace TRIGGER order_triger
BEFORE INSERT ON order_info
FOR EACH ROW 
WHEN(new.o_id > 0)
declare
row_count int;
BEGIN
    select count(*) into row_count from order_info;
    dbms_output.put_line(row_count); 
END;
/