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
import serviceLayer.entities.User;

/**
 *
 * @author Staal
 */
public class BuildingController {
    private final BuildingMapper buildingMapper;

    public BuildingController() {
        this.buildingMapper = new BuildingMapper();
    }

    public ArrayList<Building> getCustomerBuildings(User user) throws SQLException {
        return buildingMapper.getCustomerBuildings(user);
    }

    public void addBuilding(String name, String address, String parcelNumber, int size, int userId) throws SQLException {
        buildingMapper.addBuilding(name, address, parcelNumber, size, userId);
    }

    public void deleteBuilding(int buildingId) throws SQLException {
        buildingMapper.deleteBuilding(buildingId);
    }
}
