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

    public void addBuildings(Building building) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "INSERT INTO buildings (bname, address, parcelnumber, size_m2, userid) VALUES (?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, building.getName());
        pstmt.setString(2, building.getAddress());
        pstmt.setInt(3, building.getParcelNumber());
        pstmt.setInt(4, building.getSize());
        pstmt.setString(5, "userid");

        pstmt.executeUpdate(sql);

    }

    public void deleteBuilding(Building building) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = " DELETE FROM buildings WHERE buildingid ='?'";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, building.getBuildingId());
        pstmt.executeUpdate(sql);
    }
    

}
