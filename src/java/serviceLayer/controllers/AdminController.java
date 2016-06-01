/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.DBFacade;
import dataAccessLayer.interfaces.IDBFacade;
import serviceLayer.controllers.interfaces.IAdminController;
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
    private final IDBFacade dbf = new DBFacade();

    @Override
    public ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException {
        return dbf.getCustomerBuildings(userId);
    }
    
    @Override
    public ArrayList<Building> getAllBuildings() throws BuildingException {
        return dbf.getAllBuildings();
    }

    @Override
    public ArrayList<User> getAllUsers(String userType) throws UserException {
        // The return has been commented out because the method is not implemented yet in Mapper
        return dbf.getAllUsers(userType);
    }
    
    @Override
    public Building getAdminBuilding(int buildingId) throws BuildingException {
        return dbf.getAdminBuilding(buildingId);
    }
    
    @Override
    public ArrayList<Building> getPendingCheckups() throws BuildingException {
        return dbf.getPendingCheckups();
    }
}
