/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import serviceLayer.controllers.interfaces.ISupportController;
import dataAccessLayer.mappers.interfaces.ISupportMapper;
import dataAccessLayer.mappers.SupportMapper;
import java.util.ArrayList;
import serviceLayer.entities.Ticket;
import serviceLayer.exceptions.SupportException;

/**
 *
 * @author xboxm
 */
public class SupportController implements ISupportController {

    private final ISupportMapper sm = new SupportMapper();
    
    // Check parameters to see if they are empty strings or their value is null
    // If not, call the method with those parameters, otherwise throw ex
    @Override
    public void createTicket(String title, String text, int userId) throws SupportException {
        if (title != null && text != null || !title.isEmpty() && !text.isEmpty()) {
            sm.createTicket(title, text, userId);
        } else {
            throw new SupportException("One or more fields were empty");
        }
    }
    // If the ticket is open, edit it otherwise throw ex
    @Override
    public void editTicket(String text, int ticketId) throws SupportException {
        if (sm.getTicket(ticketId).getState().equals("open")) {
            sm.editTicket(text, ticketId);
        } else {
            throw new SupportException("Error: The ticket has been closed");
        }
    }
    // Read in mapper
    @Override
    public Ticket getTicket(int ticketid) throws SupportException {
        return sm.getTicket(ticketid);
    }
    // Read in mapper
    @Override
    public ArrayList<Ticket> getAllTicketsForCustomer(int userId) throws SupportException {
        return sm.getAllTicketsFromCustomer(userId);
    }
    // Read in mapper
    @Override
    public ArrayList<Ticket> getAllTickets() throws SupportException {
        return sm.getAllTickets();
    }
    // Read in mapper
    @Override
    public String getAnswerToTicket(int ticketId) throws SupportException {
        return sm.getAnswerToTicket(ticketId);
    }
    // If the ticket by id is not closed, set an answer to it otherwise throw ex
    @Override
    public void answerTicket(int ticketId, String answer) throws SupportException {
        if (getTicket(ticketId).getState().equals("open")) {
            sm.answerTicket(ticketId, answer);
        } else {
            throw new SupportException("Error: the ticket has been closed");
        }
    }
    // If a ticket isn't already closed, close a ticket otherwise throw ex
    @Override
    public void closeTicket(int ticketId) throws SupportException {
        if (getTicket(ticketId).getState().equals("open")) {
            sm.closeTicket(ticketId);
        } else {
            throw new SupportException("Error: the ticket has been closed");
        }
    }

}
