/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.SQLException;
import org.junit.After;
import org.junit.AfterClass;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import serviceLayer.controllers.BuildingController;
import serviceLayer.entities.Building;

/**
 *
 * @author MalteBruun
 */
public class BuildingControllerTest {
    
    public BuildingControllerTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @Before
    public void setUp() {
    }
    
    @After
    public void tearDown() {
    }
    
    @Test
    public void testAddBuilding() {
    BuildingController bc = new BuildingController();
        try {
        boolean p1 = bc.addBuilding("Testnavn", "Testadresse", "12ab", 25, 1);
        assertEquals(true, p1);
        boolean p2 = bc.addBuilding("Testnavn", "Testadresse", "12 ab", 25, 1);
        assertEquals(false, p2);
        boolean p3 = bc.addBuilding("Testnavn", "Testadresse", "12AB", 25, 1);
        assertEquals(false, p3);
        boolean p4 = bc.addBuilding("Testnavn", "Testadresse", "12345678912345678900", 25, 1);
        assertEquals(true, p4);
        boolean p5 = bc.addBuilding("Testnavn", "Testadresse", "12345678912345678900465", 25, 1);
        assertEquals(false, p5);
        boolean test1 = bc.addBuilding("Testnavn", "Testadresse", "12ab", 25, 1);
        assertEquals(true, test1);
        boolean test2 = bc.addBuilding("Testnavn", null, "12ab", 25, 1);
        assertEquals(false, test2);
        boolean test3 = bc.addBuilding("Testnavn", "Testadresse", "12ab", -123, 1);
        assertEquals(false, test3);
        } catch (SQLException ex) {
            ex.printStackTrace();
        } 
    }
    
    @Test
    public void testGetBuildingById() {
        BuildingController bc = new BuildingController(); 
        
        int buildingId = 2;
        int userId = 5;
        try {
       /* Building expResult = bc.getCustomerBuilding(2, 5);
        Building result = bc.getCustomerBuilding(buildingId, userId);
        assertEquals(expResult, result); 
        */
        //Building expResultF = bc.getCustomerBuilding(1, null);
        Building resultF = bc.getCustomerBuilding(buildingId, userId);
        assertNull(resultF);
        
        
        } catch  (SQLException ex) {
            ex.printStackTrace();
        }
     }
    @Test
    public void testDeleteBuilding() {
        BuildingController bc = new BuildingController();
        try {
            bc.deleteBuilding(1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    // TODO add test methods here.
    // The methods must be annotated with annotation @Test. For example:
    //
    // @Test
    // public void hello() {}
}
