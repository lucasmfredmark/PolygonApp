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

/**
 *
 * @author Staal
 */
public class BuildingController {
    private final BuildingMapper buildingMapper;

    public BuildingController() {
        this.buildingMapper = new BuildingMapper();
    }

    public Building getCustomerBuildingById(int buildingId, int userId) throws SQLException {
        return buildingMapper.getCustomerBuildingById(buildingId, userId);
    }

    public ArrayList<Building> getAllCustomerBuildings(int userId) throws SQLException {
        return buildingMapper.getAllCustomerBuildings(userId);
    }

    public boolean addBuilding(String name, String address, String parcelNumber, int size, int userId) throws SQLException {
        if (name != null && address != null && parcelNumber != null && size > 0 && userId > 0) {
            return buildingMapper.addBuilding(name, address, parcelNumber, size, userId);
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
}
