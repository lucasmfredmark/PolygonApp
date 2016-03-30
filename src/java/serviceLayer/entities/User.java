/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.entities;

/**
 *
 * @author HazemSaeid
 */
public class User {
    private int id;
    private String uname;
    private String pass;
    
    private enum userType {
        PRIVATEPERSON, MUNICIPALITY, HOUSINGASSOCIATION, ADMIN;
    }
    
    private String fullName;
    private String email;

    public User(int id, String uname, String pass, String fullName, String email) {
        this.id = id;
        this.uname = uname;
        this.pass = pass;
        this.fullName = fullName;
        this.email = email;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
