set serveroutput on;
DECLARE
  new_bus_type_id number;
  new_POSITIONS_id number;
  NEW_person_ID NUMBER;
  count_id NUMBER;
  NEW_driver_ID number;
  NEW_BRIGADES_ID number;
  NEW_ROUTES_ID number;
  NEW_SCHEDULE_ID number;
  NEW_BUSES_ID number;
  NEW_BREAKDOWN_ID number;
  NEW_REPAIRS_ID number;


BEGIN
 DBMS_OUTPUT.enable;
-- types of byses --
 DBMS_OUTPUT.put_line('TEST TYPES_OF_BUSES FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 new_bus_type_id := bus_deport_pkg.addTypesBuses('BAW','BAW 2245',30);
 DBMS_OUTPUT.put_line('new bus type id ' || new_bus_type_id);
 select count(id) into count_id from TYPES_OF_BUSES where ID=new_bus_type_id AND BRAND='BAW'
 AND MODEL = 'BAW 2245' AND SEATS=30;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_bus_type_id||' in the table TYPES_OF_BUSES exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_bus_type_id||' in the table TYPES_OF_BUSES not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE BUS TYPE '|| new_bus_type_id);
 bus_deport_pkg.deleteTypesBuses(new_bus_type_id);
 select count(id) into count_id from TYPES_OF_BUSES where ID=new_bus_type_id AND BRAND='BAW'
 AND MODEL = 'BAW 2245' AND SEATS=30;
   if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_bus_type_id||' in the table TYPES_OF_BUSES exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_bus_type_id||' in the table TYPES_OF_BUSES not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

-- positions --
 DBMS_OUTPUT.put_line('TEST POSITIONS FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 new_POSITIONS_id := bus_deport_pkg.addPOSITIONS('test position', 'tp');
 DBMS_OUTPUT.put_line('new position id ' || new_POSITIONS_id);
 select count(id) into count_id from positions where ID=new_POSITIONS_id AND name='test position'
 and abb='tp';
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_POSITIONS_id||' in the table POSITIONS exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_POSITIONS_id||' in the table POSITIONS not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE POSITION '|| new_POSITIONS_id);
 bus_deport_pkg.deletePOSITIONS(new_POSITIONS_id);
 select count(id) into count_id from positions where ID=new_POSITIONS_id AND name='test position'
 and abb='tp';
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_POSITIONS_id||' in the table POSITIONS exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_POSITIONS_id||' in the table POSITIONS not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

-- people --
 DBMS_OUTPUT.put_line('TEST PEOPLE FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 NEW_person_ID := bus_deport_pkg.addPEOPLE('Милешин','Андрей','Александрович',
  TO_DATE('1997/03/08', 'yyyy/mm/dd'),'Уборщик');
 DBMS_OUTPUT.put_line('new person id ' || NEW_person_ID);
 select count(id) into count_id from people where ID=NEW_person_ID;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_person_ID||' in the table PEOPLE exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_person_ID||' in the table PEOPLE not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE PERSON '|| NEW_person_ID);
 bus_deport_pkg.deletePEOPLE(NEW_person_ID);
  select count(id) into count_id from people where ID=NEW_person_ID;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_person_ID||' in the table PEOPLE exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_person_ID||' in the table PEOPLE not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

 -- drivers --
 DBMS_OUTPUT.put_line('TEST DRIVERS FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 NEW_person_ID := bus_deport_pkg.addPEOPLE('Милешин','Андрей','Александрович',
  TO_DATE('1997/03/08', 'yyyy/mm/dd'),'Водитель');
 NEW_driver_ID := bus_deport_pkg.addDRIVERS(NEW_person_ID,TO_DATE('1997/03/08', 'yyyy/mm/dd'),'НЕТ НАРУШЕНИЙ');
 DBMS_OUTPUT.put_line('new DRIVER id ' || NEW_driver_ID);
 select count(id) into count_id from DRIVERS where ID=NEW_driver_ID;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_driver_ID||' in the table DRIVERS exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_driver_ID||' in the table DRIVERS not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE DRIVER '|| NEW_driver_ID);
 bus_deport_pkg.deleteDRIVERS(NEW_driver_ID);
 select count(id) into count_id from DRIVERS where ID=NEW_driver_ID;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_driver_ID||' in the table DRIVERS exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_driver_ID||' in the table DRIVERS not exists');
   end if;

  NEW_driver_ID := bus_deport_pkg.addDRIVERS_AND_PERSON('Милешин','Андрей','Александрович',
  TO_DATE('1997/03/08', 'yyyy/mm/dd'),TO_DATE('1997/03/08', 'yyyy/mm/dd'),'НЕТ');
  DBMS_OUTPUT.put_line('new DRIVER id ' || NEW_driver_ID);
  select count(id) into count_id from DRIVERS where ID=NEW_driver_ID;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_driver_ID||' in the table DRIVERS exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||NEW_driver_ID||' in the table DRIVERS not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

 -- BRIGADES --
 DBMS_OUTPUT.put_line('TEST BRIGADES FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 new_BRIGADES_id := bus_deport_pkg.addBRIGADES('test BRIGADE');
 DBMS_OUTPUT.put_line('new BRIGADE id ' || new_BRIGADES_id);
 select count(id) into count_id from BRIGADES where ID=new_BRIGADES_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_BRIGADES_id||' in the table BRIGADES exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_BRIGADES_id||' in the table BRIGADES not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE BRIGADES '|| new_BRIGADES_id);
 bus_deport_pkg.deleteBRIGADES(new_BRIGADES_id);
 select count(id) into count_id from BRIGADES where ID=new_BRIGADES_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_BRIGADES_id||' in the table BRIGADES exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_BRIGADES_id||' in the table BRIGADES not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');


 -- ROUTES --
 DBMS_OUTPUT.put_line('TEST ROUTES FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 new_ROUTES_id := bus_deport_pkg.addROUTES('start', 'stop','start-stop');
 DBMS_OUTPUT.put_line('new ROUTES id ' || new_ROUTES_id);
 select count(id) into count_id from ROUTES where ID=new_ROUTES_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_ROUTES_id||' in the table ROUTES exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_ROUTES_id||' in the table ROUTES not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE ROUTES '|| new_ROUTES_id);
 bus_deport_pkg.deleteROUTES(new_ROUTES_id);
 select count(id) into count_id from ROUTES where ID=new_ROUTES_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_ROUTES_id||' in the table ROUTES exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_ROUTES_id||' in the table ROUTES not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

 -- ROUTES --
 DBMS_OUTPUT.put_line('TEST SCHEDULE FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 new_BRIGADES_id := bus_deport_pkg.addBRIGADES('test SCHEDULE');
 new_SCHEDULE_id := bus_deport_pkg.addSCHEDULE(new_BRIGADES_id, sysdate,sysdate);
 DBMS_OUTPUT.put_line('new SCHEDULE id ' || new_SCHEDULE_id);
 select count(id) into count_id from SCHEDULE where ID=new_SCHEDULE_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_SCHEDULE_id||' in the table SCHEDULE exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_SCHEDULE_id||' in the table SCHEDULE not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE SCHEDULE '|| new_SCHEDULE_id);
 bus_deport_pkg.deleteSCHEDULE(new_SCHEDULE_id);
 select count(id) into count_id from SCHEDULE where ID=new_SCHEDULE_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_SCHEDULE_id||' in the table SCHEDULE exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_SCHEDULE_id||' in the table SCHEDULE not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

 -- BUSES --
 DBMS_OUTPUT.put_line('TEST BUSES FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 new_bus_type_id := bus_deport_pkg.addTypesBuses('BAW','BAW 22453',30);
 new_BUSES_id := bus_deport_pkg.addBUSES('k000kk',new_bus_type_id,NULL,NULL,sysdate);
 DBMS_OUTPUT.put_line('new BUSES id ' || new_BUSES_id);
 select count(id) into count_id from BUSES where ID=new_BUSES_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_BUSES_id||' in the table BUSES exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_BUSES_id||' in the table BUSES not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE BUSES '|| new_BUSES_id);
 bus_deport_pkg.deleteBUSES(new_BUSES_id);
 bus_deport_pkg.deleteTypesBuses(new_bus_type_id);
 select count(id) into count_id from BUSES where ID=new_BUSES_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_BUSES_id||' in the table BUSES exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_BUSES_id||' in the table BUSES not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

 -- BREAKDOWN --
 DBMS_OUTPUT.put_line('TEST BREAKDOWN FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 new_bus_type_id := bus_deport_pkg.addTypesBuses('BAW','BAW 22453',30);
 new_BUSES_id := bus_deport_pkg.addBUSES('k000kk',new_bus_type_id,NULL,NULL,sysdate);
 new_BREAKDOWN_id := bus_deport_pkg.addBREAKDOWN(new_BUSES_id,sysdate,'NO INFO');
 DBMS_OUTPUT.put_line('new BREAKDOWN id ' || new_BREAKDOWN_id);
 select count(id) into count_id from BREAKDOWN where ID=new_BREAKDOWN_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_BREAKDOWN_id||' in the table BREAKDOWN exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_BREAKDOWN_id||' in the table BREAKDOWN not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE BREAKDOWN '|| new_BREAKDOWN_id);
 bus_deport_pkg.deleteBREAKDOWN(new_BREAKDOWN_id);
 bus_deport_pkg.deleteBUSES(new_BUSES_id);
 bus_deport_pkg.deleteTypesBuses(new_bus_type_id);
 select count(id) into count_id from BREAKDOWN where ID=new_BREAKDOWN_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_BREAKDOWN_id||' in the table BREAKDOWN exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_BREAKDOWN_id||' in the table BREAKDOWN not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

 -- REPAIRS --
 DBMS_OUTPUT.put_line('TEST REPAIRS FUNCTION');
 DBMS_OUTPUT.put_line('-----------------------------');
 NEW_person_ID := bus_deport_pkg.addPEOPLE('Милешин','Андрей','Александрович',
  TO_DATE('1997/03/08', 'yyyy/mm/dd'),'Механик');
 new_bus_type_id := bus_deport_pkg.addTypesBuses('BAW','BAW 22453',30);
 new_BUSES_id := bus_deport_pkg.addBUSES('k000kk',new_bus_type_id,NULL,NULL,sysdate);
 new_BREAKDOWN_id := bus_deport_pkg.addBREAKDOWN(new_BUSES_id,sysdate,'NO INFO');
 new_REPAIRS_id := bus_deport_pkg.addREPAIRS(new_BREAKDOWN_id,sysdate,sysdate,NEW_person_ID,NULL);
 DBMS_OUTPUT.put_line('new REPAIRS id ' || new_REPAIRS_id);
 select count(id) into count_id from REPAIRS where ID=new_REPAIRS_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_REPAIRS_id||' in the table REPAIRS exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_REPAIRS_id||' in the table REPAIRS not exists');
   end if;

 DBMS_OUTPUT.put_line('DELETE REPAIRS '|| new_REPAIRS_id);
 bus_deport_pkg.deleteREPAIRS(new_REPAIRS_id);
 bus_deport_pkg.deleteBREAKDOWN(new_BREAKDOWN_id);
 bus_deport_pkg.deleteBUSES(new_BUSES_id);
 bus_deport_pkg.deleteTypesBuses(new_bus_type_id);
 select count(id) into count_id from REPAIRS where ID=new_REPAIRS_id;
    if count_id!=0 then
     DBMS_OUTPUT.put_line('A new row with ID ' ||new_REPAIRS_id||' in the table REPAIRS exists');
     ELSE
       DBMS_OUTPUT.put_line('A new row with ID ' ||new_REPAIRS_id||' in the table REPAIRS not exists');
   end if;
 DBMS_OUTPUT.put_line('-----------------------------');

END;

/
