
import kur_entity.*;


import javax.persistence.*;
import java.lang.reflect.Field;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


public class Main {

    private static final int TABLESCOUNT = 12;
    static EntityManager entityManager;

    static PositionsEntity Positions;
    private static ArrayList<String> tables = new ArrayList<String>();
    private static ArrayList<String> commands = new ArrayList<String>();

    private static String hql;
    private static Scanner sc = new Scanner(System.in);

    public static void main(final String[] args) throws Exception {
        EntityManagerFactory busDeport = Persistence.createEntityManagerFactory("busDeport");
        entityManager = busDeport.createEntityManager();
        addNames();

        while(true) {
            int command = getCommand();
            if(command != 5) {
                int table = getTable();
                if (table == TABLESCOUNT) continue;
                switch (command) {
                    case 1:
                        createMethod(table);
                        break;
                    case 2:
                        readMethod(table);
                        break;
                    case 3:
                        updateMethod(table);
                        break;
                    case 4:
                        deleteMethod(table);
                        break;
                }
            } else {
                packageMethod();
            }
        }
    }

    private static void createMethod(Integer n) throws IllegalAccessException, ParseException, SQLException {
        Object entity=null;
        int maxId=0;
        hql = "SELECT f FROM "+tables.get(n)+"Entity f";
        TypedQuery<Object[]> query = entityManager.createQuery(hql,Object[].class);
        List<Object[]> results = query.getResultList();
        for(Object someObject: results)
            for (Field field : someObject.getClass().getDeclaredFields()) {
                field.setAccessible(true); // You might want to set modifier to public first.
                Object value = field.get(someObject);
                if(field.getName().equals("id"))
                    if(maxId< ((Integer) value))
                        maxId=((Integer) value);
            }
        int len = maxId;
        len++;
        switch (n) {
            case 1:
                entity = new PositionsEntity(true,len);
                break;
            case 2:
                entity = new PeopleEntity(true,len);
                break;
            case 3:
                entity = new DriversEntity(true,len);
                break;
            case 4:
                entity = new BrigadesEntity(true,len);
                break;
            case 5:
                entity = new RotesEntity(true,len);
                break;
            case 6:
                entity = new SheduleEntity(true,len);
                break;
            case 7:
                entity = new BusesEntity(true,len);
                break;
            case 8:
                entity = new BreakdownEntity(true,len);
                break;
            case 9:
                entity = new RepairsEntity(true,len);
                break;
            case 10:
                entity = new DrivingLicenceEntity(true,len);
                break;
            case 11:
                entity = new TypesOfBusesEntity(true,len);
                break;

            default:
                entity = null;
        }
        if (entity != null) {
            try {
                entityManager.getTransaction().begin();
                entityManager.persist(entity);
                entityManager.getTransaction().commit();
            }
            catch (  Exception ex) {
                System.out.println("EXCEPTIION: " + ex.getMessage());
                entityManager.getTransaction().rollback();
            }
        }
    }

    private static void readMethod(Integer n) throws IllegalAccessException, SQLException {
        hql = "SELECT f FROM "+tables.get(n)+"Entity f";
        TypedQuery<Object[]> query = entityManager.createQuery(hql,Object[].class);
        List<Object[]> results = query.getResultList();
        for(Object someObject: results) {
            for (Field field : someObject.getClass().getDeclaredFields()) {
                field.setAccessible(true); // You might want to set modifier to public first.
                Object value = field.get(someObject);
                if (value != null) {
                    System.out.println(field.getName() + "=" + value);
                }
            }
            System.out.println();
        }
    }

    private static void updateMethod(Integer n) throws IllegalAccessException, ParseException {
        int pk;
        System.out.println("Введите id");
        while(true) {
            if (sc.hasNextInt()) {
                pk = sc.nextInt();
                break;
            }
            else{
                System.out.println("Введите корректный id");
            }
        }


        Object myObject = null;
        hql = "SELECT f FROM "+tables.get(n)+"Entity f";
        TypedQuery<Object[]> query = entityManager.createQuery(hql,Object[].class);
        List<Object[]> results = query.getResultList();
        for(Object someObject: results)
            for (Field field : someObject.getClass().getDeclaredFields()) {
                field.setAccessible(true); // You might want to set modifier to public first.
                Object value = field.get(someObject);
                if(field.getName().equals("id"))
                    if(value.equals(pk))
                        myObject=someObject;
            }

        if(myObject==null) {
            System.out.println("Нет такого id");
            return;
        }

        try {
            entityManager.getTransaction().begin();
            hql = "UPDATE " + tables.get(n) + "Entity AS c SET ";
            for (Field field : myObject.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                if (!field.getName().equals("id") && !field.getName().equals("CHARACTERISTICS"))
                    hql += field.getName() + " = :" + field.getName() + field.getName() + ", ";
            }
            hql = hql.substring(0, hql.length() - 2);
            hql += " WHERE c.id = :p";
            //Query query2 = entityManager.createQuery("UPDATE "+tables.get(n)+"Entity c SET c.name = :newname WHERE c.id = :p");
            Query query2 = entityManager.createQuery(hql);
            sc.nextLine();
            for (Field field : myObject.getClass().getDeclaredFields()) {
                field.setAccessible(true);
                if (!field.getName().equals("id") && !field.getName().equals("CHARACTERISTICS")) {
                    String type = field.getType().getSimpleName();
                    System.out.println("Введите " + field.getName());
                    if (type.equals("int")) {
                        query2.setParameter(field.getName() + field.getName(), sc.nextInt());
                        sc.nextLine();
                    }
                    if (type.equals("String"))
                        query2.setParameter(field.getName() + field.getName(), sc.nextLine());
                    if (type.equals("Date") && n != 6) {
                        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
                        Date date = format.parse(sc.nextLine());
                        query2.setParameter(field.getName() + field.getName(), date);
                    }
                    if (type.equals("Date") && n == 6) {
                        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.ENGLISH);
                        Date date = format.parse(sc.nextLine());
                        query2.setParameter(field.getName() + field.getName(), date);
                    }
                }
            }

            query2.setParameter("p", pk);
            int updateCount = query2.executeUpdate();
            System.out.println(updateCount);
            entityManager.getTransaction().commit();
        }
        catch (  Exception ex) {
            System.out.println("EXCEPTIION: " + ex.getMessage());
            entityManager.getTransaction().rollback();
        }
    }
    private static void deleteMethod(Integer n) throws SQLException {
        int pk;
        System.out.println("Введите primary key");
        while(true) {
            if (sc.hasNextInt()){
                pk = sc.nextInt();
                break;
            }else {
                System.out.println("Введите корректный primary key");
            }

        }

        Object entity;
        switch (n) {
            case 1:
                entity = entityManager.find(PositionsEntity.class, pk);
                break;
            case 2:
                entity = entityManager.find(PeopleEntity.class, pk);
                break;
            case 3:
                entity = entityManager.find(DriversEntity.class, pk);
                break;
            case 4:
                entity = entityManager.find(BrigadesEntity.class, pk);
                break;
            case 5:
                entity = entityManager.find(RotesEntity.class, pk);
                break;
            case 6:
                entity = entityManager.find(SheduleEntity.class, pk);
                break;
            case 7:
                entity = entityManager.find(BusesEntity.class, pk);
                break;
            case 8:
                entity = entityManager.find(BreakdownEntity.class, pk);
                break;
            case 9:
                entity = entityManager.find(RepairsEntity.class, pk);
                break;
            case 10:
                entity = entityManager.find(DrivingLicenceEntity.class, pk);
                break;
            case 11:
                entity = entityManager.find(TypesOfBusesEntity.class, pk);
                break;

            default:
                entity = null;

        }

        if (entity != null) {
            try {
                entityManager.getTransaction().begin();
                entityManager.remove(entity);
                entityManager.getTransaction().commit();
            }
            catch (  Exception ex) {
                System.out.println("EXCEPTIION: " + ex.getMessage());
                entityManager.getTransaction().rollback();
            }
        }

    }

    private static void packageMethod() throws IllegalAccessException, SQLException {
        System.out.println("Выберите процедуру:");
        System.out.println("1 Add position.");
        System.out.println("2 Delete position.");
        System.out.println("3 Delete position.");

        int i;
        while(true) {
           if (sc.hasNextInt()){
               i = sc.nextInt();
               if (i<1 || i>3){
                   System.out.println("Введите корректный номер");
               }
               else {
                   break;
               }
            }else {
                System.out.println("Введите корректный номер");
            }
        }
        try {
            switch (i) {
                case 1: {
                    StoredProcedureQuery query = entityManager.createStoredProcedureQuery("bus_deport_pkg.addPOSITIONS");
                    query.registerStoredProcedureParameter("new_name", String.class, ParameterMode.IN);
                    query.registerStoredProcedureParameter("new_abb", String.class, ParameterMode.IN);
                    query.registerStoredProcedureParameter("new_id", Integer.class, ParameterMode.OUT);
                    sc.nextLine();
                    System.out.println("name:");
                    String new_name = sc.nextLine();
                    System.out.println("abbreviation:");
                    String new_abb = sc.nextLine();
                    query.setParameter("new_name", new_name);
                    query.setParameter("new_abb", new_abb);
                    query.execute();
                    int newID = (Integer) query.getOutputParameterValue("new_id");
                    System.out.println("Новый ID: "+newID);
                }
                break;
                case 2: {
                    StoredProcedureQuery query = entityManager.createStoredProcedureQuery("bus_deport_pkg.deletePOSITIONS");
                    query.registerStoredProcedureParameter("del_id", Integer.class, ParameterMode.IN);
                    System.out.println("id:");
                    int del_id = sc.nextInt();
                    query.setParameter("del_id", del_id);
                    query.execute();
                }
                break;
                case 3:
                {
                    StoredProcedureQuery query = entityManager.createStoredProcedureQuery("bus_deport_pkg.addDRIVER_AND_PERSON");
                    query.registerStoredProcedureParameter("new_surname", String.class, ParameterMode.IN);
                    query.registerStoredProcedureParameter("new_name", String.class, ParameterMode.IN);
                    query.registerStoredProcedureParameter("new_middle_name", String.class, ParameterMode.IN);
                    query.registerStoredProcedureParameter("new_DATE_OF_BIRTH", Date.class, ParameterMode.IN);
                    query.registerStoredProcedureParameter("new_DATE_MEDICAL_CHECK_UP", Date.class, ParameterMode.IN);
                    query.registerStoredProcedureParameter("new_VIOLATIONS", String.class, ParameterMode.IN);
                    query.registerStoredProcedureParameter("new_id", Integer.class, ParameterMode.OUT);
                    sc.nextLine();
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
                    System.out.println("Suname:");
                    String new_surname = sc.nextLine();
                    System.out.println("Name:");
                    String new_name = sc.nextLine();
                    System.out.println("Middle name:");
                    String new_middle_name = sc.nextLine();
                    System.out.println("Date of birth (fomat \"yyyy-MM-dd\"):");
                    Date new_DATE_OF_BIRTH = format.parse(sc.nextLine());
                    System.out.println("Date of medical check up (fomat \"yyyy-MM-dd\"):");
                    Date new_DATE_MEDICAL_CHECK_UP = format.parse(sc.nextLine());
                    System.out.println("Violations:");
                    String new_VIOLATIONS = sc.nextLine();

                    query.setParameter("new_surname", new_surname);
                    query.setParameter("new_name", new_name);
                    query.setParameter("new_middle_name", new_middle_name);
                    query.setParameter("new_DATE_OF_BIRTH", new_DATE_OF_BIRTH);
                    query.setParameter("new_DATE_MEDICAL_CHECK_UP", new_DATE_MEDICAL_CHECK_UP);
                    query.setParameter("new_VIOLATIONS", new_VIOLATIONS);
                    query.execute();
                    int newID = (Integer) query.getOutputParameterValue("new_id");
                    System.out.println("Новый ID: "+newID);
                }
                break;
                default:
                    break;
            }
        }
        catch (  Exception ex) {
            System.out.println("При выполнении процедуры произошла ошибка.");
            System.out.println("EXCEPTIION: " + ex.getMessage());
        }
    }


    private static  void addNames(){
        tables.add("");
        tables.add("Positions");
        tables.add("People");
        tables.add("Drivers");
        tables.add("Brigades");
        tables.add("Rotes");
        tables.add("Shedule");
        tables.add("Buses");
        tables.add("Breakdown");
        tables.add("Repairs");
        tables.add("DrivingLicence");
        tables.add("TypesOfBuses");

        commands.add("");
        commands.add("Create");
        commands.add("Read");
        commands.add("Update");
        commands.add("Delete");
        commands.add("Package");
    }


    private static int getCommand() {
        System.out.println("Выберете команду:");
        for(int a=1;a<6;a++)
            System.out.println(a+". "+commands.get(a));
        int i=0;
        while(true) {
            if (sc.hasNextInt()){
                i = sc.nextInt();
                //sc.nextLine();
                if (i < 1 || i > 5) {
                    System.out.println("Вы ввели неверный номер команды");
                } else {
                    break;
                }
            }
            else
                System.out.println("Введите корректный номер команды");
                sc.nextLine();
            }
        return i;
    }

    private static int getTable(){
        sc.nextLine();
        System.out.println("Выберете Таблицу:");
        for(int a=1;a<TABLESCOUNT;a++)
            System.out.println(a+". "+tables.get(a));
        System.out.println(TABLESCOUNT+". Вернуться к выбору команды");
        int i=0;
        while (true){
            if (sc.hasNextInt()){
                i = sc.nextInt();
                if (i < 1 || i > TABLESCOUNT) {
                    System.out.println("Вы ввели неверный номер таблицы");
                } else {
                    break;
                }
            } else {
                System.out.println("Введите корректный номер таблицы");
                sc.nextLine();
            }
        }
        return i;
    }

}
