/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer;

import dataAccessLayer.interfaces.IDBFacade;
import dataAccessLayer.mappers.BuildingMapper;
import dataAccessLayer.mappers.SupportMapper;
import dataAccessLayer.mappers.UserMapper;
import dataAccessLayer.mappers.interfaces.IBuildingMapper;
import dataAccessLayer.mappers.interfaces.ISupportMapper;
import dataAccessLayer.mappers.interfaces.IUserMapper;
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
    IBuildingMapper bm = new BuildingMapper();
    ISupportMapper sm = new SupportMapper();
    IUserMapper um = new UserMapper();

    @Override
    public void addCheckUpReport(String checkupPath, int conditionLevel, int buildingId) throws BuildingException {
        bm.addCheckUpReport(checkupPath, conditionLevel, buildingId);
    }

    @Override
    public void addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws BuildingException {
        bm.addCustomerBuilding(name, address, parcelNumber, size, userId);
    }

    @Override
    public void addCustomerDocument(String documentNote, String documentPath, int buildingId) throws BuildingException {
        bm.addCustomerDocument(documentNote, documentPath, buildingId);
    }

    @Override
    public void addDamage(String dmgTitle, String dmgDesc, int buildingId) throws BuildingException {
        bm.addDamage(dmgTitle, dmgDesc, buildingId);
    }

    @Override
    public void addOrder(int orderStatus, int buildingId) throws BuildingException {
        bm.addOrder(orderStatus, buildingId);
    }

    @Override
    public void answerTicket(int ticketId, String answer) throws SupportException {
        sm.answerTicket(ticketId, answer);
    }

    @Override
    public void closeTicket(int ticketId) throws SupportException {
        sm.closeTicket(ticketId);
    }

    @Override
    public void createTicket(String title, String text, int userId) throws SupportException {
        sm.createTicket(title, text, userId);
    }

    @Override
    public void deleteCustomerBuilding(int buildingId) throws BuildingException {
        bm.deleteCustomerBuilding(buildingId);
    }

    @Override
    public void deleteDamage(int damageId) throws BuildingException {
        bm.deleteDamage(damageId);
    }

    @Override
    public void editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws BuildingException {
        bm.editCustomerBuilding(name, address, parcelNumber, size, buildingId);
    }

    @Override
    public void editTicket(String text, int ticketId) throws SupportException {
        sm.editTicket(text, ticketId);
    }

    @Override
    public Building getAdminBuilding(int buildingId) throws BuildingException {
        return bm.getAdminBuilding(buildingId);
    }

    @Override
    public ArrayList<Building> getAllBuildings() throws BuildingException {
        return bm.getAllBuildings();
    }

    @Override
    public ArrayList<Ticket> getAllTickets() throws SupportException {
        return sm.getAllTickets();
    }

    @Override
    public ArrayList<Ticket> getAllTicketsFromCustomer(int userId) throws SupportException {
        return sm.getAllTicketsFromCustomer(userId);
    }

    @Override
    public ArrayList<User> getAllUsers(String usertype) throws UserException {
        return um.getAllUsers(usertype);
    }

    @Override
    public String getAnswerToTicket(int ticketId) throws SupportException {
        return sm.getAnswerToTicket(ticketId);
    }

    @Override
    public ArrayList<Checkup> getBuildingCheckups(int buildingId) throws BuildingException {
        return bm.getBuildingCheckups(buildingId);
    }

    @Override
    public int getBuildingConditionLevel(int buildingId) throws BuildingException {
        return bm.getBuildingConditionLevel(buildingId);
    }

    @Override
    public ArrayList<Damage> getBuildingDamages(int buildingId) throws BuildingException {
        return bm.getBuildingDamages(buildingId);
    }

    @Override
    public ArrayList<Document> getBuildingDocuments(int buildingId) throws BuildingException {
        return bm.getBuildingDocuments(buildingId);
    }

    @Override
    public Building getCustomerBuilding(int buildingId, int userId) throws BuildingException {
        return bm.getCustomerBuilding(buildingId, userId);
    }

    @Override
    public ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException {
        return bm.getCustomerBuildings(userId);
    }

    @Override
    public Order getOrderByBuildingId(int buildingId) throws BuildingException {
        return bm.getOrderByBuildingId(buildingId);
    }

    @Override
    public boolean getPendingCheckup(int buildingId) throws BuildingException {
        return bm.getPendingCheckup(buildingId);
    }

    @Override
    public ArrayList<Building> getPendingCheckups() throws BuildingException {
        return bm.getPendingCheckups();
    }

    @Override
    public Ticket getTicket(int ticketId) throws SupportException {
        return sm.getTicket(ticketId);
    }

    @Override
    public User getUserByEmail(String email) throws UserException {
        return um.getUserByEmail(email);
    }

    @Override
    public void insertUser(String email, String fullname, String password) throws UserException {
        um.insertUser(email, fullname, password);
    }
}
