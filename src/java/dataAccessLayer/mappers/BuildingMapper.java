package dataAccessLayer.mappers;

import dataAccessLayer.mappers.interfaces.IBuildingMapper;
import dataAccessLayer.DBFacade;
import dataAccessLayer.interfaces.IDBFacade;
import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.Checkup;
import serviceLayer.entities.Damage;
import serviceLayer.entities.Document;
import serviceLayer.entities.Order;
import serviceLayer.exceptions.BuildingException;

public class BuildingMapper implements IBuildingMapper {
    private final IDBFacade dbf = new DBFacade();

    // Fetches one building from a buildingid and a userid in the database.
    @Override
    public Building getCustomerBuilding(int buildingId, int userId) throws BuildingException {
        return dbf.getCustomerBuilding(buildingId, userId);
    }
    
    // Fetches one building from a buildingid and a userid in the database.
    @Override
    public Building getAdminBuilding(int buildingId) throws BuildingException {
        return dbf.getAdminBuilding(buildingId);
    }
    
    @Override
    public ArrayList<Building> getAllBuildings() throws BuildingException {
        return dbf.getAllBuildings();
    }
    
    // Fetches all the buildings a userid possesses from the database.
    @Override
    public ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException {
        return dbf.getCustomerBuildings(userId);
    }

    // Adds a building to a userid in the database.
    @Override
    public void addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws BuildingException {
        dbf.addCustomerBuilding(name, address, parcelNumber, size, userId);
    }
    
    // Deletes a building in the database by buildingid.
    @Override
    public void deleteCustomerBuilding(int buildingId) throws BuildingException {
        dbf.deleteCustomerBuilding(buildingId);
    }

    // Edits the information of a building in the database by buildingid.
    @Override
    public void editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws BuildingException {
        dbf.editCustomerBuilding(name, address, parcelNumber, size, buildingId);
    }
    
    // Fetches all the checkup reports that a given buildingid has in the database.
    @Override
    public ArrayList<Checkup> getBuildingCheckups(int buildingId) throws BuildingException {
        return dbf.getBuildingCheckups(buildingId);
    }

    // Fetches all the documents related to a buildingid.
    @Override
    public ArrayList<Document> getBuildingDocuments(int buildingId) throws BuildingException {
        return dbf.getBuildingDocuments(buildingId);
    }
    
    // Gets the buildings condition level based on the latest checkup report.
    @Override
    public int getBuildingConditionLevel(int buildingId) throws BuildingException {
        return dbf.getBuildingConditionLevel(buildingId);
    }
    
    // Adds a document to a building.
    @Override
    public void addCustomerDocument(String documentNote, String documentPath, int buildingId) throws BuildingException {
        dbf.addCustomerDocument(documentNote, documentPath, buildingId);
    }
    
    // Adds a report to a building
    @Override
    public void addCheckUpReport(String checkupPath, int conditionLevel, int buildingId) throws BuildingException {
        dbf.addCheckUpReport(checkupPath, conditionLevel, buildingId);
    }
    
    // Adds a damage record to a building.
    @Override
    public void addDamage(String dmgTitle, String dmgDesc, int buildingId) throws BuildingException {
        dbf.addDamage(dmgTitle, dmgDesc, buildingId);
    }
    
    // Deletes a damage record by damageid.
    @Override
    public void deleteDamage(int damageId) throws BuildingException {
        dbf.deleteDamage(damageId);
    }
    
    // Fetches all the damage records a building has.
    @Override
    public ArrayList<Damage> getBuildingDamages(int buildingId) throws BuildingException {
        return dbf.getBuildingDamages(buildingId);
    }
    
    @Override
    public void addOrder(int orderStatus, int buildingId) throws BuildingException {
        dbf.addOrder(orderStatus, buildingId);
    }
    
    @Override
    public Order getOrderByBuildingId(int buildingId) throws BuildingException {
        return dbf.getOrderByBuildingId(buildingId);
    }
    
    @Override
    public boolean getPendingCheckup(int buildingId) throws BuildingException {
        return dbf.getPendingCheckup(buildingId);
    }
    
    @Override
    public ArrayList<Building> getPendingCheckups() throws BuildingException {
        return dbf.getPendingCheckups();
    }
}
