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

    @Override
    public void createTicket(String title, String text, int userId) throws SupportException {
        if (title != null && text != null || !title.isEmpty() && !text.isEmpty()) {
            sm.createTicket(title, text, userId);
        } else {
            throw new SupportException("One or more fields were empty");
        }
    }

    @Override
    public void editTicket(String text, int ticketId) throws SupportException {
        if (sm.getTicket(ticketId).getState().equals("open")) {
            sm.editTicket(text, ticketId);
        } else {
            throw new SupportException("Error: The ticket has been closed");
        }
    }

    @Override
    public Ticket getTicket(int ticketid) throws SupportException {
        return sm.getTicket(ticketid);
    }

    @Override
    public ArrayList<Ticket> getAllTicketsForCustomer(int userId) throws SupportException {
        return sm.getAllTicketsFromCustomer(userId);
    }

    @Override
    public ArrayList<Ticket> getAllTickets() throws SupportException {
        return sm.getAllTickets();
    }

    @Override
    public String getAnswerToTicket(int ticketId) throws SupportException {
        return sm.getAnswerToTicket(ticketId);
    }

    @Override
    public void answerTicket(int ticketId, String answer) throws SupportException {
        if (getTicket(ticketId).getState().equals("open")) {
            sm.answerTicket(ticketId, answer);
        } else {
            throw new SupportException("Error: the ticket has been closed");
        }
    }

    @Override
    public void closeTicket(int ticketId) throws SupportException {
        if (getTicket(ticketId).getState().equals("open")) {
            sm.closeTicket(ticketId);
        } else {
            throw new SupportException("Error: the ticket has been closed");
        }
    }

}
