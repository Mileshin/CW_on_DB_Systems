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
@Table(name = "PEOPLE", schema = "TESTUSER", catalog = "")
public class PeopleEntity {
    private int id;
    private String name;
    private String surname;
    private String middle_name;
    private Date date_of_birth;
    private int position;

    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }


    @Basic
    @Column(name = "SURNAME")
    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    @Basic
    @Column(name = "MIDDLE_NAME")
    public String getMiddle_name() {
        return middle_name;
    }

    public void setMiddle_name(String middle_name) {
        this.middle_name = middle_name;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Basic
    @Column(name = "DATE_OF_BIRTH")
    public Date getDate_of_birth() {
        return date_of_birth;
    }

    public void setDate_of_birth(Date date_of_birth) {
        this.date_of_birth = date_of_birth;
    }

    @Basic
    @Column(name = "POSITION")
    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PeopleEntity that = (PeopleEntity) o;

        if (id != that.id) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        result = 31 * result + (surname != null ? surname.hashCode() : 0);
        result = 31 * result + (middle_name != null ? middle_name.hashCode() : 0);
        return result;
    }

    public  PeopleEntity(){}

    public PeopleEntity(Boolean ask,int l) throws ParseException {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("Surname:");
        this.surname = sc.nextLine();
        System.out.println("Name:");
        this.name = sc.nextLine();
        System.out.println("Middle Name:");
        this.middle_name = sc.nextLine();
        System.out.println("DATE_OF_BIRTH(format \"MMMM d, yyyy\"):");
        DateFormat format = new SimpleDateFormat("MMMM d, yyyy", Locale.ENGLISH);
        this.date_of_birth = format.parse(sc.nextLine());
        System.out.println("Positon:");
        this.position = sc.nextInt();
    }
}
