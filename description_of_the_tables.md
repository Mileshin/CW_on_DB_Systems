1. Автобусы BUSES
| Имя параметра   | Название столбца  |
| --------------- | ----------------  |
| Номер Автобуса  | ID                |
| Гос. номер      | NUMBER_PLATE      |
| Тип             | BUS_TYPE          |
| Бригада         | BRIGADE           |
| Маршрут         | ROUTE             |
+ Дата Последнего ТО
ID NUMBER
NUMBER_PLATE CHAR(6) NOT NULL UNIQUE,
BUS_TYPE NUMBER NOT NULL,
BRIGADE NUMBER,
ROUTE	NUMBER,
2. Типы автобусов
		Номер типа                                                        ID NUMBER                                                   
		Марка                                                             BRAND VARCHAR(255),
		Модель                                                            MODEL VARCHAR(255),
		Число мест                                                        SEATS NUMBER NOT NULL,
		Характеристики                                                    CHARACTERISTICS CLOB,
3. Люди
		Табельный номер                                                   ID NUMBER
		Фамилия                                                           SURNAME VARCHAR(128) NOT NULL,
		Имя                                                               NAME VARCHAR(128) NOT NULL,
		Отчество                                                          MIDDLE_NAME VARCHAR(128) NOT NULL,
		Дата рождения                                                     DATA_OF_BIRTH DATA NOT NULL,
		Должность             Зависит от Талицы 5 Должности               POSITION NUMBER NOT NULL,
4. Водители
		Номер водителя                                                    ID NUMBER
		Табельный номер       Зависит от Таблицы 3 Люди                   ID_PEOPLE NOT NULL
		Водительский стаж                                                 DATE NOT NULL
		Серия и номер прав                                                NUMBER NOT NULL
		Дата мед. осмотра                                                 DATE NOT NULL
		Характеристика водителя                                           CLOB
		Нарушения                                                         CLOB
5. Должности
		Номер должности                                                   ID NUMBER
		Название                                                          NAME VARCHAR(255)
		Аббревиатура                                                      ABBREVIATION VARCHAR(6)
6. Бригады
		Номер бригады                                                     ID NUMBER
		Первый водитель       Зависит от Таблицы 4 водители               ID_DRIVER1 NUMBER
		Второй водитель       Зависит от Таблицы 4 водители               ID_DRIVER2 NUMBER
		Первый Кондуктор      Зависит от Таблицы 3 Люди                   ID_CONDUCTOR1 NUMBER
		Второй Кондуктор      Зависит от Таблицы 3 Люди                   ID_CONDUCTOR2 NUMBER
		Ответственный  механик     Зависит от Таблицы 3 Люди              ID_MECHANIC NUMBER
7. Маршруты
		Номер маршрута
		Начальная остановка
		Конечная остановка
		Список остановок
8. График работы
		Номер записи
		Номер бригады
		Начало смены
		Окончание смены
9. Поломки
		id поломки
		Номер автобуса
		Дата поломки
		Тип поломки
		Описание
10. Ремонт
		id ремонта
		Дата начала ремонта
		Дата окончания ремонта
		Табельный номер мастера (связан с люди)
		Стоимость
		Заключение
