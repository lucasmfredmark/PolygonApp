package serviceLayer.controllers;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import org.junit.After;
import org.junit.AfterClass;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static serviceLayer.controllers.UserControllerTest.conn;
import serviceLayer.entities.Building;
import serviceLayer.entities.User;

/**
 *
 * @author MalteBruun
 */
public class BuildingControllerTest {

    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost/polygon";
    private static final String USER = "root";
    private static final String PWD = "root";
    public static Connection conn;

    public enum userType {
        CUSTOMER, ADMIN
    }

    public BuildingControllerTest() {
    }

    @BeforeClass
    public static void setUpClass() {
    }

    @AfterClass
    public static void tearDownClass() {
    }

    @Before
    public void setUp() throws SQLException {
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
            st.addBatch("INSERT INTO users (usermail, userpass, fullname) VALUES ('test@polygon.dk','test','Power User')");
            st.addBatch("INSERT INTO buildings (bname, address, parcelnumber, size, fk_userid) VALUES ('test', 'test', 'test', 100, 1)");
            
            st.executeBatch();
            
            // end transaction
            conn.commit();
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        } finally {
            conn.close();
        }
    }

    @After
    public void tearDown() throws SQLException {
        conn.close();
    }

    @Test
    public void addRemoveBuildingTest() throws SQLException {
        BuildingController bc = new BuildingController();
        Building building = bc.getCustomerBuilding(1, 1);
        System.out.println("Testing add building");
        assertEquals("test", building.getBuildingParcelNumber());
        System.out.println("Test delete building");
        assertTrue(bc.deleteCustomerBuilding(1));
        
    }

    // TODO add test methods here.
    // The methods must be annotated with annotation @Test. For example:
    //
    // @Test
    // public void hello() {}
}
