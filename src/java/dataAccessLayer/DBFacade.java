/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer;

import dataAccessLayer.interfaces.IDBFacade;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.Checkup;
import serviceLayer.entities.Damage;
import serviceLayer.entities.Document;
import serviceLayer.entities.Order;
import serviceLayer.entities.Ticket;
import serviceLayer.entities.User;
import serviceLayer.exceptions.BuildingException;
import serviceLayer.exceptions.SupportException;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author lucas
 */
public class DBFacade implements IDBFacade {

    @Override
    public void addCheckUpReport(String checkupPath, int conditionLevel, int buildingId) throws BuildingException {
        try {
            System.out.println("Reached DB layer");
            Connection conn = DBConnector.getConnection();
            String sql = "INSERT INTO checkups (cpath, conditionlevel, fk_buildingid) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, checkupPath);
            pstmt.setInt(2, conditionLevel);
            pstmt.setInt(3, buildingId);
            
            // Returns true if the number of rows affected in the database is 1, else returns false.
            int rowCount = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new BuildingException("Error: Check-up report could not be added. Maybe it already exists?");
        }
    }

    @Override
    public void addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES (?,?,?,?,?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, address);
            pstmt.setString(3, parcelNumber);
            pstmt.setInt(4, size);
            pstmt.setInt(5, userId);
            
            int rowCount = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new BuildingException("Error: building coul not be added. Check if you have filled out the form correctly");
        }
    }

    @Override
    public void addCustomerDocument(String documentNote, String documentPath, int buildingId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "INSERT INTO documents (dnote, dpath, fk_buildingid) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, documentNote);
            pstmt.setString(2, documentPath);
            pstmt.setInt(3, buildingId);
            
            // Returns true if the number of rows affected in the database is 1, else returns false.
            int rowCount = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new BuildingException("Error: Document could not be added. Maybe it already exists?");
        }
    }

    @Override
    public void addDamage(String dmgTitle, String dmgDesc, int buildingId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "INSERT INTO damages (dmgtitle, dmgdesc, fk_buildingid) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dmgTitle);
            pstmt.setString(2, dmgDesc);
            pstmt.setInt(3, buildingId);
            
            int rowCount = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new BuildingException("Error: damage was not added. Missing building id");
        }
    }

    @Override
    public void addOrder(int orderStatus, int buildingId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "INSERT INTO orders (ostatus, fk_buildingid) VALUES (?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, orderStatus);
            pstmt.setInt(2, buildingId);
            
            int rowCount = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new BuildingException("Error: no order could be added. Check orderStatus and buildingId");
        }
    }
    // Set value ticketanswer equal to parameter answer and match on ticketid
    // If query fails it is because the ticketid caused errors. Throw new ex
    @Override
    public void answerTicket(int ticketId, String answer) throws SupportException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "UPDATE tickets SET ticketanswer = ? WHERE ticketid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, answer);
            pstmt.setInt(2, ticketId);
            int rs = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new SupportException("Error: ticket not found with id: " + ticketId);
        }
    }
    // Set state value to o and match on ticketid. If it fails throw ex -->
    // ticketid mismatch
    @Override
    public void closeTicket(int ticketId) throws SupportException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "UPDATE tickets SET ticketstate = 0 WHERE ticketid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ticketId);
            int rs = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new SupportException("No ticket was found with id: " + ticketId);
        }
    }
    // Create a new entry in DB with values determined by parameters. 
    // Ticket id mismatch throws exception
    @Override
    public void createTicket(String title, String text, int userId) throws SupportException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "INSERT INTO tickets (tickettitle, tickettext, fk_userid) VALUES (?, ?, ?)";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, text);
            pstmt.setInt(3, userId);
            int rowsAffected = pstmt.executeUpdate();
            System.out.println(rowsAffected);
        } catch (SQLException ex) {
            throw new SupportException("Error: No tickets exists for user with id: " + userId);
        }
    }
    
    @Override
    public void deleteCustomerBuilding(int buildingId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "DELETE FROM buildings WHERE buildingid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, buildingId);
            
            int rowCount = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new BuildingException("Error: could not delete building - building not found");
        }
    }

    @Override
    public void deleteDamage(int damageId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "DELETE FROM damages WHERE damageid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, damageId);
            
            int rowCount = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new BuildingException("Error: damage was not foud with id: " + damageId);
        }
    }

    @Override
    public void editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "UPDATE buildings SET bname = ?, address = ?, parcelnumber = ?, size = ? WHERE buildingid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, address);
            pstmt.setString(3, parcelNumber);
            pstmt.setInt(4, size);
            pstmt.setInt(5, buildingId);
            
            int rowCount = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new BuildingException("Error: could not edit the building. Check if fields are filled correctly");
        }
    }

    @Override
    public void editTicket(String text, int ticketId) throws SupportException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "UPDATE tickets SET tickettext = ? WHERE ticketid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, text);
            pstmt.setInt(2, ticketId);
            int rs = pstmt.executeUpdate();
        } catch (SQLException ex) {
            throw new SupportException("Error: no ticket found to edit under id: " + ticketId);
        }
    }

    @Override
    public Building getAdminBuilding(int buildingId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM buildings WHERE buildingid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, buildingId);
            ResultSet rs = pstmt.executeQuery();
            
            // Creates a new building entity from the database query.
            if (rs.next()) {
                return new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
            }
        } catch (SQLException ex) {
            throw new BuildingException("There was no building found under buildingId" + buildingId);
        }
        return null;
    }

    @Override
    public ArrayList<Building> getAllBuildings() throws BuildingException {
        ArrayList<Building> buildingList = new ArrayList();
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM buildings ORDER BY buildings.address DESC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            
            // Creates an arraylist to contain all the building entities created from the database query.
            while (rs.next()) {
                Building building = new Building(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
                buildingList.add(building);
            }
            return buildingList;
        } catch (SQLException ex) {
            throw new BuildingException("Error: no buildings found. Check database?");
        }
    }
    // Select all entries from tickets table and order by title in ascending order
    @Override
    public ArrayList<Ticket> getAllTickets() throws SupportException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM tickets ORDER BY tickettitle ASC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            ArrayList<Ticket> tickets = new ArrayList();
            
            while (rs.next()) {
                Ticket ticket = new Ticket(rs.getInt("ticketid"), rs.getString("tickettitle"), rs.getString("tickettext"), rs.getInt("ticketstate"), rs.getInt("fk_userid"));
                tickets.add(ticket);
            }
            return tickets;
        } catch (SQLException ex) {
            throw new SupportException("There are no tickets by customers"); 
        }
    }
    // Select all tickets from table and match on userid
    @Override
    public ArrayList<Ticket> getAllTicketsFromCustomer(int userId) throws SupportException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM tickets WHERE fk_userid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            ArrayList<Ticket> tickets = new ArrayList();
            while (rs.next()) {
                Ticket ticket = new Ticket(rs.getInt("ticketid"), rs.getString("tickettitle"), rs.getString("tickettext"), rs.getInt("ticketstate"), rs.getInt("fk_userid"));
                tickets.add(ticket);
            }
            return tickets;
        } catch (SQLException ex) {
            throw new SupportException("Error: there was no tickets found for user with id: " + userId);
        }
    }

    @Override
    public ArrayList<User> getAllUsers(String usertype) throws UserException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM users WHERE usertype = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, usertype);
            ResultSet rs = pstmt.executeQuery();
            ArrayList<User> userList = new ArrayList();
            while (rs.next()) {
                User.userType userType;
                
                if (rs.getString(5).equals(User.userType.ADMIN.toString())) {
                    userType = User.userType.ADMIN;
                } else {
                    userType = User.userType.CUSTOMER;
                }
                
                User user = new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), userType, rs.getString(6));
                userList.add(user);
            }
            return userList;
        } catch (SQLException ex) {
            throw new UserException("A list of all users couldn't be returned. Is the database empty?");
        }
    }
    // Select all from tickets and match on ticket id, but return only answer
    @Override
    public String getAnswerToTicket(int ticketId) throws SupportException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM tickets WHERE ticketid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ticketId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                System.out.println("Answer is: " + rs.getString("ticketanswer"));
                return rs.getString("ticketanswer");
            }
        } catch (SQLException ex) {
            throw new SupportException("Error: There was no answer found to ticket with id: " + ticketId);
        }
        return null;
    }
    
    @Override
    public ArrayList<Checkup> getBuildingCheckups(int buildingId) throws BuildingException {
        try {
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
        } catch (SQLException ex) {
            throw new BuildingException("Error: no check up reports for this building: " + buildingId);
        }
    }

    @Override
    public int getBuildingConditionLevel(int buildingId) throws BuildingException {
        try {
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
        } catch (SQLException ex) {
           throw new BuildingException("Error: Building was not found");
        }
    }

    @Override
    public ArrayList<Damage> getBuildingDamages(int buildingId) throws BuildingException {
        try {
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
        } catch (SQLException ex) {
            throw new BuildingException("Error: no damages found for building id: " + buildingId);
        }
    }

    @Override
    public ArrayList<Document> getBuildingDocuments(int buildingId) throws BuildingException {
        try {
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
        } catch (SQLException ex) {
            throw new BuildingException("Error: no documents found for this building: " + buildingId);
        }
    }

    @Override
    public Building getCustomerBuilding(int buildingId, int userId) throws BuildingException {
        try {
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
        } catch (SQLException ex) {
            throw new BuildingException("There was no building found under buildingId" + buildingId + " and userId " + userId);
        }
        return null;
    }

    @Override
    public ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException {
        try {
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
        } catch (SQLException ex) {
            throw new BuildingException("No buildings found for user with id: " + userId);
        }
    }

    @Override
    public Order getOrderByBuildingId(int buildingId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM orders WHERE fk_buildingid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, buildingId);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return new Order(rs.getInt("orderid"),rs.getString("odate"), rs.getString("ostatus"),rs.getString("odone"));
            }
        } catch (SQLException ex) {
            throw new BuildingException("Error: no order found for building id: " + buildingId);
        }
        return null;
    }

    @Override
    public boolean getPendingCheckup(int buildingId) throws BuildingException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM orders WHERE fk_buildingid = ? AND ostatus = 0 ORDER BY orderid DESC";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, buildingId);
            ResultSet rs = pstmt.executeQuery();
            
            return rs.next();
        } catch (SQLException ex) {
            throw new BuildingException("Error: no orders found. Check database?");
        }
    }

    @Override
    public ArrayList<Building> getPendingCheckups() throws BuildingException {
        ArrayList<Building> buildingList = new ArrayList();
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM buildings INNER JOIN orders ON buildings.buildingid=orders.fk_buildingid WHERE ostatus = 0";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            // Creates an arraylist to contain all the building entities created from the database query.
            while (rs.next()) {
                Building building = new Building(rs.getInt("buildingid"), rs.getString("bdate"), rs.getString("bname"), rs.getString("address"), rs.getString("parcelnumber"), rs.getInt("size"));
                buildingList.add(building);
            }
            return buildingList;
        } catch (SQLException ex) {
            throw new BuildingException("Error: no buildings found. Check database?");
        }
    }
    // Find a specific entry from tickets table matched on ticketid
    @Override
    public Ticket getTicket(int ticketId) throws SupportException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM tickets WHERE ticketid = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, ticketId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                return new Ticket(rs.getInt("ticketid"), rs.getString("tickettitle"), rs.getString("tickettext"), rs.getInt("ticketstate"), rs.getInt("fk_userid"));
            }

        } catch (SQLException ex) {
            throw new SupportException("There was no ticket found under ticket id: " + ticketId);
        }
        return null;
    }

    @Override
    public User getUserByEmail(String email) throws UserException {
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM users WHERE usermail = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User.userType userType;
                
                if (rs.getString(5).equals(User.userType.ADMIN.toString())) {
                    userType = User.userType.ADMIN;
                } else {
                    userType = User.userType.CUSTOMER;
                }
                
                return new User(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), userType, rs.getString(6));
            } else {
                throw new UserException("That user doesn't exist.");
            }
        } catch (SQLException ex) {
            System.out.println("Do I reach this?");
            throw new UserException("Verify error: Couldn't check database");
        }
    }

    @Override
    public void insertUser(String email, String fullname, String password) throws UserException {
        System.out.println("Reached insertUser");
        try {
            Connection conn = DBConnector.getConnection();
            String sql = "SELECT * FROM users WHERE usermail = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            
            if (!rs.next()) {
                System.out.println("inside if rs next");
                sql = "INSERT INTO users (usermail, userpass, fullname) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, email);
                pstmt.setString(2, password);
                pstmt.setString(3, fullname);
                System.out.println("Done");
                pstmt.executeUpdate();
            } else {
                throw new UserException("That user already exists.");
            }
        } catch (SQLException ex) {
            throw new UserException("Error: the user couldn't be created. The user already exists");
        }
    }
}
