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
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import serviceLayer.entities.User;

/**
 *
 * @author lucas
 */
public class UserControllerTest {
    
    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost/polygon";
    private static final String USER = "root";
    private static final String PWD = "root";
    public static Connection conn;
    
    public UserControllerTest() {
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
            st.addBatch("DROP TABLE users");
            st.addBatch("CREATE TABLE users ("
                    + "userid INT AUTO_INCREMENT PRIMARY KEY,"
                    + "udate DATETIME DEFAULT CURRENT_TIMESTAMP,"
                    + "usermail VARCHAR(255),"
                    + "userpass VARCHAR(20),"
                    + "usertype ENUM('CUSTOMER','ADMIN') DEFAULT 'CUSTOMER',"
                    + "fullname VARCHAR(50)"
                    + ")");
            
            // insert
            st.addBatch("INSERT INTO users (usermail, userpass, fullname) VALUES ('test@polygon.dk','test','Power User')");
            
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

    /**
     * Test of loginUser method, of class UserController.
     */
    @Test
    public void testLoginUserPass1() throws Exception {
        UserController uc = new UserController();
        String email = "test";
        String password = "test";
        User user = uc.loginUser(email, password);
        assertNotNull(user);
    }
    
    @Test
    public void testLoginUserFail1() throws Exception {
        UserController uc = new UserController();
        String email = "Hans";
        String password = "";
        User user = uc.loginUser(email, password);
        assertNull(user);
    }
    
    @Test
    public void testLoginUserFail2() throws Exception {
        UserController uc = new UserController();
        String email = "";
        String password = "Kage";
        User user = uc.loginUser(email, password);
        assertNull(user);
    }
    
    @Test
    public void testLoginUserFail3() throws Exception {
        UserController uc = new UserController();
        String email = "";
        String password = "";
        User user = uc.loginUser(email, password);
        assertNull(user);
    }
    
    @Test
    public void testLoginUserFail4() throws Exception {
        UserController uc = new UserController();
        String email = null;
        String password = null;
        User user = uc.loginUser(email, password);
        assertNull(user);
    }
    
    /**
     * Test of registerUser method, of class UserController.
     */
    @Test
    public void testRegisterUserPass1() throws Exception {
        UserController uc = new UserController();
        String email = "Patrick";
        String password = "Lotte";
        String fullname = "Hans Lotte";
        try {
            uc.registerUser(email, password, fullname);
        } catch (Exception e) {
            fail(e.getMessage());
        }
        assertTrue(true);
    }
    
    @Test
    public void testRegisterUserFail1() throws Exception {
        UserController uc = new UserController();
        String email = "";
        String password = "";
        String fullname = "";
        try {
            uc.registerUser(email, password, fullname);
        } catch (Exception e) {
            fail(e.getMessage());
        }
        assertTrue(true);
    }
    
    @Test
    public void testRegisterUserFail3() throws Exception {
        UserController uc = new UserController();
        String email = null;
        String password = null;
        String fullname = null;
        try {
            uc.registerUser(email, password, fullname);
        } catch (Exception e) {
            fail(e.getMessage());
        }
        assertTrue(true);
    }
    
}
