/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer.mappers;

import dataAccessLayer.DBConnector;
import java.sql.Connection;

/**
 *
 * @author Patrick
 */
public class UploadMapper {
    
    public boolean addDocument(String fileName, int buildingId, int userId) {
        Connection conn = DBConnector.getConnection();
        return false;
    }
    
}
