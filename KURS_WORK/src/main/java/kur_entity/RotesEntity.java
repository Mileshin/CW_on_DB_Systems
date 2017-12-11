package kur_entity;

import javax.persistence.*;
import java.util.Scanner;

/**
 * Created by Andrey on 09.12.2017.
 */
@Entity
@Table(name = "ROUTES", schema = "TESTUSER", catalog = "")
public class RotesEntity {
    private int id;
    private String START_STATION;
    private String STOP_STATION;
    private String LIST_OF_STATIONS;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "START_STATION")
    public String getSTART_STATION() {
        return START_STATION;
    }

    public void setSTART_STATION(String START_STATION) {
        this.START_STATION = START_STATION;
    }

    @Basic
    @Column(name = "STOP_STATION")
    public String getSTOP_STATION() {
        return STOP_STATION;
    }

    public void setSTOP_STATION(String STOP_STATION) {
        this.STOP_STATION = STOP_STATION;
    }
    @Basic
    @Column(name = "LIST_OF_STATIONS")
    public String getLIST_OF_STATIONS() {
        return LIST_OF_STATIONS;
    }

    public void setLIST_OF_STATIONS(String LIST_OF_STATIONS) {
        this.LIST_OF_STATIONS = LIST_OF_STATIONS;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RotesEntity that = (RotesEntity) o;

        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (START_STATION != null ? START_STATION.hashCode() : 0);
        result = 31 * result + (STOP_STATION != null ? STOP_STATION.hashCode() : 0);
        result = 31 * result + (LIST_OF_STATIONS != null ? LIST_OF_STATIONS.hashCode() : 0);
        return result;
    }

    public RotesEntity(){}

    public RotesEntity(Boolean ask, int l) {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("START_STATION:");
        this.START_STATION = sc.nextLine();
        System.out.println("STOP_STATION:");
        this.STOP_STATION = sc.nextLine();
        System.out.println("LIST_OF_STATIONS:");
        this.LIST_OF_STATIONS = sc.nextLine();
    }
}








