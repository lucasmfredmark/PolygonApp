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

    @Override
    public void createTicket(String title, String text, int userId) throws SupportException {
        dbf.createTicket(title, text, userId);
    }

    @Override
    public void editTicket(String text, int ticketId) throws SupportException {
        dbf.editTicket(text, ticketId);
    }

    @Override
    public Ticket getTicket(int ticketId) throws SupportException {
        return dbf.getTicket(ticketId);
    }

    @Override
    public ArrayList<Ticket> getAllTicketsFromCustomer(int userId) throws SupportException {
        return dbf.getAllTicketsFromCustomer(userId);
    }

    @Override
    public ArrayList<Ticket> getAllTickets() throws SupportException {
        return dbf.getAllTickets();
    }

    @Override
    public void closeTicket(int ticketId) throws SupportException {
        dbf.closeTicket(ticketId);
    }

    @Override
    public String getAnswerToTicket(int ticketId) throws SupportException {
        return dbf.getAnswerToTicket(ticketId);
    }

    @Override
    public void answerTicket(int ticketId, String answer) throws SupportException {
        dbf.answerTicket(ticketId, answer);
    }

}
