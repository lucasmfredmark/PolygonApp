/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import serviceLayer.controllers.interfaces.IAdminController;
import dataAccessLayer.mappers.interfaces.IBuildingMapper;
import dataAccessLayer.mappers.interfaces.IUserMapper;
import dataAccessLayer.mappers.BuildingMapper;
import dataAccessLayer.mappers.UserMapper;
import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.User;
import serviceLayer.exceptions.BuildingException;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author HazemSaeid
 */
public class AdminController implements IAdminController {

    private final IUserMapper um = new UserMapper();
    private final IBuildingMapper bm = new BuildingMapper();

    @Override
    public ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException {
        return bm.getCustomerBuildings(userId);
    }
    
    @Override
    public ArrayList<Building> getAllBuildings() throws BuildingException {
        return bm.getAllBuildings();
    }

    @Override
    public ArrayList<User> getAllUsers(String userType) throws UserException {
        // The return has been commented out because the method is not implemented yet in Mapper
        return um.getAllUsers(userType);
    }
    
    @Override
    public Building getAdminBuilding(int buildingId) throws BuildingException {
        return bm.getAdminBuilding(buildingId);
    }
    
    @Override
    public ArrayList<Building> getPendingCheckups() throws BuildingException {
        return bm.getPendingCheckups();
    }
}
