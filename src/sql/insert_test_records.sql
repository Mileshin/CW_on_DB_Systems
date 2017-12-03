---------------------------------------------------------
-- Типы автобусов
---------------------------------------------------------
insert into types_of_buses(brand,model,seats,characteristics)
values('ПАЗ','ПАЗ-32053-11',41,
characteristics_bus_type(310,2500,2900,7000,'1/726','ISUZU'));

insert into types_of_buses(brand,model,seats,characteristics)
values('ГолАЗ','АКА-6226',41,
characteristics_bus_type(334,2500,3100,17545,'4','Mercedes-Benz OM 447 hLA'));

insert into types_of_buses(brand,model,seats,characteristics)
values('Mercedes','Mercedes-Benz O405',41,
characteristics_bus_type(334,2500,3100,11100,'4','Mercedes-Benz OM 447 hLA'));

---------------------------------------------------------
--Должности
---------------------------------------------------------
insert into positions(name,abb)
values('Директор','ДР');

insert into positions(name,abb)
values('Водитель','ВД');

insert into positions(name,abb)
values('Кондуктор','КН');

insert into positions(name,abb)
values('Механик','МХ');

---------------------------------------------------------
--Люди
---------------------------------------------------------
insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Милешин','Андрей','Александрович',
  TO_DATE('1997/03/08', 'yyyy/mm/dd'),
  id from positions where name='Директор';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Волков','Роман','Александрович',
  TO_DATE('1980/07/18', 'yyyy/mm/dd'),
  id from positions where name='Водитель';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Кирсанов','Сергей','Александрович',
  TO_DATE('1995/09/28', 'yyyy/mm/dd'),
  id from positions where name='Кондуктор';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Коршунов','Геннадий','Александрович',
  TO_DATE('1980/07/18', 'yyyy/mm/dd'),
  id from positions where name='Водитель';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Булдаков', 'Олег','Александрович',
  TO_DATE('1980/07/18', 'yyyy/mm/dd'),
  id from positions where name='Водитель';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Князев', 'Игорь','Александрович',
  TO_DATE('1980/07/18', 'yyyy/mm/dd'),
  id from positions where name='Кондуктор';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Герасимов','Вячеслав','Александрович',
  TO_DATE('1980/07/18', 'yyyy/mm/dd'),
  id from positions where name='Кондуктор';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Клюквин','Александр','Александрович',
  TO_DATE('1980/07/18', 'yyyy/mm/dd'),
  id from positions where name='Механик';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Хазанович','Дмитрий','Александрович',
  TO_DATE('1980/07/18', 'yyyy/mm/dd'),
  id from positions where name='Механик';

insert into people(surname,name,middle_name,date_of_birth,position)
  select 'Заборовский','Юрий','Александрович',
  TO_DATE('1980/07/18', 'yyyy/mm/dd'),
  id from positions where name='Механик';

---------------------------------------------------------
--Водители
---------------------------------------------------------
insert into DRIVERS (ID_PEOPLE, DATE_MEDICAL_CHECK_UP, VIOLATIONS)
SELECT ID, to_date('19-05-2017', 'dd-mm-yyyy'), 'Проехал на красный.'
FROM PEOPLE WHERE SURNAME='Коршунов';

insert into DRIVERS (ID_PEOPLE, DATE_MEDICAL_CHECK_UP, VIOLATIONS)
SELECT ID, to_date('19-05-2017', 'dd-mm-yyyy'), ''
FROM PEOPLE WHERE SURNAME='Булдаков';

insert into DRIVERS (ID_PEOPLE, DATE_MEDICAL_CHECK_UP, VIOLATIONS)
SELECT ID, to_date('19-05-2017', 'dd-mm-yyyy'), ''
FROM PEOPLE WHERE SURNAME='Волков';

---------------------------------------------------------
--Бригады
---------------------------------------------------------
INSERT INTO BRIGADES(NAME)
values('Бригада №1');
INSERT INTO BRIGADES(NAME)
values('Бригада №2');
INSERT INTO BRIGADES(NAME)
values('Бригада №3');

---------------------------------------------------------
--Маршруты
---------------------------------------------------------
INSERT INTO ROUTES(START_STATION,STOP_STATION,LIST_OF_STATIONS)
VALUES('Наличная улица','Нарвский проспект','Наличная улица — Малый проспект В.О. — Гаванская улица — Средний проспект В.О. — Кадетская и 1-я линии В.О. — Университетская набережная — Благовещенский мост — площадь Труда — набережная Крюкова канала — (обратно: улица Труда) — улица Глинки — улица Декабристов — Английский проспект — проспект Римского-Корсакова — площадь Репина — Старо-Петергофский проспект — Нарвский проспект — (обратно: Старо-Петергофский проспект)');

INSERT INTO ROUTES(START_STATION,STOP_STATION,LIST_OF_STATIONS)
VALUES('улица Кораблестроителей','Невский проспект',' — Новосмоленская набережная — Наличная улица — Новосмоленская набережная — улица Кораблестроителей — Прибалтийская площадь — улица Нахимова — Наличная улица — Шкиперский проток — Гаванская улица — Большой проспект В.О. — Детская улица — Средний проспект В.О. — 22-23-я линии В.О. — Большой проспект В.О. — Кадетская и 1-я линии В.О. — Университетская набережная — Дворцовый мост — Дворцовый проезд — Невский проспект');

---------------------------------------------------------
--График
---------------------------------------------------------
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('03-12-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('03-12-2017 8:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №1';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('03-12-2017 08:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('03-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №2';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('03-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-12-2017 0:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №3';

INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('04-12-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-12-2017 8:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №1';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('04-12-2017 08:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('04-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №2';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('04-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-12-2017 0:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №3';

INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('05-12-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-12-2017 8:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №1';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('05-12-2017 08:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('05-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №2';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('05-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('06-12-2017 0:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №3';

INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('06-12-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('06-12-2017 8:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №1';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('06-12-2017 08:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('06-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №2';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('06-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-12-2017 0:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №3';

INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('07-12-2017 00:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-12-2017 8:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №1';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('07-12-2017 08:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('07-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №2';
INSERT INTO SCHEDULE(ID_BRIGADE,START_WORK_SHIFT,STOP_WORK_SHIFT)
SELECT ID, to_date('07-12-2017 16:00:00', 'dd-mm-yyyy hh24:mi:ss'), to_date('08-12-2017 0:00:00', 'dd-mm-yyyy hh24:mi:ss') FROM BRIGADES WHERE NAME='Бригада №3';

---------------------------------------------------------
--Автобусы
---------------------------------------------------------
insert into BUSES (NUMBER_PLATE, BUS_TYPE, BRIGADE, ROUTE, LAST_VEHICLE_INSPECTION)
select 'к345кк', tb.id, b.id, r.id, to_date('13-11-2017', 'dd-mm-yyyy')
   from types_of_buses tb, brigades b, routes r
   where tb.model='ПАЗ-32053-11' and b.name='Бригада №1' and r.start_station='улица Кораблестроителей';

insert into BUSES (NUMBER_PLATE, BUS_TYPE, BRIGADE, ROUTE, LAST_VEHICLE_INSPECTION)
select 'о355кк', tb.id, b.id, r.id, to_date('13-11-2017', 'dd-mm-yyyy')
   from types_of_buses tb, brigades b, routes r
   where tb.model='Mercedes-Benz O405' and b.name='Бригада №2' and r.start_station='улица Кораблестроителей';

insert into BUSES (NUMBER_PLATE, BUS_TYPE, BRIGADE, ROUTE, LAST_VEHICLE_INSPECTION)
select 'к215оу', tb.id, b.id, r.id, to_date('13-11-2017', 'dd-mm-yyyy')
   from types_of_buses tb, brigades b, routes r
   where tb.model='АКА-6226' and b.name='Бригада №3' and r.start_station='улица Кораблестроителей';

---------------------------------------------------------
--Поломки
---------------------------------------------------------
insert into BREAKDOWN (ID_BUS, DATA_BREAKDOWN, DESCRIPTION)
  select id,  to_date('13-06-2017', 'dd-mm-yyyy'), 'Разбито стекло'
  from buses where NUMBER_PLATE='к345кк';

insert into BREAKDOWN (ID_BUS, DATA_BREAKDOWN, DESCRIPTION)
  select id,  to_date('03-08-2017', 'dd-mm-yyyy'), 'Откаали тормоза'
  from buses where NUMBER_PLATE='о355кк';

insert into BREAKDOWN (ID_BUS, DATA_BREAKDOWN, DESCRIPTION)
  select id,  to_date('10-09-2017', 'dd-mm-yyyy'), 'Не работают дворники'
  from buses where NUMBER_PLATE='к215оу';

---------------------------------------------------------
--Ремонт
---------------------------------------------------------
INSERT INTO REPAIRS(ID_BREAKDOWN,START_DATA,END_DATE,ID_MECHANIC,CONCLUSION)
SELECT B.ID, to_date('13-06-2017', 'dd-mm-yyyy'), to_date('13-06-2017', 'dd-mm-yyyy'),
P.ID, 'И так сойдет!' FROM BREAKDOWN B, PEOPLE P
WHERE B.DATA_BREAKDOWN=to_date('13-06-2017', 'dd-mm-yyyy') AND
P.SURNAME='Хазанович';

INSERT INTO REPAIRS(ID_BREAKDOWN,START_DATA,END_DATE,ID_MECHANIC,CONCLUSION)
SELECT B.ID, to_date('03-08-2017', 'dd-mm-yyyy'), to_date('07-08-2017', 'dd-mm-yyyy'),
P.ID, 'И так сойдет!' FROM BREAKDOWN B, PEOPLE P
WHERE B.DATA_BREAKDOWN=to_date('03-08-2017', 'dd-mm-yyyy') AND
P.SURNAME='Клюквин';

INSERT INTO REPAIRS(ID_BREAKDOWN,START_DATA,END_DATE,ID_MECHANIC,CONCLUSION)
SELECT B.ID, to_date('10-09-2017', 'dd-mm-yyyy'), to_date('10-09-2017', 'dd-mm-yyyy'),
P.ID, 'И так сойдет!' FROM BREAKDOWN B, PEOPLE P
WHERE B.DATA_BREAKDOWN=to_date('10-09-2017', 'dd-mm-yyyy') AND
P.SURNAME='Заборовский';

---------------------------------------------------------
-- Водительские лицензии
---------------------------------------------------------
INSERT INTO DRIVING_LICENCE(ID_DRIVER,ID_LICENCE,DATE_OF_ISSUANCE,VALID_UNTIL)
SELECT D.ID, '13472', to_date('10-09-2010', 'dd-mm-yyyy'), to_date('10-09-2020', 'dd-mm-yyyy')
FROM DRIVERS D, PEOPLE P
WHERE D.ID_PEOPLE=P.ID AND P.SURNAME='Коршунов';

INSERT INTO DRIVING_LICENCE(ID_DRIVER,ID_LICENCE,DATE_OF_ISSUANCE,VALID_UNTIL)
SELECT D.ID, '13474', to_date('10-09-2010', 'dd-mm-yyyy'), to_date('10-09-2020', 'dd-mm-yyyy')
FROM DRIVERS D, PEOPLE P
WHERE D.ID_PEOPLE=P.ID AND P.SURNAME='Булдаков';

INSERT INTO DRIVING_LICENCE(ID_DRIVER,ID_LICENCE,DATE_OF_ISSUANCE,VALID_UNTIL)
SELECT D.ID, '13372', to_date('11-10-2011', 'dd-mm-yyyy'), to_date('11-10-2022', 'dd-mm-yyyy')
FROM DRIVERS D, PEOPLE P
WHERE D.ID_PEOPLE=P.ID AND P.SURNAME='Волков';

---------------------------------------------------------
-- связь бригад и людей (реализация связи многие ко многим)
---------------------------------------------------------
insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (1, 2);

insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (1, 3);

insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (1, 8);

insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (2, 4);

insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (2, 6);

insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (2, 9);

insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (3, 5);

insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (3, 7);

insert into BRIGADE_PEOPLE_LINK (ID_BRIGADES, ID_PEOPLE)
values (3, 10);
