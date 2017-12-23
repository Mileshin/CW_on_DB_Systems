create or replace package bus_deport_pkg is

  function addTypesBuses(
    new_brand varchar,
    new_model varchar,
    new_seats number) return number;
  procedure deleteTypesBuses(del_id in number);



  procedure addPOSITIONS(
    new_name IN varchar,
    new_abb IN varchar,
    new_id out number);
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

  procedure addDRIVER_AND_PERSON(
    new_surname in varchar,
    new_name in varchar,
    new_middle_name in varchar,
    new_DATE_OF_BIRTH in DATE,
    new_DATE_MEDICAL_CHECK_UP in DATE,
    new_VIOLATIONS in CLOB,
    new_id out number);

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

  function addSCHEDULE(
    new_ID_BRIGADE NUMBER,
    START_WORK_SHIFT DATE,
    STOP_WORK_SHIFT DATE
    ) return number;
  procedure deleteSCHEDULE(del_id in number);

  function addBUSES(
    new_NUMBER_PLATE varchar,
    new_BUS_TYPE NUMBER,
    new_BRIGADE NUMBER,
    new_ROUTE  NUMBER,
    new_LAST_VEHICLE_INSPECTION DATE
    ) return number;
  procedure deleteBUSES(del_id in number);

  function addBREAKDOWN(
    new_ID_BUS NUMBER,
    new_DATE_BREAKDOWN DATE,
    new_DESCRIPTION CLOB
    ) return number;
  procedure deleteBREAKDOWN(del_id in number);

  function addREPAIRS(
    new_ID_BREAKDOWN NUMBER,
    new_START_DATE DATE,
    new_END_DATE DATE,
    new_ID_MECHANIC NUMBER,
    new_CONCLUSION CLOB
    ) return number;
  procedure deleteREPAIRS(del_id in number);

end bus_deport_pkg;
/

create or replace package body bus_deport_pkg is
  -- types of byses --
    function addTypesBuses(
      new_brand varchar,
      new_model varchar,
      new_seats number) return number is
      newID number;
      begin
        insert into types_of_buses(brand,model,seats)
          VALUES (NEW_brand, NEW_model, NEW_seats)
        returning id into newID;
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
    procedure addPOSITIONS(
      new_name IN varchar,
      new_abb IN varchar,
      new_id out number) as
       begin
        insert into POSITIONS(name,abb)
          VALUES (new_name, new_abb)
        returning id into new_id;
        commit;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            null;
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
        values(new_surname,new_name,new_middle_name,new_DATE_OF_BIRTH,id_p)
        returning id into newID;
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
        values(new_id_people, new_DATE_MEDICAL_CHECK_UP,new_VIOLATIONS)
        returning id into newID;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

      procedure addDRIVER_AND_PERSON(
      new_surname in varchar,
      new_name in varchar,
      new_middle_name in varchar,
      new_DATE_OF_BIRTH in DATE,
      new_DATE_MEDICAL_CHECK_UP in DATE,
      new_VIOLATIONS in CLOB,
      new_id out number) aS
      newID number;

      begin
        newID:=addPEOPLE(new_surname,new_name,new_middle_name,new_DATE_OF_BIRTH,'Водитель');
        insert into DRIVERS (ID_PEOPLE, DATE_MEDICAL_CHECK_UP, VIOLATIONS)
        values(newID, new_DATE_MEDICAL_CHECK_UP,new_VIOLATIONS)
        returning id into new_id;
        commit;

        EXCEPTION
          WHEN NO_DATA_FOUND THEN
             null;
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
          VALUES (new_name)
        returning id into newID;
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
          VALUES (START_STATION,STOP_STATION,LIST_OF_STATIONS)
        returning id into newID;
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


  -- SCHEDULE --
    function addSCHEDULE(
      new_ID_BRIGADE NUMBER,
      START_WORK_SHIFT DATE,
      STOP_WORK_SHIFT DATE
      ) return number is
      newID number;
      begin
        INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
          VALUES (new_ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
        returning id into newID;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

    procedure deleteSCHEDULE(del_id in number) as
      begin
        delete from SCHEDULE d where d.id = del_id;
          commit;
      end;

  -- BUSES --
    function addBUSES(
      new_NUMBER_PLATE varchar,
      new_BUS_TYPE NUMBER,
      new_BRIGADE NUMBER,
      new_ROUTE  NUMBER,
      new_LAST_VEHICLE_INSPECTION DATE
      ) return number is
      newID number;
      begin
        insert into BUSES (NUMBER_PLATE, BUS_TYPE, BRIGADE, ROUTE, LAST_VEHICLE_INSPECTION)
          VALUES (new_NUMBER_PLATE,new_BUS_TYPE,new_BRIGADE,new_ROUTE,new_LAST_VEHICLE_INSPECTION)
        returning id into newID;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

    procedure deleteBUSES(del_id in number) as
      begin
        delete from BUSES d where d.id = del_id;
          commit;
      end;

  -- BREAKDOWN --
    function addBREAKDOWN(
      new_ID_BUS NUMBER,
      new_DATE_BREAKDOWN DATE,
      new_DESCRIPTION CLOB
      ) return number is
      newID number;
      begin
        insert into BREAKDOWN (ID_BUS, DATE_BREAKDOWN, DESCRIPTION)
          VALUES (new_ID_BUS,new_DATE_BREAKDOWN,new_DESCRIPTION)
        returning id into newID;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

    procedure deleteBREAKDOWN(del_id in number) as
      begin
        delete from BREAKDOWN d where d.id = del_id;
          commit;
      end;


  -- REPAIRS --
    function addREPAIRS(
      new_ID_BREAKDOWN NUMBER,
      new_START_DATE DATE,
      new_END_DATE DATE,
      new_ID_MECHANIC NUMBER,
      new_CONCLUSION CLOB
      ) return number is
      newID number;
      begin
        INSERT INTO REPAIRS(ID_BREAKDOWN,START_DATE,END_DATE,ID_MECHANIC,CONCLUSION)
          VALUES (new_ID_BREAKDOWN,new_START_DATE,new_END_DATE,new_ID_MECHANIC,new_CONCLUSION)
        returning id into newID;
        commit;
        return newID;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            return null;
      end;

    procedure deleteREPAIRS(del_id in number) as
      begin
        delete from REPAIRS d where d.id = del_id;
          commit;
      end;


end bus_deport_pkg;
/
