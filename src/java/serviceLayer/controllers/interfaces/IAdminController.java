/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers.interfaces;

import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.User;
import serviceLayer.exceptions.BuildingException;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author lucas
 */
public interface IAdminController {

    Building getAdminBuilding(int buildingId) throws BuildingException;

    ArrayList<Building> getAllBuildings() throws BuildingException;

    ArrayList<User> getAllUsers(String userType) throws UserException;

    ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException;

    ArrayList<Building> getPendingCheckups() throws BuildingException;
    
}
