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
            Building building = new Building(rs.getString(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getInt(6));
            buildingList.add(building);
        }

        return buildingList;
    }

    public void addBuilding(String name, String address, int parcelNumber, int size, int conditionLevel, int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "INSERT INTO buildings (bname, address, parcelnumber, size_m2, userid) VALUES (?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, address);
        pstmt.setInt(3, parcelNumber);
        pstmt.setInt(4, size);
        pstmt.setInt(5, buildingId);

        pstmt.executeUpdate(sql);

    }

    public void deleteBuilding(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = " DELETE FROM buildings WHERE buildingid ='?'";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        pstmt.executeUpdate(sql);
    }
    

}
