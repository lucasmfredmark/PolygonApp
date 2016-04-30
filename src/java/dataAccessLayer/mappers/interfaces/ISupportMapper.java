/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer.mappers.interfaces;

import java.util.ArrayList;
import serviceLayer.entities.Ticket;
import serviceLayer.exceptions.SupportException;

/**
 *
 * @author lucas
 */
public interface ISupportMapper {

    void answerTicket(int ticketId, String answer) throws SupportException;

    void closeTicket(int ticketId) throws SupportException;

    void createTicket(String title, String text, int userId) throws SupportException;

    void editTicket(String text, int ticketId) throws SupportException;

    ArrayList<Ticket> getAllTickets() throws SupportException;

    ArrayList<Ticket> getAllTicketsFromCustomer(int userId) throws SupportException;

    String getAnswerToTicket(int ticketId) throws SupportException;

    Ticket getTicket(int ticketId) throws SupportException;
    
}
