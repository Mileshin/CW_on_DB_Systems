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
@Table(name = "SCHEDULE", schema = "TESTUSER", catalog = "")
public class SheduleEntity {
    private int id;
    private int id_brigade;

    private Date START_WORK_SHIFT;
    private Date STOP_WORK_SHIFT;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    @Basic
    @Column(name = "ID_BRIGADE")
    public int getId_brigade() {
        return id_brigade;
    }
    public void setId_brigade(int id_brigade) {
        this.id_brigade = id_brigade;
    }


    @Basic
    @Column(name = "START_WORK_SHIFT")
    public Date getSTART_WORK_SHIFT() {
        return START_WORK_SHIFT;
    }

    public void setSTART_WORK_SHIFT(Date START_WORK_SHIFT) {
        this.START_WORK_SHIFT = START_WORK_SHIFT;
    }

    @Basic
    @Column(name = "STOP_WORK_SHIFT")
    public Date getSTOP_WORK_SHIFT() {
        return STOP_WORK_SHIFT;
    }

    public void setSTOP_WORK_SHIFT(Date STOP_WORK_SHIFT) {
        this.STOP_WORK_SHIFT = STOP_WORK_SHIFT;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        SheduleEntity that = (SheduleEntity) o;

        if (id != that.id) return false;
        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (START_WORK_SHIFT != null ? START_WORK_SHIFT.hashCode() : 0);
        result = 31 * result + (STOP_WORK_SHIFT != null ? STOP_WORK_SHIFT.hashCode() : 0);
        return result;
    }

    public SheduleEntity(){}

    public SheduleEntity(Boolean ask, int l) throws ParseException {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("ID brigade:");
        this.id_brigade = sc.nextInt();
        sc.nextLine();
        System.out.println("START_WORK_SHIFT(format \"yyyy-MM-dd HH:mm\"):");
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm", Locale.ENGLISH);
        this.START_WORK_SHIFT = format.parse(sc.nextLine());
        System.out.println("STOP_WORK_SHIFT(format \"yyyy-MM-dd HH:mm\"):");
        this.STOP_WORK_SHIFT = format.parse(sc.nextLine());
    }
}
