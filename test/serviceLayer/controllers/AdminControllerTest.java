/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import org.junit.After;
import org.junit.AfterClass;
import static org.junit.Assert.assertEquals;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import serviceLayer.entities.Building;
import serviceLayer.entities.User;

/**
 *
 * @author xboxm
 */
public class AdminControllerTest {

    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost/polygon";
    private static final String USER = "root";
    private static final String PWD = "root";
    public static Connection conn;
    private AdminController ac;

    public AdminControllerTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() throws SQLException, ClassNotFoundException {
        ac = new AdminController();
        try {
            Class.forName(DRIVER);
            conn = DriverManager.getConnection(URL, USER, PWD);
            Statement st = conn.createStatement();
            conn.setAutoCommit(false);

            // create
            st.addBatch("DROP DATABASE IF EXISTS polygon");
            st.addBatch("CREATE DATABASE polygon");
            st.addBatch("USE polygon");
            st.addBatch("CREATE TABLE users ("
                    + "userid INT AUTO_INCREMENT PRIMARY KEY,"
                    + "udate DATETIME DEFAULT CURRENT_TIMESTAMP,"
                    + "usermail VARCHAR(255),"
                    + "userpass VARCHAR(20),"
                    + "usertype ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',"
                    + "fullname VARCHAR(50)"
                    + ")");
            st.addBatch("CREATE TABLE buildings ("
                    + "buildingid INT AUTO_INCREMENT PRIMARY KEY,"
                    + "bdate DATETIME DEFAULT CURRENT_TIMESTAMP,"
                    + "bname VARCHAR(40),"
                    + "address VARCHAR(50),"
                    + "parcelnumber VARCHAR(20),"
                    + "size INT,"
                    + "fk_userid INT,"
                    + "FOREIGN KEY (fk_userid) REFERENCES users(userid) ON DELETE CASCADE"
                    + ")");
            // insert
            st.addBatch("INSERT INTO users (usermail, userpass, fullname) VALUES ('adminTest@polygon.dk','adminTest','Power User')");
            st.addBatch("INSERT INTO users (usermail, userpass, fullname) VALUES ('adminTest2@polygon.dk','adminTest2','Power User2')");
            st.addBatch("INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('adminTest', 'adminTest', 'adminTest', 999, 1)");
            st.addBatch("INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('adminTest2', 'adminTest2', 'adminTest2', 100, 1)");
            st.executeBatch();

            // end transaction
            conn.commit();
        } catch (SQLException ex) {
            ex.printStackTrace();
        } finally {
            conn.close();
        }
    }

    @After
    public void tearDown() {
    }

    /**
     * Test of getCustomerBuildings method, of class AdminController.
     */
    @Test
    public void testGetCustomerBuildings() throws Exception {
        ArrayList<Building> buildings = new ArrayList();
        buildings = ac.getCustomerBuildings(1);
        // We have created 2 buildings, now let's see if they are and can be retrieved
        // in the database
        int result = buildings.size();
        int expResult = 2;
        assertEquals(expResult, result);
    }

    /**
     * Test of getAllUsers method, of class AdminController.
     */
    @Test
    public void testGetAllUsers() throws Exception {
        ArrayList<User> users = new ArrayList();
        users = ac.getAllUsers("CUSTOMER");
        // We have created 2 users, now let's see if they are and can be retrieved
        // in the database
        int result = users.size();
        int expResult = 2;
        assertEquals(expResult, result);
     }

}
