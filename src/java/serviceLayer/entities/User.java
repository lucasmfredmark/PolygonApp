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
    private int userId;
    private String userDate;
    private String userMail;
    private String userPass;
    
    public enum userType {
        CUSTOMER, ADMIN
    }
    
    private userType userType;
    private String fullName;

    public User(int userId, String userDate, String userMail, String userPass, userType userType, String fullName) {
        this.userId = userId;
        this.userDate = userDate;
        this.userMail = userMail;
        this.userPass = userPass;
        this.userType = userType;
        this.fullName = fullName;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserDate() {
        return userDate;
    }

    public void setUserDate(String userDate) {
        this.userDate = userDate;
    }

    public String getUserMail() {
        return userMail;
    }

    public void setUserMail(String userMail) {
        this.userMail = userMail;
    }

    public String getUserPass() {
        return userPass;
    }

    public void setUserPass(String userPass) {
        this.userPass = userPass;
    }

    public userType getUserType() {
        return userType;
    }

    public void setUserType(userType userType) {
        this.userType = userType;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
}
