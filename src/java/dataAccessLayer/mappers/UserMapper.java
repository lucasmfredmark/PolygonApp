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

/**
 *
 * @author lucas
 */
public class UserMapper {
    public User getUserByUsername(String username) throws SQLException {
        User user = null;
        
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM users WHERE username = '" + username + "'";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            user = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
        }
        
        return user;
    }
}
