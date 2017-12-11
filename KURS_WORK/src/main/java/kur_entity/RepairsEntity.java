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
@Table(name = "REPAIRS", schema = "TESTUSER", catalog = "")
public class RepairsEntity {
    private int id;
    private int ID_BREAKDOWN;

    private Date START_DATE;
    private Date END_DATE;
    private int ID_MECHANIC;
    private String CONCLUSION;


    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    @Basic
    @Column(name = "ID_BREAKDOWN")
    public int getID_BREAKDOWN() {
        return ID_BREAKDOWN;
    }
    public void setID_BREAKDOWN(int ID_BREAKDOWN) {
        this.ID_BREAKDOWN = ID_BREAKDOWN;
    }

    @Basic
    @Column(name = "ID_MECHANIC")
    public int getID_MECHANIC() {
        return ID_MECHANIC;
    }
    public void setID_MECHANIC(int ID_MECHANIC) {
        this.ID_MECHANIC = ID_MECHANIC;
    }

    @Basic
    @Column(name = "START_DATE")
    public Date getSTART_DATE() {
        return START_DATE;
    }

    public void setSTART_DATE(Date START_DATE) {
        this.START_DATE = START_DATE;
    }

    @Basic
    @Column(name = "END_DATE")
    public Date getEND_DATE() {
        return END_DATE;
    }

    public void setEND_DATE(Date END_DATE) {
        this.END_DATE = END_DATE;
    }

    @Basic
    @Column(name = "CONCLUSION")
    public String getCONCLUSION() {
        return CONCLUSION;
    }

    public void setCONCLUSION(String CONCLUSION) {
        this.CONCLUSION = CONCLUSION;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        RepairsEntity that = (RepairsEntity) o;

        if (id != that.id) return false;
        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (CONCLUSION != null ? CONCLUSION.hashCode() : 0);
        return result;
    }

    public RepairsEntity(){}

    public RepairsEntity(Boolean ask, int l) throws ParseException {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("ID_BREAKDOWN:");
        this.ID_BREAKDOWN = sc.nextInt();
        sc.nextLine();
        System.out.println("START_DATE(format \"MMMM d, yyyy\"):");
        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
        this.START_DATE = format.parse(sc.nextLine());
        System.out.println("END_DATE(format \"MMMM d, yyyy\"):");
        this.END_DATE = format.parse(sc.nextLine());
        System.out.println("ID_MECHANIC:");
        this.ID_MECHANIC = sc.nextInt();
        sc.nextLine();
        System.out.println("CONCLUSION:");
        this.CONCLUSION = sc.nextLine();
    }
}
