package dataAccessLayer.mappers;

import dataAccessLayer.DBConnector;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.Checkup;
import serviceLayer.entities.Damage;
import serviceLayer.entities.Document;

public class BuildingMapper {
    
    // Fetches one building from a buildingid and a userid in the database.
    public Building getCustomerBuilding(int buildingId, int userId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM buildings WHERE buildingid = ? AND fk_userid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        pstmt.setInt(2, userId);
        ResultSet rs = pstmt.executeQuery();

        // Creates a new building entity from the database query.
        if (rs.next()) {
            return new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
        }

        return null;
    }
    
    // Fetches all the buildings a userid possesses from the database.
    public ArrayList<Building> getCustomerBuildings(int userId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM buildings WHERE fk_userid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, userId);
        ResultSet rs = pstmt.executeQuery();

        // Creates an arraylist to contain all the building entities created from the database query.
        ArrayList<Building> buildingList = new ArrayList();

        while (rs.next()) {
            Building building = new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
            buildingList.add(building);
        }

        return buildingList;
    }

    // Adds a building to a userid in the database.
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
        // Returns true if the number of rows affected in the database is 1, else returns false.
        return rowCount == 1;
    }
    
    // Deletes a building in the database by buildingid.
    public boolean deleteCustomerBuilding(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "DELETE FROM buildings WHERE buildingid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        
        int rowCount = pstmt.executeUpdate();
        // Returns true if the number of rows affected in the database is 1, else returns false.
        return rowCount == 1;
    }

    // Edits the information of a building in the database by buildingid.
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
        // Returns true if the number of rows affected in the database is 1, else returns false.
        return rowCount == 1;
    }
    
    // Fetches all the checkup reports that a given buildingid has in the database.
    public ArrayList<Checkup> getBuildingCheckups(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM checkups WHERE fk_buildingid = ? ORDER BY cdate DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();

        // Creates an arraylist to contain all the checkup entities created from the database query.
        ArrayList<Checkup> checkupList = new ArrayList();

        while (rs.next()) {
            Checkup checkup = new Checkup(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4));
            checkupList.add(checkup);
        }

        return checkupList;
    }

    // Fetches all the documents related to a buildingid.
    public ArrayList<Document> getBuildingDocuments(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM documents WHERE fk_buildingid = ? ORDER by documents.ddate DESC";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();
        
        // Creates an arraylist to contain all the document entities created from the database query.
        ArrayList<Document> documentList = new ArrayList();
        
        while (rs.next()) {
            Document document = new Document(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
            documentList.add(document);
        }

        return documentList;
    }
    
    // Gets the buildings condition level based on the latest checkup report.
    public int getBuildingConditionLevel(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM checkups WHERE fk_buildingid = ? ORDER BY conditionlevel DESC LIMIT 1";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();
        
        // Returns the condition level if a checkup report as been done, else returns -1.
        if (rs.next()) {
            return rs.getInt(4);
        }
        
        return -1;
    }
    
    // Adds a document to a building.
    public boolean addCustomerDocument(String documentNote, String documentPath, int buildingId, int userId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "INSERT INTO documents (dnote, dpath, fk_buildingid, fk_userid) VALUES (?, ?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, documentNote);
        pstmt.setString(2, documentPath);
        pstmt.setInt(3, buildingId);
        pstmt.setInt(4, userId);
        
        // Returns true if the number of rows affected in the database is 1, else returns false.
        int rowCount = pstmt.executeUpdate();

        return rowCount == 1;
    }
    
    // Adds a damage record to a building.
    public boolean addDamage(String dmgTitle, String dmgDesc, int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "INSERT INTO damages (dmgtitle, dmgdesc, fk_buildingid) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, dmgTitle);
        pstmt.setString(2, dmgDesc);
        pstmt.setInt(3, buildingId);
        
        // Returns true if the number of rows affected in the database is 1, else returns false.
        int rowCount = pstmt.executeUpdate();
        
        return rowCount == 1;
    }
    
    // Deletes a damage record by damageid.
    public boolean deleteDamage(int damageId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "DELETE FROM damages WHERE damageid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, damageId);
        
        // Returns true if the number of rows affected in the database is 1, else returns false.
        int rowCount = pstmt.executeUpdate();
        
        return rowCount == 1;
    }
    
    // Fetches all the damage records a building has.
    public ArrayList<Damage> getBuildingDamages(int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "SELECT * FROM damages WHERE fk_buildingid = ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, buildingId);
        ResultSet rs = pstmt.executeQuery();
        
        // Creates an arraylist to contain all the damage entities created from the database query.
        ArrayList<Damage> dmgList = new ArrayList();
        
        while (rs.next()) {
            Damage dmg = new Damage(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
            dmgList.add(dmg);
        }

        return dmgList;
    }
    
    public boolean addOrder(String orderDesc, int serviceId, int buildingId) throws SQLException {
        Connection conn = DBConnector.getConnection();
        String sql = "INSERT INTO orders (odesc, fk_serviceid, fk_buildingid) VALUES (?, ?, ?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, orderDesc);
        pstmt.setInt(2, serviceId);
        pstmt.setInt(3, buildingId);
        
        // Returns true if the number of rows affected in the database is 1, else returns false.
        int rowCount = pstmt.executeUpdate();
        
        return rowCount == 1;
    }
}
