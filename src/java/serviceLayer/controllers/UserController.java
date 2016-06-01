/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.DBFacade;
import dataAccessLayer.interfaces.IDBFacade;
import serviceLayer.controllers.interfaces.IUserController;
import java.util.ArrayList;
import serviceLayer.entities.User;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author lucas
 */
public class UserController implements IUserController {
    private final IDBFacade dbf = new DBFacade();

    @Override
    public User loginUser(String email, String password) throws UserException {
        if (email != null && password != null &&
            !email.isEmpty() && !password.isEmpty() &&
            password.length() <= 20) {
            User user = getUserByEmail(email);
            
            if (user != null) {
                if (user.getUserPass().equals(password)) {
                    return user;
                } else {
                    throw new UserException("The password doesn't match the e-mail.");
                }
            }
        } 
        return null;
    }
    
    @Override
    public void registerUser(String email, String fullname, String password) throws UserException {
        if (email != null && fullname != null && password != null &&
            !email.isEmpty() && !fullname.isEmpty() && !password.isEmpty() &&
            fullname.length() <= 50 && password.length() <= 20) {
            dbf.insertUser(email, fullname, password);
        } else {
            throw new UserException("One or more fields were empty");
        }
    }
    
    @Override
    public User getUserByEmail(String email) throws UserException {
        return dbf.getUserByEmail(email);
    }
    
    @Override
    public ArrayList<User> getAllUsers(String userType) throws UserException {
        return dbf.getAllUsers(userType);
    }
}
