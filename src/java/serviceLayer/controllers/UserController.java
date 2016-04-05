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
        if (email != null && password != null && !email.isEmpty() && !password.isEmpty()) {
            User user = userMapper.getUserByEmail(email);
            
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
            !email.isEmpty() && !fullname.isEmpty() && !password.isEmpty()) {
            return userMapper.insertUser(email, fullname, password);
        }
        
        return false;
    }
}
