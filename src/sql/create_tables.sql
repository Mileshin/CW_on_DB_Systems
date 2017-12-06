---------------------------------------------------------
-- Собственный тип, характеристик автобуса
---------------------------------------------------------
CREATE OR REPLACE TYPE CHARACTERISTICS_BUS_TYPE AS OBJECT
( 	FUEL_TANK NUMBER,
		WIDTH NUMBER,
		HEIGHT NUMBER,
		LENGTH NUMBER,
		DOORS VARCHAR(255),
		ENGINE VARCHAR(255)
	);
/
---------------------------------------------------------
-- Типы автобусов
---------------------------------------------------------
CREATE SEQUENCE type_buses_seq increment by 1 start with 1;

CREATE TABLE TYPES_OF_BUSES(
		ID NUMBER,
		BRAND VARCHAR(255),
		MODEL VARCHAR(255),
		SEATS NUMBER NOT NULL,
		CHARACTERISTICS CHARACTERISTICS_BUS_TYPE,
		CONSTRAINT pk_type_buses PRIMARY KEY (ID)
);

CREATE OR REPLACE TRIGGER type_buses_insert
BEFORE INSERT ON TYPES_OF_BUSES FOR EACH ROW
BEGIN
	SELECT type_buses_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/


---------------------------------------------------------
--Должности
---------------------------------------------------------
CREATE SEQUENCE position_seq increment by 1 start with 1;

CREATE TABLE POSITIONS(
    ID NUMBER,
    NAME VARCHAR(255) NOT NULL UNIQUE,
    ABB VARCHAR(6) NOT NULL UNIQUE,
    CONSTRAINT pk_positions PRIMARY KEY (ID)
);

CREATE OR REPLACE TRIGGER position_insert
BEFORE INSERT ON POSITIONS FOR EACH ROW
BEGIN
  SELECT position_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/

---------------------------------------------------------
--Люди
---------------------------------------------------------

CREATE SEQUENCE people_seq increment by 1 start with 1;

CREATE TABLE PEOPLE(
    ID NUMBER,
		SURNAME VARCHAR(128)  NOT NULL,
		NAME VARCHAR(128)  NOT NULL,
		MIDDLE_NAME VARCHAR(128),
    DATE_OF_BIRTH DATE NOT NULL,
    POSITION NUMBER NOT NULL,
    CONSTRAINT pk_people PRIMARY KEY (ID),
    CONSTRAINT people_fk_position FOREIGN KEY (POSITION)
    REFERENCES POSITIONS(ID)
);

CREATE OR REPLACE TRIGGER people_insert
BEFORE INSERT ON PEOPLE FOR EACH ROW
BEGIN
  SELECT people_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/

---------------------------------------------------------
--Водители
---------------------------------------------------------
CREATE SEQUENCE drivers_seq increment by 1 start with 1;

CREATE TABLE DRIVERS(
    ID NUMBER,
    ID_PEOPLE NUMBER NOT NULL UNIQUE,
    DATE_MEDICAL_CHECK_UP DATE NOT NULL,
    VIOLATIONS CLOB,
    CONSTRAINT pk_drivers PRIMARY KEY (ID),
    CONSTRAINT drivers_fk_people FOREIGN KEY (ID_PEOPLE)
    REFERENCES PEOPLE(ID) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER drivers_insert
BEFORE INSERT ON DRIVERS FOR EACH ROW
DECLARE
   id_d NUMBER;
   id_p NUMBER;
BEGIN
  SELECT POSITION INTO id_p FROM PEOPLE WHERE ID=:NEW.ID_PEOPLE;
  SELECT ID INTO id_d FROM POSITIONS WHERE NAME='Водитель';
  IF(id_d=id_p)
  THEN
      SELECT drivers_seq.NEXTVAL INTO :NEW.ID  FROM dual;
  ELSE
    RAISE_APPLICATION_ERROR(-20009, 'Это не водитель !!!');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER drivers_update
BEFORE UPDATE ON DRIVERS FOR EACH ROW
DECLARE
   id_d NUMBER;
   id_p NUMBER;
BEGIN
  SELECT POSITION INTO id_p FROM PEOPLE WHERE ID=:NEW.ID_PEOPLE;
  SELECT ID INTO id_d FROM POSITIONS WHERE NAME='Водитель';
  IF(id_d != id_p)
  THEN
       RAISE_APPLICATION_ERROR(-20009, 'Это не водитель !!!');
  END IF;
END;
/


---------------------------------------------------------
--Бригады
---------------------------------------------------------
CREATE SEQUENCE brigades_seq increment by 1 start with 1;

CREATE TABLE BRIGADES(
  ID NUMBER,
  NAME VARCHAR(255) NOT NULL,
  EMBLEM BLOB,
  CONSTRAINT pk_brigades PRIMARY KEY (ID)
);

CREATE OR REPLACE TRIGGER brigades_insert
BEFORE INSERT ON BRIGADES FOR EACH ROW
BEGIN
  SELECT brigades_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/

---------------------------------------------------------
--Маршруты
---------------------------------------------------------
CREATE SEQUENCE routers_seq increment by 1 start with 1;

CREATE TABLE ROUTES(
    ID NUMBER,
    START_STATION VARCHAR(255) NOT NULL,
    STOP_STATION VARCHAR(255) NOT NULL,
    LIST_OF_STATIONS CLOB NOT NULL,
    CONSTRAINT pk_routers PRIMARY KEY (ID)
);

CREATE OR REPLACE TRIGGER routers_insert
BEFORE INSERT ON ROUTES FOR EACH ROW
BEGIN
  SELECT routers_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/


---------------------------------------------------------
--График
---------------------------------------------------------
CREATE SEQUENCE shedule_seq increment by 1 start with 1;

CREATE TABLE SCHEDULE(
    ID NUMBER,
    ID_BRIGADE NUMBER NOT NULL,
    START_WORK_SHIFT DATE  NOT NULL,
    STOP_WORK_SHIFT DATE  NOT NULL,
    CONSTRAINT pk_shedule PRIMARY KEY (ID),
    CONSTRAINT shedule_fk_brigades FOREIGN KEY (ID_BRIGADE)
    REFERENCES BRIGADES(ID) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER shedule_insert
BEFORE INSERT ON SCHEDULE FOR EACH ROW
BEGIN
  SELECT shedule_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/

---------------------------------------------------------
--Автобусы
---------------------------------------------------------
CREATE SEQUENCE buses_seq increment by 1 start with 1;

CREATE TABLE BUSES(
    ID NUMBER,
    NUMBER_PLATE CHAR(6) NOT NULL UNIQUE,
    BUS_TYPE NUMBER NOT NULL,
    BRIGADE NUMBER,
    ROUTE  NUMBER,
    LAST_VEHICLE_INSPECTION DATE NOT NULL,
    CONSTRAINT pk_buses PRIMARY KEY (ID),
    CONSTRAINT buses_fk_bus_type FOREIGN KEY (BUS_TYPE)
    REFERENCES TYPES_OF_BUSES(ID) ON DELETE SET NULL,
    CONSTRAINT buses_fk_brigades FOREIGN KEY (BRIGADE)
    REFERENCES BRIGADES(ID) ON DELETE SET NULL,
    CONSTRAINT buses_fk_routes FOREIGN KEY (ROUTE)
    REFERENCES ROUTES(ID) ON DELETE SET NULL
);

CREATE OR REPLACE TRIGGER buses_insert
BEFORE INSERT ON BUSES FOR EACH ROW
BEGIN
  SELECT buses_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/


---------------------------------------------------------
--Поломки
---------------------------------------------------------
CREATE SEQUENCE breakdown_seq increment by 1 start with 1;

CREATE TABLE BREAKDOWN(
    ID NUMBER,
    ID_BUS NUMBER NOT NULL,
    DATE_BREAKDOWN DATE NOT NULL,
    DESCRIPTION CLOB NOT NULL,
    CONSTRAINT pk_breakdown PRIMARY KEY (ID),
    CONSTRAINT breakdown_fk_buses FOREIGN KEY (ID_BUS)
    REFERENCES BUSES(ID) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER breakdown_insert
BEFORE INSERT ON BREAKDOWN FOR EACH ROW
BEGIN
  SELECT breakdown_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/

---------------------------------------------------------
--Ремонт
---------------------------------------------------------
CREATE SEQUENCE repairs_seq increment by 1 start with 1;

CREATE TABLE REPAIRS(
    ID NUMBER,
    ID_BREAKDOWN NUMBER NOT NULL,
    START_DATE DATE NOT NULL,
    END_DATE DATE NOT NULL,
    ID_MECHANIC NUMBER NOT NULL,
    CONCLUSION CLOB,
    CONSTRAINT pk_repairs PRIMARY KEY (ID),
    CONSTRAINT repairs_fk_breakdown FOREIGN KEY (ID_BREAKDOWN)
    REFERENCES BREAKDOWN(ID) ON DELETE CASCADE,
    CONSTRAINT repairs_fk_mechanic FOREIGN KEY (ID_MECHANIC)
    REFERENCES PEOPLE(ID) ON DELETE CASCADE
);


CREATE OR REPLACE TRIGGER repairs_insert
BEFORE INSERT ON REPAIRS FOR EACH ROW
DECLARE
   id_d NUMBER;
   id_p NUMBER;
BEGIN
  SELECT POSITION INTO id_p FROM PEOPLE WHERE ID=:NEW.ID_MECHANIC;
  SELECT ID INTO id_d FROM POSITIONS WHERE NAME='Механик';
  IF(id_d=id_p)
  THEN
      SELECT repairs_seq.NEXTVAL INTO :NEW.ID  FROM dual;
  ELSE
    RAISE_APPLICATION_ERROR(-20011, 'Это не механик !!!');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER repairs_update
BEFORE UPDATE ON REPAIRS FOR EACH ROW
DECLARE
   id_d NUMBER;
   id_p NUMBER;
BEGIN
  SELECT POSITION INTO id_p FROM PEOPLE WHERE ID=:NEW.ID_MECHANIC;
  SELECT ID INTO id_d FROM POSITIONS WHERE NAME='Механик';
  IF(id_d != id_p)
  THEN
       RAISE_APPLICATION_ERROR(-20011, 'Это не механик !!!');
  END IF;
END;
/

CREATE OR REPLACE TRIGGER people_update
BEFORE UPDATE ON PEOPLE FOR EACH ROW
DECLARE
   id_d NUMBER;
   id_p NUMBER;
BEGIN
  SELECT ID INTO id_d FROM POSITIONS WHERE NAME='Водитель';
  select ID INTO id_p from DRIVERS where :NEW.ID=ID_PEOPLE;
  IF((id_d != :NEW.POSITION) and (id_p >0))
  THEN
       RAISE_APPLICATION_ERROR(-20010, 'Данная запись должна быть о водителе. Проверьте данные в таблице DRIVERS');
  END IF;
  SELECT ID INTO id_d FROM POSITIONS WHERE NAME='Механик';
  IF((id_d != :NEW.POSITION) and (id_p >0))
  THEN
       RAISE_APPLICATION_ERROR(-20012, 'Данная запись должна быть о механике. Проверьте данные в таблице DRIVERS');
  END IF;
END;
/
---------------------------------------------------------
-- Водительские лицензии
---------------------------------------------------------
CREATE SEQUENCE driving_licence_seq increment by 1 start with 1;

CREATE TABLE DRIVING_LICENCE(
    ID NUMBER,
    ID_DRIVER NUMBER NOT NULL,
    ID_LICENCE NUMBER NOT NULL UNIQUE,
    DATE_OF_ISSUANCE DATE NOT NULL,
    VALID_UNTIL DATE NOT NULL,
    CONSTRAINT pk_driving_licence PRIMARY KEY (ID),
    CONSTRAINT driving_licence_fk_drivers FOREIGN KEY (ID_DRIVER)
    REFERENCES DRIVERS(ID) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER driving_licence_insert
BEFORE INSERT ON DRIVING_LICENCE FOR EACH ROW
BEGIN
  SELECT driving_licence_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/

---------------------------------------------------------
-- связь бригад и людей (реализация связи многие ко многим)
---------------------------------------------------------

CREATE TABLE BRIGADE_PEOPLE_LINK(
    ID_BRIGADES NUMBER,
    ID_PEOPLE NUMBER,
    CONSTRAINT pk_BRIGADE_PEOPLE_LINK PRIMARY KEY (ID_BRIGADES,ID_PEOPLE),
    CONSTRAINT BP_LINK_fk_brigades FOREIGN KEY (ID_BRIGADES)
    REFERENCES BRIGADES(ID) ON DELETE CASCADE,
    CONSTRAINT BRIGADE_PEOPLE_LINK_fk_people FOREIGN KEY (ID_PEOPLE)
    REFERENCES PEOPLE(ID) ON DELETE CASCADE
);
