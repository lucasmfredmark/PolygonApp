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
import serviceLayer.entities.Checkup;
import serviceLayer.entities.Documents;

/**
 *
 * @author lucas
 */
public class BuildingMapper {

    public Building getCustomerBuilding(int buildingId, int userId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM buildings WHERE buildingid = ? AND fk_userid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        pstmt.setInt(2, userId);
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
            return new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8));
        }

        return null;
    }

    public ArrayList<Building> getCustomerBuildings(int userId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM buildings WHERE fk_userid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        ResultSet rs = pstmt.executeQuery();

        ArrayList<Building> buildingList = new ArrayList();

        while (rs.next()) {
            Building building = new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6), rs.getInt(7), rs.getInt(8));
            buildingList.add(building);
        }

        return buildingList;
    }

    public boolean addBuilding(String name, String address, String parcelNumber, int size, int userId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES (?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, address);
        pstmt.setString(3, parcelNumber);
        pstmt.setInt(4, size);
        pstmt.setInt(5, userId);
        int rowCount = pstmt.executeUpdate();

        return rowCount == 1;
    }

    public boolean deleteBuilding(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "DELETE FROM buildings WHERE buildingid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        int rowCount = pstmt.executeUpdate();

        return rowCount == 1;
    }

    public boolean editBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "UPDATE buildings SET bname = ?, address = ?, parcelnumber = ?, size = ? WHERE buildingid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, name);
        pstmt.setString(2, address);
        pstmt.setString(3, parcelNumber);
        pstmt.setInt(4, size);
        pstmt.setInt(5, buildingId);
        int rowCount = pstmt.executeUpdate();

        return rowCount == 1;
    }

    public ArrayList<Checkup> getCheckupReports(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM checkups INNER JOIN orders ON checkups.fk_orderid = orders.orderid AND orders.fk_buildingid = ? ORDER BY checkups.cdate DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();

        ArrayList<Checkup> checkupList = new ArrayList();

        while (rs.next()) {
            Checkup checkup = new Checkup(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getInt(5));
            checkupList.add(checkup);
        }

        return checkupList;
    }

    public ArrayList<Documents> getDocuments(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM documents WHERE fk_buildingid = " + buildingId + " ORDER by documents.ddate";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();
        ArrayList<Documents> documentList = new ArrayList();
        
        while (rs.next()) {
            Documents document = new Documents(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4));
            documentList.add(document);
        }

        return documentList;
    }
}
