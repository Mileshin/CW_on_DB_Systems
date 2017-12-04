create or replace package bus_deport_pkg is

  function addTypesBuses(
    new_brand varchar,
    new_model varchar,
    new_seats number) return number;
  procedure deleteTypesBuses(del_id in number);

   function addPOSITIONS(
    new_name varchar,
    new_abb varchar) return number;
  procedure deletePOSITIONS(del_id in number);

end bus_deport_pkg;
/

create or replace package body bus_deport_pkg is
  function addTypesBuses(
    new_brand varchar,
    new_model varchar,
    new_seats number) return number is
    newID number;
    begin
      insert into types_of_buses(brand,model,seats)
        VALUES (NEW_brand, NEW_model, NEW_seats);
      newID:=type_buses_seq.currval;
      commit;
      return newID;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          return null;
    end;

  procedure deleteTypesBuses(del_id in number) as
    begin
      delete from types_of_buses d where d.id = del_id;
        commit;
    end;

  function addPOSITIONS(
    new_name varchar,
    new_abb varchar) return number is
    newID number;
    begin
      insert into POSITIONS(name,abb)
        VALUES (new_name, new_abb);
      newID:=position_seq.currval;
      commit;
      return newID;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          return null;
    end;

  procedure deletePOSITIONS(del_id in number) as
    begin
      delete from POSITIONS d where d.id = del_id;
        commit;
    end;

end bus_deport_pkg;
/
