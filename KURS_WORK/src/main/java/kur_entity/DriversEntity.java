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
@Table(name = "DRIVERS", schema = "TESTUSER", catalog = "")
public class DriversEntity {
    private int id;
    private int id_people;

    private Date DATE_MEDICAL_CHECK_UP;
    private String violations;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    @Basic
    @Column(name = "ID_PEOPLE")
    public int getId_people() {
        return id_people;
    }
    public void setId_people(int id_people) {
        this.id_people = id_people;
    }

    @Basic
    @Column(name = "VIOLATIONS")
    public String getViolations() {
        return violations;
    }

    public void setViolations(String violations) {
        this.violations = violations;
    }

    @Basic
    @Column(name = "DATE_MEDICAL_CHECK_UP")
    public Date getDATE_MEDICAL_CHECK_UP() {
        return DATE_MEDICAL_CHECK_UP;
    }

    public void setDATE_MEDICAL_CHECK_UP(Date DATE_MEDICAL_CHECK_UP) {
        this.DATE_MEDICAL_CHECK_UP = DATE_MEDICAL_CHECK_UP;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DriversEntity that = (DriversEntity) o;

        if (id != that.id) return false;
        if (id_people != that.id_people) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        return result;
    }

    public DriversEntity(){}

    public DriversEntity(Boolean ask, int l) throws ParseException {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("ID person:");
        this.id_people = sc.nextInt();
        sc.nextLine();
        System.out.println("DATE_MEDICAL_CHECK_UP(format \"MMMM d, yyyy\"):");
        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
        this.DATE_MEDICAL_CHECK_UP = format.parse(sc.nextLine());
        System.out.println("VIOLATIONS:");
        this.violations = sc.nextLine();
    }
}
