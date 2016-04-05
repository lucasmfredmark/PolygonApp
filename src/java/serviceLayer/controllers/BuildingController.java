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
import serviceLayer.entities.Documents;

/**
 *
 * @author Staal
 */
public class BuildingController {
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

    public boolean addBuilding(String name, String address, String parcelNumber, int size, int userId) throws SQLException {
        final Pattern parcel = Pattern.compile("[0-9a-z]+");
        if (name != null && address != null && parcelNumber != null && size > 0 && userId > 0) {
            if(parcelNumber.length() <= 20 && parcel.matcher(parcelNumber).matches()) {
                if(name.length() <= 50 && address.length() <= 50) {
                    return buildingMapper.addBuilding(name, address, parcelNumber, size, userId);
                }
            }
        }
        
        return false;
    }

    public boolean deleteBuilding(int buildingId) throws SQLException {
        if (buildingId > 0) {
            return buildingMapper.deleteBuilding(buildingId);
        }
        
        return false;
    }

    public boolean editBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws SQLException {
        if (name != null && address != null && parcelNumber != null && size > 0 && buildingId > 0) {
            return buildingMapper.editBuilding(name, address, parcelNumber, size, buildingId);
        }
        
        return false;
    }
    
    public ArrayList <Checkup> getCheckupReports(int buildingId) throws SQLException {
        return buildingMapper.getCheckupReports(buildingId);
    }
    
    public ArrayList <Documents> getDocuments(int buildingId) throws SQLException{
        return buildingMapper.getDocuments(buildingId);
    }
}
