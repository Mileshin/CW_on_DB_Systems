1. Автобусы BUSES
		Номер Автобуса                                                    ID NUMBER
		Гос. номер                                                        NUMBER_PLATE CHAR(6) NOT NULL UNIQUE
		Тип                   Зависит от Таблицы 2 Типы автобусов         BUS_TYPE NUMBER NOT NULL
		Бригада               Зависит от таблицы 6 Бригады                BRIGADE NUMBER
		Маршрут               Зависит от таблицы 7 Маршруты               ROUTE NUMBER
		Дата Последнего ТО                                                VEHICLE_INSPECTION DATE NOT NULL
2. Типы автобусов
		Номер типа                                                        ID  NUMBER                                                   
		Марка                                                             BRAND VARCHAR(255),
		Модель                                                            MODEL VARCHAR(255),
		Число мест                                                        SEATS NUMBER NOT NULL,
		Характеристики                                                    CHARACTERISTICS  свой тип,
3. Люди
		Табельный номер                                                   ID NUMBER                                                          
		Имя                                                               NAME свой тип NOT NULL                                                         
		Дата рождения                                                     DATA_OF_BIRTH DATA NOT NULL,
		Должность             Зависит от Талицы 5 Должности               POSITION NUMBER NOT NULL,
4. Водители
		Номер водителя                                                    ID NUMBER
		Табельный номер       Зависит от Таблицы 3 Люди                   ID_PEOPLE NOT NULL
		Дата мед. осмотра                                                 MEDICAL_CHECK_UP DATE NOT NULL
		Нарушения                                                         VIOLATIONS CLOB
5. Должности
		Номер должности                                                   ID NUMBER,
		Название                                                          NAME VARCHAR(255),
		Аббревиатура                                                      ABBREVIATION VARCHAR(6),
6. Бригады
    Номер бригады                                                     ID NUMBER,
    Название                                                          NAME VARCHAR(255),
    Эмблема                                                           EMBLEM BLOB
7. Маршруты
		Номер маршрута                                                    ID NUMBER,
		Начальная остановка                                               START_STATION VARCHAR(255),
		Конечная остановка                                                STOP_STATION VARCHAR(255),  
		Список остановок                                                  LIST_OF_STATIONS
8. График работы
		Номер записи                                                      ID NUMBER,
		Номер бригады           Зависит от таблицы 6 бригады              ID_BRIGADE NUMBER,
		Начало смены                                                      START_WORK_SHIFT TIME,                                   
		Окончание смены                                                   STOP_WORK_SHIFT TIME
9. Поломки
		id поломки                                                        ID   NUMBER,                                           
		Номер автобуса          Зависит от таблицы 1 автобусы             ID_BUS NUMBER,
		Дата поломки                                                      DATE_BREAKDOWN DATE,
		Описание                                                          DESCRIPTION
10. Ремонт
		id ремонта                                                        ID NUMBER,
    ID поломки            зависит от таблицы 9 поломки                ID_BREAKDOWN NUMBER,
		Дата начала ремонта                                               START_DATE DATE,
		Дата окончания ремонта                                            END_DATE DATE,
		Табельный номер мастера (связан с люди)                           ID_MECHANIC NUMBER,                                    
		Заключение                                                        CONCLUSION CLOB
11. Водительская лицензия
    Номер записи                                                     ID NUMBER,
    Номер водителя        Зависит от Таблицы 4 водители              ID_DRIVER NUMBER,
    Номер лицензии                                                   ID_LICENCE NUMBER,                                               
    Дата выдачи                                                      DATE_OF_ISSUANCE DATE,
    Дата окончания                                                   VALID_UNTIL DATE

12.  BRIGADE_PEOPLE_LINK
    ID_BRIGADES NUMBER   Зависит от таблицы 6 бригады
    ID_PEOPLE NUMBER     Зависит от таблицы 3 люди
