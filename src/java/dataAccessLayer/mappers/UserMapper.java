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
import serviceLayer.entities.User;
import serviceLayer.entities.User.userType;

/**
 *
 * @author lucas
 */
public class UserMapper {
    public User getUserByUsername(String username) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM users WHERE username = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            userType userType = null;
            
            if (rs.getString(4).equals(User.userType.ADMIN)) {
                userType = User.userType.ADMIN;
            } else {
                userType = User.userType.CUSTOMER;
            }
            
            return new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), userType, rs.getString(6), rs.getString(7));
        }
        
        return null;
    }
    
    public boolean insertUser(String username, String password, String fullname, String email) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM users WHERE username = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        ResultSet rs = pstmt.executeQuery();
        
        if (!rs.next()) {
            sql = "INSERT INTO users (username, userpass, fullname, email) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, fullname);
            pstmt.setString(4, email);
            int rowCount = pstmt.executeUpdate();
            return rowCount == 1;
        }
        
        return false;
    }
}
