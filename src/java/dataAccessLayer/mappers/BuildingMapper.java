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

/**
 *
 * @author lucas
 */
public class BuildingMapper {
    public ArrayList<Building> getCustomerBuildings(User user) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM buildings WHERE userid = " + user.getUserId();
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        ArrayList<Building> buildingList = new ArrayList();
        
        while (rs.next()) {
            
        }
        
        return buildingList;
    }
}
