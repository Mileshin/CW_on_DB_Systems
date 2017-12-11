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
@Table(name = "TYPES_OF_BUSES", schema = "TESTUSER", catalog = "")
public class TypesOfBusesEntity {
    private int id;
    private String BRAND;
    private String MODEL;
    private int SEATS;
    private Object CHARACTERISTICS;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    @Basic
    @Column(name = "SEATS")
    public int getSEATS() {
        return SEATS;
    }
    public void setSEATS(int SEATS) {
        this.SEATS = SEATS;
    }

    @Basic
    @Column(name = "BRAND")
    public String getBRAND() {
        return BRAND;
    }

    public void setBRAND(String BRAND) {
        this.BRAND = BRAND;
    }

    @Basic
    @Column(name = "MODEL")
    public String getMODEL() {
        return MODEL;
    }

    public void setMODEL(String MODEL) {
        this.MODEL = MODEL;
    }

    /*@Basic
    @Column(name = "CHARACTERISTICS")
    public String getCHARACTERISTICS() {
        return CHARACTERISTICS;
    }

    public void setCHARACTERISTICS(String CHARACTERISTICS) {
        this.CHARACTERISTICS = CHARACTERISTICS;
    }*/


    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TypesOfBusesEntity that = (TypesOfBusesEntity) o;

        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (MODEL != null ? MODEL.hashCode() : 0);
        return result;
    }

    public TypesOfBusesEntity(){}

    public TypesOfBusesEntity(Boolean ask, int l) throws ParseException {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("BRAND:");
        this.BRAND = sc.nextLine();
        System.out.println("MODEL:");
        this.MODEL = sc.nextLine();
        System.out.println("SEATS:");
        this.SEATS = sc.nextInt();
        sc.nextLine();
        /*System.out.println("CHARACTERISTICS:");
        this.CHARACTERISTICS = sc.nextLine();*/
        }
}
