/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer.mappers.interfaces;

import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.Checkup;
import serviceLayer.entities.Damage;
import serviceLayer.entities.Document;
import serviceLayer.entities.Order;
import serviceLayer.exceptions.BuildingException;

/**
 *
 * @author lucas
 */
public interface IBuildingMapper {

    // Adds a report to a building
    void addCheckUpReport(String checkupPath, int conditionLevel, int buildingId) throws BuildingException;

    // Adds a building to a userid in the database.
    void addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws BuildingException;

    // Adds a document to a building.
    void addCustomerDocument(String documentNote, String documentPath, int buildingId) throws BuildingException;

    // Adds a damage record to a building.
    void addDamage(String dmgTitle, String dmgDesc, int buildingId) throws BuildingException;

    void addOrder(int orderStatus, int buildingId) throws BuildingException;

    // Deletes a building in the database by buildingid.
    void deleteCustomerBuilding(int buildingId) throws BuildingException;

    // Deletes a damage record by damageid.
    void deleteDamage(int damageId) throws BuildingException;

    // Edits the information of a building in the database by buildingid.
    void editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws BuildingException;

    // Fetches one building from a buildingid and a userid in the database.
    Building getAdminBuilding(int buildingId) throws BuildingException;

    ArrayList<Building> getAllBuildings() throws BuildingException;

    // Fetches all the checkup reports that a given buildingid has in the database.
    ArrayList<Checkup> getBuildingCheckups(int buildingId) throws BuildingException;

    // Gets the buildings condition level based on the latest checkup report.
    int getBuildingConditionLevel(int buildingId) throws BuildingException;

    // Fetches all the damage records a building has.
    ArrayList<Damage> getBuildingDamages(int buildingId) throws BuildingException;

    // Fetches all the documents related to a buildingid.
    ArrayList<Document> getBuildingDocuments(int buildingId) throws BuildingException;

    // Fetches one building from a buildingid and a userid in the database.
    Building getCustomerBuilding(int buildingId, int userId) throws BuildingException;

    // Fetches all the buildings a userid possesses from the database.
    ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException;

    Order getOrderByBuildingId(int buildingId) throws BuildingException;

    boolean getPendingCheckup(int buildingId) throws BuildingException;

    ArrayList<Building> getPendingCheckups() throws BuildingException;
    
}
