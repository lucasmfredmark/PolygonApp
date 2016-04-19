/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer.mappers;

import dataAccessLayer.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import serviceLayer.entities.User;
import serviceLayer.entities.User.userType;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author lucas
 */
public class UserMapper {

    public User getUserByEmail(String email) throws UserException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM users WHERE usermail = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                userType userType;
                
                if (rs.getString(5).equals(User.userType.ADMIN.toString())) {
                    userType = User.userType.ADMIN;
                } else {
                    userType = User.userType.CUSTOMER;
                }
                
                return new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), userType, rs.getString(6));
            }
        } catch (SQLException ex) {
            throw new UserException("An error occured: no match on email");
        }
        return null;
    }

    public void insertUser(String email, String fullname, String password) throws UserException {
        System.out.println("Reached insertUser");
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM users WHERE usermail = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (!rs.next()) {
                System.out.println("inside if rs next");
                sql = "INSERT INTO users (usermail, userpass, fullname) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, email);
                pstmt.setString(2, password);
                pstmt.setString(3, fullname);
                System.out.println("Done");
                pstmt.executeUpdate();
            }
        } catch (SQLException ex) {
            throw new UserException("Error: the user couldn't be created. The user already exists");
        }
    }
   
    
    public ArrayList<User> getAllUsers(String usertype) throws UserException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM users WHERE usertype = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, usertype);
            ResultSet rs = pstmt.executeQuery();
            ArrayList<User> userList = new ArrayList();
            while (rs.next()) {
                userType userType;
                
                if (rs.getString(5).equals(User.userType.ADMIN.toString())) {
                    userType = User.userType.ADMIN;
                } else {
                    userType = User.userType.CUSTOMER;
                }
                
                User user = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), userType, rs.getString(6));
                userList.add(user);
            }
            return userList;
        } catch (SQLException ex) {
            throw new UserException("A list of all users couldn't be returned. Is the database empty?");
        }
    }
}
