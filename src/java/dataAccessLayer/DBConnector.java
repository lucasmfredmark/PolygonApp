/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dataAccessLayer;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author lucas
 */
public class DBConnector {
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost/polygon";
    private static final String USER = "root";
    private static final String PWD = "1234";
    public static Connection conn;
    
    public static Connection getConnection() {
        if (conn == null) {
            try {
                Class.forName(DRIVER);
            } catch (ClassNotFoundException ex) {
                ex.printStackTrace();
            }
            
            try {
                conn = DriverManager.getConnection(URL, USER, PWD);
            } catch (SQLException ex) {
               ex.printStackTrace();
            }
        }
        
        return conn;
    }
}
