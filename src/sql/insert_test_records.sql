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
