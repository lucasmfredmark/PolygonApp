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

/**
 *
 * @author lucas
 */
public class BuildingMapper {
    public ArrayList<Building> getCustomerBuildings(User user) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM buildings WHERE userid = " + user.getId();
        PreparedStatement pstmt = conn.prepareStatement(sql);
        ResultSet rs = pstmt.executeQuery();
        
        ArrayList<Building> buildingList = new ArrayList();
        
        while (rs.next()) {
            Building building = new Building(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5));
            buildingList.add(building);
        }
        
        return buildingList;
    }
}
