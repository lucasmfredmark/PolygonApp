/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer.mappers;

import dataAccessLayer.mappers.interfaces.IUserMapper;
import dataAccessLayer.DBFacade;
import dataAccessLayer.interfaces.IDBFacade;
import java.util.ArrayList;
import serviceLayer.entities.User;
import serviceLayer.exceptions.UserException;

/**
 *
 * @author lucas
 */
public class UserMapper implements IUserMapper {
    private final IDBFacade dbf = new DBFacade();

    @Override
    public User getUserByEmail(String email) throws UserException {
        return dbf.getUserByEmail(email);
    }

    @Override
    public void insertUser(String email, String fullname, String password) throws UserException {
        dbf.insertUser(email, fullname, password);
    }

    @Override
    public ArrayList<User> getAllUsers(String usertype) throws UserException {
        return dbf.getAllUsers(usertype);
    }
}
