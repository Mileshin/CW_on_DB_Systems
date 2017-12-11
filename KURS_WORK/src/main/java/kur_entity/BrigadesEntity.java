package kur_entity;

import javax.persistence.*;
import java.util.Scanner;

/**
 * Created by Andrey on 09.12.2017.
 */
@Entity
@Table(name = "BRIGADES", schema = "TESTUSER", catalog = "")
public class BrigadesEntity {
    private int id;
    private String name;


    @Id
    @Column(name = "ID")
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "NAME")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }



    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BrigadesEntity that = (BrigadesEntity) o;

        if (id != that.id) return false;
        if (name != null ? !name.equals(that.name) : that.name != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = (int) id;
        result = 31 * result + (name != null ? name.hashCode() : 0);
        return result;
    }

    public BrigadesEntity(){}

    public BrigadesEntity(Boolean ask, int l) {
        this.id = l;
        Scanner sc = new Scanner(System.in);
        System.out.println("Name:");
        this.name = sc.nextLine();
    }
}








