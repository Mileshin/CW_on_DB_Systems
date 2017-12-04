set serveroutput on;
DECLARE
  new_bus_type_id number;
  new_POSITIONS_id number;
BEGIN
 DBMS_OUTPUT.enable;
 new_bus_type_id := bus_deport_pkg.addTypesBuses('BAW','BAW 2245',30);
 DBMS_OUTPUT.put_line('new bus type id ' || new_bus_type_id);
 bus_deport_pkg.deleteTypesBuses(new_bus_type_id);
END;
/  
