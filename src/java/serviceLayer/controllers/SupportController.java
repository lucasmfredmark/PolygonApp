/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.DBFacade;
import dataAccessLayer.interfaces.IDBFacade;
import serviceLayer.controllers.interfaces.ISupportController;
import java.util.ArrayList;
import serviceLayer.entities.Ticket;
import serviceLayer.exceptions.SupportException;

/**
 *
 * @author xboxm
 */
public class SupportController implements ISupportController {
    private final IDBFacade dbf = new DBFacade();

    // Check parameters to see if they are empty strings or their value is null
    // If not, call the method with those parameters, otherwise throw ex
    @Override
    public void createTicket(String title, String text, int userId) throws SupportException {
        if (title != null && text != null || !title.isEmpty() && !text.isEmpty()) {
            dbf.createTicket(title, text, userId);
        } else {
            throw new SupportException("One or more fields were empty");
        }
    }
    // If the ticket is open, edit it otherwise throw ex
    @Override
    public void editTicket(String text, int ticketId) throws SupportException {
        if (dbf.getTicket(ticketId).getState().equals("open")) {
            dbf.editTicket(text, ticketId);
        } else {
            throw new SupportException("Error: The ticket has been closed");
        }
    }
    // Read in mapper
    @Override
    public Ticket getTicket(int ticketid) throws SupportException {
        return dbf.getTicket(ticketid);
    }
    // Read in mapper
    @Override
    public ArrayList<Ticket> getAllTicketsForCustomer(int userId) throws SupportException {
        return dbf.getAllTicketsFromCustomer(userId);
    }
    // Read in mapper
    @Override
    public ArrayList<Ticket> getAllTickets() throws SupportException {
        return dbf.getAllTickets();
    }
    // Read in mapper
    @Override
    public String getAnswerToTicket(int ticketId) throws SupportException {
        return dbf.getAnswerToTicket(ticketId);
    }
    // If the ticket by id is not closed, set an answer to it otherwise throw ex
    @Override
    public void answerTicket(int ticketId, String answer) throws SupportException {
        if (getTicket(ticketId).getState().equals("open")) {
            dbf.answerTicket(ticketId, answer);
        } else {
            throw new SupportException("Error: the ticket has been closed");
        }
    }
    // If a ticket isn't already closed, close a ticket otherwise throw ex
    @Override
    public void closeTicket(int ticketId) throws SupportException {
        if (getTicket(ticketId).getState().equals("open")) {
            dbf.closeTicket(ticketId);
        } else {
            throw new SupportException("Error: the ticket has been closed");
        }
    }

}
