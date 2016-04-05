/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.mappers.UploadMapper;
import java.sql.SQLException;

/**
 *
 * @author Patrick
 */
public class UploadController {
    
    private final UploadMapper um = new UploadMapper();
    
    public boolean addDocument(String fileName, int buildingId, int userId) throws SQLException {
        return um.addDocument(fileName, buildingId, userId);
    }
    
}
