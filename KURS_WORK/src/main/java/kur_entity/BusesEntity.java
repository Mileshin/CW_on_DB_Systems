package kur_entity;

import javax.persistence.*;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Scanner;

/**
 * Created by Andrey on 09.12.2017.
 */

@Entity
@Table(name = "BUSES", schema = "TESTUSER", catalog = "")
public class BusesEntity {
    private int id;
    private String NUMBER_PLATE;
    private int BUS_TYPE;
    private int BRIGADE;
    private int ROUTE;
    private Date LAST_VEHICLE_INSPECTION;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    @Basic
    @Column(name = "BUS_TYPE")
    public int getBUS_TYPE() {
        return BUS_TYPE;
    }
    public void setBUS_TYPE(int BUS_TYPE) {
        this.BUS_TYPE = BUS_TYPE;
    }

    @Basic
    @Column(name = "NUMBER_PLATE")
    public String getNUMBER_PLATE() {
        return NUMBER_PLATE;
    }

    public void setNUMBER_PLATE(String NUMBER_PLATE) {
        this.NUMBER_PLATE = NUMBER_PLATE;
    }

    @Basic
    @Column(name = "BRIGADE")
    public int getBRIGADE() {
        return BRIGADE;
    }
    public void setBRIGADE(int BRIGADE) {
        this.BRIGADE = BRIGADE;
    }

    @Basic
    @Column(name = "ROUTE")
    public int getROUTE() {
        return ROUTE;
    }
    public void setROUTE(int ROUTE) {
        this.ROUTE = ROUTE;
    }

    @Basic
    @Column(name = "LAST_VEHICLE_INSPECTION")
    public Date getLAST_VEHICLE_INSPECTION() {
        return LAST_VEHICLE_INSPECTION;
    }
    public void setLAST_VEHICLE_INSPECTION(Date LAST_VEHICLE_INSPECTION) {
        this.LAST_VEHICLE_INSPECTION = LAST_VEHICLE_INSPECTION;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BusesEntity that = (BusesEntity) o;

        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (NUMBER_PLATE != null ? NUMBER_PLATE.hashCode() : 0);
        return result;
    }

    public BusesEntity(){}

    public BusesEntity(Boolean ask, int l) throws ParseException {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("NUMBER_PLATE:");
        this.NUMBER_PLATE = sc.nextLine();
        System.out.println("BUS_TYPE:");
        this.BUS_TYPE = sc.nextInt();
        sc.nextLine();
        System.out.println("BRIGADE:");
        this.BRIGADE = sc.nextInt();
        sc.nextLine();
        System.out.println("ROUTE:");
        this.ROUTE = sc.nextInt();
        sc.nextLine();

        System.out.println("LAST_VEHICLE_INSPECTION(format \"MMMM d, yyyy\"):");
        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
        this.LAST_VEHICLE_INSPECTION = format.parse(sc.nextLine());
    }
}
