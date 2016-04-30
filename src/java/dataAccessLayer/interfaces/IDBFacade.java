/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer.interfaces;

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
public interface IDBFacade {

    void addCheckUpReport(String checkupPath, int conditionLevel, int buildingId) throws BuildingException;

    void addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws BuildingException;

    void addCustomerDocument(String documentNote, String documentPath, int buildingId) throws BuildingException;

    void addDamage(String dmgTitle, String dmgDesc, int buildingId) throws BuildingException;

    void addOrder(int orderStatus, int buildingId) throws BuildingException;

    void answerTicket(int ticketId, String answer) throws SupportException;

    void closeTicket(int ticketId) throws SupportException;

    void createTicket(String title, String text, int userId) throws SupportException;

    void deleteCustomerBuilding(int buildingId) throws BuildingException;

    void deleteDamage(int damageId) throws BuildingException;

    void editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws BuildingException;

    void editTicket(String text, int ticketId) throws SupportException;

    Building getAdminBuilding(int buildingId) throws BuildingException;

    ArrayList<Building> getAllBuildings() throws BuildingException;

    ArrayList<Ticket> getAllTickets() throws SupportException;

    ArrayList<Ticket> getAllTicketsFromCustomer(int userId) throws SupportException;

    ArrayList<User> getAllUsers(String usertype) throws UserException;

    String getAnswerToTicket(int ticketId) throws SupportException;

    ArrayList<Checkup> getBuildingCheckups(int buildingId) throws BuildingException;

    int getBuildingConditionLevel(int buildingId) throws BuildingException;

    ArrayList<Damage> getBuildingDamages(int buildingId) throws BuildingException;

    ArrayList<Document> getBuildingDocuments(int buildingId) throws BuildingException;

    Building getCustomerBuilding(int buildingId, int userId) throws BuildingException;

    ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException;

    Order getOrderByBuildingId(int buildingId) throws BuildingException;

    boolean getPendingCheckup(int buildingId) throws BuildingException;

    ArrayList<Building> getPendingCheckups() throws BuildingException;

    Ticket getTicket(int ticketId) throws SupportException;

    User getUserByEmail(String email) throws UserException;

    void insertUser(String email, String fullname, String password) throws UserException;
    
}
