---------------------------------------------------------
-- Типы автобусов
---------------------------------------------------------
CREATE SEQUENCE type_buses_seq increment by 1 start with 1;

CREATE TABLE TYPES_OF_BUSES(
		ID NUMBER,
		BRAND VARCHAR(256),
		MODEL VARCHAR(256),
		SEATS NUMBER NOT NULL,
		CHARACTERISTICS CLOB,
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
		NAME VARCHAR(256) NOT NULL UNIQUE,
		ABB VARCHAR(6) NOT NULL UNIQUE,
		CONSTRAINT pk_positions PRIMARY KEY (ID)
);

CREATE OR REPLACE TRIGGER position_insert
BEFORE INSERT ON POSITIONS FOR EACH ROW
BEGIN
	SELECT position_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/

INSERT INTO POSITIONS(ID, NAME, ABB) VALUES(1,'Andrey Mileshin', 'M.A.A.');

---------------------------------------------------------
--Люди
---------------------------------------------------------

CREATE OR REPLACE TYPE NAME_TYPE AS OBJECT
( 		SURNAME VARCHAR(128),
		NAME VARCHAR(128),
		MIDDLE_NAME VARCHAR(128));
/
CREATE SEQUENCE people_seq increment by 1 start with 1;

CREATE TABLE PEOPLE(
		ID NUMBER,
		NAME NAME_TYPE NOT NULL,
		DATE_OF_BIRTH DATE NOT NULL,
		POSITION NUMBER NOT NULL,
		CONSTRAINT pk_people PRIMARY KEY (ID),
		CONSTRAINT people_fk_position FOREIGN KEY (POSITION)
		REFERENCES POSITIONS(ID) ON DELETE CASCADE
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
		ID_PEOPLE NUMBER NOT NULL,
		DRIVING_EXPERIENCE DATE NOT NULL,
		DRIVING_LINENCE_NO NUMBER NOT NULL,
		DATE_MEDICAL_CHECK_UP DATE NOT NULL,
		CHARACTERISTIC CLOB,
		VIOLATIONS CLOB,
		CONSTRAINT pk_drivers PRIMARY KEY (ID),
		CONSTRAINT drivers_fk_people FOREIGN KEY (ID_PEOPLE)
		REFERENCES PEOPLE(ID) ON DELETE CASCADE
);

CREATE OR REPLACE TRIGGER drivers_insert
BEFORE INSERT ON DRIVERS FOR EACH ROW
BEGIN
	SELECT drivers_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/


---------------------------------------------------------
--Бригады
---------------------------------------------------------
CREATE SEQUENCE brigades_seq increment by 1 start with 1;

CREATE TABLE BRIGADES(
		ID NUMBER NOT NULL UNIQUE,
		ID_DRIVER1 NUMBER NOT NULL,
		ID_DRIVER2 NUMBER NOT NULL,
		ID_CONDUCTOR1 NUMBER NOT NULL,
		ID_CONDUCTOR2 NUMBER NOT NULL,
		ID_MECHANIC NUMBER NOT NULL,
        PRIMARY KEY(ID_DRIVER1, ID_DRIVER2, ID_CONDUCTOR1, ID_CONDUCTOR2, ID_MECHANIC),
		CONSTRAINT brigades_fk_driver1 FOREIGN KEY (ID_DRIVER1)
		REFERENCES DRIVERS(ID) ON DELETE CASCADE,
		CONSTRAINT brigades_fk_driver2 FOREIGN KEY (ID_DRIVER2)
		REFERENCES DRIVERS(ID) ON DELETE CASCADE,
		CONSTRAINT brigades_fk_conductor1 FOREIGN KEY (ID_CONDUCTOR1)
		REFERENCES PEOPLE(ID) ON DELETE CASCADE,
		CONSTRAINT brigades_fk_conductor2 FOREIGN KEY (ID_CONDUCTOR2)
		REFERENCES PEOPLE(ID) ON DELETE CASCADE,
		CONSTRAINT brigades_fk_mechanic FOREIGN KEY (ID_MECHANIC)
		REFERENCES PEOPLE(ID) ON DELETE CASCADE
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
		START_STATION VARCHAR(256) NOT NULL,
		STOP_STATION VARCHAR(256) NOT NULL,
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
		START_WORK_SHIFT DATE,
		STOP_WORK_SHIFT DATE,
		LIST_OF_STATIONS CLOB,
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
		ROUTE	NUMBER,
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
		DATA_BREAKDOWN DATE NOT NULL,
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
		START_DATA DATE NOT NULL,
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
BEGIN
	SELECT repairs_seq.NEXTVAL INTO :NEW.ID  FROM dual;
END;
/

exit;
