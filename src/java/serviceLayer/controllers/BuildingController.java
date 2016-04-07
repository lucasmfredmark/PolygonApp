/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.mappers.BuildingMapper;
import java.sql.SQLException;
import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.Checkup;
import serviceLayer.entities.Damage;
import serviceLayer.entities.Document;

/**
 *
 * @author Staal
 */
public class BuildingController{
    private final BuildingMapper buildingMapper;

    public BuildingController() {
        this.buildingMapper = new BuildingMapper();
    }

    public Building getCustomerBuilding(int buildingId, int userId) throws SQLException {
        return buildingMapper.getCustomerBuilding(buildingId, userId);
    }

    public ArrayList<Building> getCustomerBuildings(int userId) throws SQLException {
        return buildingMapper.getCustomerBuildings(userId);
    }

    public boolean addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws SQLException {
        if (name != null && address != null && parcelNumber != null && size > 0 && userId > 0) {
            if (name.length() <= 40 && address.length() <= 50 && parcelNumber.length() <= 20) {
                if (parcelNumber.matches("[0-9a-z]+") && String.valueOf(size).matches("\\d*")) {
                    return buildingMapper.addCustomerBuilding(name, address, parcelNumber, size, userId);
                }
            }
        }
        
        return false;
    }

    public boolean deleteCustomerBuilding(int buildingId) throws SQLException {
        if (buildingId > 0) {
            return buildingMapper.deleteCustomerBuilding(buildingId);
        }
        
        return false;
    }

    public boolean editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws SQLException {
        if (name != null && address != null && parcelNumber != null && size > 0 && buildingId > 0) {
            return buildingMapper.editCustomerBuilding(name, address, parcelNumber, size, buildingId);
        }
        
        return false;
    }

    public ArrayList<Checkup> getBuildingCheckups(int buildingId) throws SQLException {
        return buildingMapper.getBuildingCheckups(buildingId);
    }

    public ArrayList<Document> getBuildingDocuments(int buildingId) throws SQLException {
        return buildingMapper.getBuildingDocuments(buildingId);
    }

    public int getBuildingConditionLevel(int buildingId) throws SQLException {
        return buildingMapper.getBuildingConditionLevel(buildingId);
    }

    public boolean addCustomerDocument(String documentNote, String documentPath, int buildingId, int userId) throws SQLException {
        if (documentNote != null && documentPath != null && buildingId > 0 && userId > 0) {
            return buildingMapper.addCustomerDocument(documentNote, documentPath, buildingId, userId);
        }
        
        return false;
    }

    public boolean addDamage(String dmgTitle, String dmgDesc, int buildingId) throws SQLException {
        if (dmgTitle != null && dmgDesc != null && buildingId > 0) {
            return buildingMapper.addDamage(dmgTitle, dmgDesc, buildingId);
        }
        
        return false;
    }

    public boolean deleteDamage(int damageId) throws SQLException {
        if (damageId > 0) {
            return buildingMapper.deleteDamage(damageId);
        }
        
        return false;
    }
    public ArrayList<Damage> getDamages(int buildingId) throws SQLException {
        return buildingMapper.getBuildingDamages(buildingId);
    }
}
