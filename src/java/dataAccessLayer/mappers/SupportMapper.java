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
import java.util.logging.Level;
import java.util.logging.Logger;
import serviceLayer.entities.Ticket;
import serviceLayer.exceptions.SupportException;

/**
 *
 * @author xboxm
 */
public class SupportMapper {

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

}
