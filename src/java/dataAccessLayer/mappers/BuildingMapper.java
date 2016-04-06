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
import serviceLayer.entities.Document;

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
            return new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
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
            Building building = new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
            buildingList.add(building);
        }

        return buildingList;
    }

    public boolean addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws SQLException {
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

    public boolean deleteCustomerBuilding(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "DELETE FROM buildings WHERE buildingid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        int rowCount = pstmt.executeUpdate();

        return rowCount == 1;
    }

    public boolean editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws SQLException {
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

    public ArrayList<Checkup> getBuildingCheckups(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM checkups INNER JOIN orders ON checkups.fk_buildingid = orders.fk_buildingid AND orders.fk_buildingid = ? ORDER BY checkups.cdate DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();

        ArrayList<Checkup> checkupList = new ArrayList();

        while (rs.next()) {
            Checkup checkup = new Checkup(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(10));
            checkupList.add(checkup);
        }

        return checkupList;
    }

    public ArrayList<Document> getBuildingDocuments(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM documents WHERE fk_buildingid = ? ORDER by documents.ddate DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();
        ArrayList<Document> documentList = new ArrayList();
        
        while (rs.next()) {
            Document document = new Document(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
            documentList.add(document);
        }

        return documentList;
    }

    public int getBuildingConditionLevel(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM checkups WHERE fk_buildingid = ? ORDER BY checkups.conditionlevel DESC LIMIT 1";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();
        
        if (rs.next()) {
            return rs.getInt(4);
        }
        
        return 0;
    }

    public boolean addCustomerDocument(String documentNote, String documentPath, int buildingId, int userId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "INSERT INTO documents (dnote, dpath, fk_buildingid, fk_userid) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, documentNote);
        pstmt.setString(2, documentPath);
        pstmt.setInt(3, buildingId);
        pstmt.setInt(4, userId);
        int rowCount = pstmt.executeUpdate();

        return rowCount == 1;
    }

    public boolean addDamage(String dmgTitle, String dmgDesc, int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "INSERT INTO damages (dmgtitle, dmgdesc, fk_buildingid) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, dmgTitle);
        pstmt.setString(2, dmgDesc);
        pstmt.setInt(3, buildingId);
        int rowCount = pstmt.executeUpdate();
        
        return rowCount == 1;
    }

    public boolean deleteDamage(int damageId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "DELETE FROM damages WHERE damageid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, damageId);
        int rowCount = pstmt.executeUpdate();
        
        return rowCount == 1;
    }
}
