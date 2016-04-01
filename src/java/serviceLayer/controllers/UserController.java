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
    
    public User loginUser(String username, String password) throws SQLException {
        if (username != null && password != null) {
            User user = userMapper.getUserByUsername(username);
            
            if (user != null) {
                if (user.getPass().equals(password)) {
                    return user;
                }
            }
        }
        
        return null;
    }
    
    public boolean registerUser(String username, String password, String fullname, String email) throws SQLException {
        if (username != null && password != null && fullname != null && email != null) {
            return userMapper.insertUser(username, password, fullname, email);
        }
        
        return false;
    }
}
