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
import serviceLayer.entities.Building;
import serviceLayer.entities.User;
import serviceLayer.entities.User.userType;

/**
 *
 * @author lucas
 */
public class UserMapper {
    public User getUserByEmail(String email) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM users WHERE usermail = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            userType userType = null;
            
            if (rs.getString(5).equals(User.userType.ADMIN)) {
                userType = User.userType.ADMIN;
            } else {
                userType = User.userType.CUSTOMER;
            }
            
            return new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), userType, rs.getString(6));
        }
        
        return null;
    }
    
    public boolean insertUser(String email, String fullname, String password) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM users WHERE usermail = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();
        
        if (!rs.next()) {
            sql = "INSERT INTO users (usermail, fullname, userpass) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, fullname);
            pstmt.setString(3, password);
            int rowCount = pstmt.executeUpdate();
            return rowCount == 1;
        }
        
        return false;
    }
    public ArrayList<Building> getCustomerBuildings(int buildingid) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM buildings JOIN users ON buildings.fk_userid = users.userid";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingid);
        ResultSet rs = pstmt.executeQuery();

        // Creates an arraylist to contain all the building entities created from the database query.
        ArrayList<Building> buildingList = new ArrayList();

        while (rs.next()) {
            Building building = new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
            buildingList.add(building);
        }

        return buildingList;
    }
}
