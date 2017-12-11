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
@Table(name = "BREAKDOWN", schema = "TESTUSER", catalog = "")
public class BreakdownEntity {
    private int id;
    private int ID_BUS;
    private Date DATE_BREAKDOWN;
    private String DESCRIPTION;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    @Basic
    @Column(name = "ID_BUS")
    public int getID_BUS() {
        return ID_BUS;
    }
    public void setID_BUS(int ID_BUS) {
        this.ID_BUS = ID_BUS;
    }

    @Basic
    @Column(name = "DATE_BREAKDOWN")
    public Date getDATE_BREAKDOWN() {
        return DATE_BREAKDOWN;
    }
    public void setDATE_BREAKDOWN(Date DATE_BREAKDOWN) {
        this.DATE_BREAKDOWN = DATE_BREAKDOWN;
    }

    @Basic
    @Column(name = "DESCRIPTION")
    public String getDESCRIPTION() {
        return DESCRIPTION;
    }
    public void setDESCRIPTION(String DESCRIPTION) {
        this.DESCRIPTION = DESCRIPTION;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BreakdownEntity that = (BreakdownEntity) o;

        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (DESCRIPTION != null ? DESCRIPTION.hashCode() : 0);
        return result;
    }

    public BreakdownEntity(){}

    public BreakdownEntity(Boolean ask, int l) throws ParseException {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("ID_BUS:");
        this.ID_BUS = sc.nextInt();
        sc.nextLine();
        System.out.println("DATE_BREAKDOWN(format \"MMMM d, yyyy\"):");
        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
        this.DATE_BREAKDOWN = format.parse(sc.nextLine());
        System.out.println("DESCRIPTION:");
        this.DESCRIPTION = sc.nextLine();
    }
}
