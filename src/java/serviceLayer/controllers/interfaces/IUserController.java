/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers.interfaces;

import java.util.ArrayList;
import serviceLayer.entities.User;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author lucas
 */
public interface IUserController {

    ArrayList<User> getAllUsers(String userType) throws UserException;

    User getUserByEmail(String email) throws UserException;

    User loginUser(String email, String password) throws UserException;

    void registerUser(String email, String fullname, String password) throws UserException;
    
}
