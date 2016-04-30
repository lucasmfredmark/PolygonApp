/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers.interfaces;

import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.Checkup;
import serviceLayer.entities.Damage;
import serviceLayer.entities.Document;
import serviceLayer.entities.Order;
import serviceLayer.entities.User;
import serviceLayer.exceptions.BuildingException;

/**
 *
 * @author lucas
 */
public interface IBuildingController {

    void addCheckUpReport(String checkupPath, int conditionLevel, int buildingId) throws BuildingException;

    void addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws BuildingException;

    void addCustomerDocument(String documentNote, String documentPath, int buildingId) throws BuildingException;

    void addDamage(String dmgTitle, String dmgDesc, int buildingId) throws BuildingException;

    void deleteCustomerBuilding(int buildingId) throws BuildingException;

    void deleteDamage(int damageId) throws BuildingException;

    void editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws BuildingException;

    ArrayList<Checkup> getBuildingCheckups(int buildingId) throws BuildingException;

    int getBuildingConditionLevel(int buildingId) throws BuildingException;

    ArrayList<Document> getBuildingDocuments(int buildingId) throws BuildingException;

    Building getCustomerBuilding(int buildingId, int userId) throws BuildingException;

    ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException;

    ArrayList<Damage> getDamages(int buildingId) throws BuildingException;

    Order getOrderByBuildingId(int buildingId) throws BuildingException;

    boolean getPendingCheckup(int buildingId) throws BuildingException;

    void requestCheckup(int orderStatus, int buildingId, User user) throws BuildingException;
    
}
