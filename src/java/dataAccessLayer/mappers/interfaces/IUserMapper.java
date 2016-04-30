/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer.mappers.interfaces;

import java.util.ArrayList;
import serviceLayer.entities.User;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author lucas
 */
public interface IUserMapper {

    ArrayList<User> getAllUsers(String usertype) throws UserException;

    User getUserByEmail(String email) throws UserException;

    void insertUser(String email, String fullname, String password) throws UserException;
    
}
