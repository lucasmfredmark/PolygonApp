/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.mappers.BuildingMapper;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.regex.Pattern;
import serviceLayer.entities.Building;
import serviceLayer.entities.Checkup;
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
        final Pattern parcel = Pattern.compile("[0-9a-z]+");
        if (name != null && address != null && parcelNumber != null && size > 0 && userId > 0) {
            if(parcelNumber.length() <= 20 && parcel.matcher(parcelNumber).matches()) {
                if(name.length() <= 50 && address.length() <= 50) {
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
   public boolean addDamage(String dmgTitle, String dmgDesc, int buildingId) throws SQLException {
       return buildingMapper.addDamage(dmgTitle, dmgDesc, buildingId);
   }
   public boolean deleteDamage(int damageId) throws SQLException {
       return buildingMapper.deleteDamage(damageId);
   }
}
