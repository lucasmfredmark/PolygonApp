/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.mappers.BuildingMapper;
import java.sql.SQLException;
import serviceLayer.entities.Building;

/**
 *
 * @author Staal
 */
public class BuildingController {

    private final BuildingMapper buildingmapper;

    public BuildingController() {
        this.buildingmapper = new BuildingMapper();
    }

    public void addBuilding(String name, String address, int parcelNumber, int size, int conditionLevel, int buildingId) throws SQLException {
        buildingmapper.addBuilding(name, address, parcelNumber, size, conditionLevel, buildingId);
    }
    public void deleteBuilding(int buildingId) throws SQLException {
        buildingmapper.deleteBuilding(buildingId);
    }
}
