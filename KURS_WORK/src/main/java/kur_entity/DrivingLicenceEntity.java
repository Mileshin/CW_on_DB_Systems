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
@Table(name = "DRIVING_LICENCE", schema = "TESTUSER", catalog = "")
public class DrivingLicenceEntity {
    private int id;
    private int ID_DRIVER;
    private int ID_LICENCE;
    private Date DATE_OF_ISSUANCE;
    private Date VALID_UNTIL;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    @Basic
    @Column(name = "ID_DRIVER")
    public int getID_DRIVER() {
        return ID_DRIVER;
    }
    public void setID_DRIVER(int ID_DRIVER) {
        this.ID_DRIVER = ID_DRIVER;
    }

    @Basic
    @Column(name = "ID_LICENCE")
    public int getID_LICENCE() {
        return ID_LICENCE;
    }
    public void setID_LICENCE(int ID_LICENCE) {
        this.ID_LICENCE = ID_LICENCE;
    }

    @Basic
    @Column(name = "DATE_OF_ISSUANCE")
    public Date getDATE_OF_ISSUANCE() {
        return DATE_OF_ISSUANCE;
    }
    public void setDATE_OF_ISSUANCE(Date DATE_OF_ISSUANCE) {
        this.DATE_OF_ISSUANCE = DATE_OF_ISSUANCE;
    }

    @Basic
    @Column(name = "VALID_UNTIL")
    public Date getVALID_UNTIL() {
        return VALID_UNTIL;
    }
    public void setVALID_UNTIL(Date VALID_UNTIL) {
        this.VALID_UNTIL = VALID_UNTIL;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        DrivingLicenceEntity that = (DrivingLicenceEntity) o;

        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (DATE_OF_ISSUANCE != null ? DATE_OF_ISSUANCE.hashCode() : 0);
        result = 31 * result + (VALID_UNTIL != null ? VALID_UNTIL.hashCode() : 0);
        return result;
    }

    public DrivingLicenceEntity(){}

    public DrivingLicenceEntity(Boolean ask, int l) throws ParseException {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("ID_DRIVER:");
        this.ID_DRIVER = sc.nextInt();
        sc.nextLine();
        System.out.println("ID_LICENCE:");
        this.ID_LICENCE = sc.nextInt();
        sc.nextLine();

        System.out.println("DATE_OF_ISSUANCE(format \"MMMM d, yyyy\"):");
        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
        this.DATE_OF_ISSUANCE = format.parse(sc.nextLine());
        System.out.println("VALID_UNTIL(format \"MMMM d, yyyy\"):");
         this.VALID_UNTIL = format.parse(sc.nextLine());
    }
}
