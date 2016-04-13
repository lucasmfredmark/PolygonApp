/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.mappers.UserMapper;
import java.sql.SQLException;
import serviceLayer.entities.User;

/**
 *
 * @author lucas
 */
public class UserController {
    private final UserMapper userMapper;
    
    public UserController() {
        this.userMapper = new UserMapper();
    }
    
    public User loginUser(String email, String password) throws SQLException {
        if (email != null && password != null &&
            !email.isEmpty() && !password.isEmpty() &&
            password.length() <= 20) {
            User user = getUserByEmail(email);
            
            if (user != null) {
                if (user.getUserPass().equals(password)) {
                    return user;
                }
            }
        }
        
        return null;
    }
    
    public boolean registerUser(String email, String fullname, String password) throws SQLException {
        if (email != null && fullname != null && password != null &&
            !email.isEmpty() && !fullname.isEmpty() && !password.isEmpty() &&
            fullname.length() <= 50 && password.length() <= 20) {
            return userMapper.insertUser(email, fullname, password);
        }
        
        return false;
    }
    
    public User getUserByEmail(String email) throws SQLException {
        return userMapper.getUserByEmail(email);
    }
}
