/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer.mappers;

import dataAccessLayer.mappers.interfaces.ISupportMapper;
import dataAccessLayer.DBFacade;
import dataAccessLayer.interfaces.IDBFacade;
import java.util.ArrayList;
import serviceLayer.entities.Ticket;
import serviceLayer.exceptions.SupportException;

/**
 *
 * @author xboxm
 */
public class SupportMapper implements ISupportMapper {
    private final IDBFacade dbf = new DBFacade();
    
    //Create a new ticket, which needs 3 parameters due to the database structure
    @Override
    public void createTicket(String title, String text, int userId) throws SupportException {
        dbf.createTicket(title, text, userId);
    }
    // Find the right ticket in DB on ticketId and edit with value text
    @Override
    public void editTicket(String text, int ticketId) throws SupportException {
        dbf.editTicket(text, ticketId);
    }
    // Find the ticket with id in DB
    @Override
    public Ticket getTicket(int ticketId) throws SupportException {
        return dbf.getTicket(ticketId);
    }
    // Find all tickets belonging to a specific user
    @Override
    public ArrayList<Ticket> getAllTicketsFromCustomer(int userId) throws SupportException {
        return dbf.getAllTicketsFromCustomer(userId);
    }
    // Get all tickets in the DB with no filter
    @Override
    public ArrayList<Ticket> getAllTickets() throws SupportException {
        return dbf.getAllTickets();
    }
    // Find a ticket by id and set its status to closed
    @Override
    public void closeTicket(int ticketId) throws SupportException {
        dbf.closeTicket(ticketId);
    }
    // Find an employee's answer to a ticket with id from DB
    @Override
    public String getAnswerToTicket(int ticketId) throws SupportException {
        return dbf.getAnswerToTicket(ticketId);
    }
    // Set the answer to a ticket by id with value answer
    @Override
    public void answerTicket(int ticketId, String answer) throws SupportException {
        dbf.answerTicket(ticketId, answer);
    }

}
