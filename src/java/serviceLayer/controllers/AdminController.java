/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.mappers.UserMapper;
import java.sql.SQLException;
import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.User;

/**
 *
 * @author HazemSaeid
 */
public class AdminController {
    private final UserMapper um = new UserMapper();
    
    public ArrayList<Building> getCustomerBuildings(int buildingid) throws SQLException {
       return um.getCustomerBuildings(buildingid);
    } 
    
    public ArrayList<User> getAllUsers() throws SQLException {
        return null;
    }
}
