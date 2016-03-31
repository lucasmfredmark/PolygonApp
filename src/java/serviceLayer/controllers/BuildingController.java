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
    
    public Building AddBuilding (String bname, String adress, String pacelnumber, String size_m2) throws SQLException {
        if (bname != null && adress != null && pacelnumber != null  && size_m2 != null){
            Building building = new Building;
            Building building = buildingmapper.addBuilding()
        }
        
        if (bname )
        return null;
    }
    
}
