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

  function addPEOPLE(
    new_surname varchar,
    new_name varchar,
    new_middle_name varchar,
    new_DATE_OF_BIRTH DATE,
    new_POSITION varchar) return number;
  procedure deletePEOPLE(del_id in number);

  function addDRIVERS(
    new_id_people number,
    new_DATE_MEDICAL_CHECK_UP DATE,
    new_VIOLATIONS CLOB) return number;
  procedure deleteDRIVERS(del_id in number);

  function addDRIVERS_AND_PERSON(
    new_surname varchar,
    new_name varchar,
    new_middle_name varchar,
    new_DATE_OF_BIRTH DATE,
    new_DATE_MEDICAL_CHECK_UP DATE,
    new_VIOLATIONS CLOB) return number;

  function addBRIGADES(
    new_NAME varchar
    ) return number;
  procedure deleteBRIGADES(del_id in number);

  function addROUTES(
    START_STATION varchar,
    STOP_STATION varchar,
    LIST_OF_STATIONS CLOB
    ) return number;
  procedure deleteROUTES(del_id in number);


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

    create or replace package body bus_deport_pkg is
  -- types of byses --
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
  -- positions --
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

  -- people --
    function addPEOPLE(
      new_surname varchar,
      new_name varchar,
      new_middle_name varchar,
      new_DATE_OF_BIRTH DATE,
      new_POSITION varchar) return number is
      newID number;
      id_p number;
      count_id number;
      begin
        select count(id) into count_id from POSITIONS where name=new_POSITION;
        if count_id=0 then
          insert into POSITIONS(NAME,ABB) values (new_POSITION, SUBSTR(new_POSITION,1,3));
        end if;
        select id into id_p from POSITIONS where name=new_POSITION;
        insert into people(surname,name,middle_name,date_of_birth,position)
        values(new_surname,new_name,new_middle_name,new_DATE_OF_BIRTH,id_p);
        newID:=people_seq.currval;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;
    procedure deletePEOPLE(del_id in number) as
      begin
        delete from people d where d.id = del_id;
        commit;
      end;

   -- drivers --
     function addDRIVERS(
      new_id_people number,
      new_DATE_MEDICAL_CHECK_UP DATE,
      new_VIOLATIONS CLOB) return number is
      newID number;
      begin
        insert into DRIVERS (ID_PEOPLE, DATE_MEDICAL_CHECK_UP, VIOLATIONS)
        values(new_id_people, new_DATE_MEDICAL_CHECK_UP,new_VIOLATIONS);
        newID:=drivers_seq.currval;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

      function addDRIVERS_AND_PERSON(
      new_surname varchar,
      new_name varchar,
      new_middle_name varchar,
      new_DATE_OF_BIRTH DATE,
      new_DATE_MEDICAL_CHECK_UP DATE,
      new_VIOLATIONS CLOB) return number IS
      newID number;
      begin
        newID:=addPEOPLE(new_surname,new_name,new_middle_name,new_DATE_OF_BIRTH,'Водитель');
        insert into DRIVERS (ID_PEOPLE, DATE_MEDICAL_CHECK_UP, VIOLATIONS)
        values(newID, new_DATE_MEDICAL_CHECK_UP,new_VIOLATIONS);
        newID:=drivers_seq.currval;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

    procedure deleteDRIVERS(del_id in number) as
     begin
        delete from DRIVERS d where d.id = del_id;
          commit;
     end;


  -- BRIGADES --
    function addBRIGADES(
      new_NAME varchar
      ) return number is
      newID number;
      begin
        insert into BRIGADES(name)
          VALUES (new_name);
        newID:=brigades_seq.currval;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

    procedure deleteBRIGADES(del_id in number) as
      begin
        delete from BRIGADES d where d.id = del_id;
          commit;
      end;


  -- ROUTES --
    function addROUTES(
      START_STATION varchar,
      STOP_STATION varchar,
      LIST_OF_STATIONS CLOB
      ) return number is
      newID number;
      begin
        INSERT INTO ROUTES(START_STATION,STOP_STATION,LIST_OF_STATIONS)
          VALUES (START_STATION,STOP_STATION,LIST_OF_STATIONS);
        newID:=routers_seq.currval;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

    procedure deleteROUTES(del_id in number) as
      begin
        delete from ROUTES d where d.id = del_id;
          commit;
      end;
  end bus_deport_pkg;
/
