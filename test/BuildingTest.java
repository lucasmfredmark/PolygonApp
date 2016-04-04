/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.SQLException;
import org.junit.After;
import org.junit.AfterClass;
import static org.junit.Assert.assertEquals;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import serviceLayer.controllers.BuildingController;
import serviceLayer.entities.Building;

/**
 *
 * @author MalteBruun
 */
public class BuildingTest {
    
    public BuildingTest() {
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
        bc.addBuilding("Testnavn", "Testadresse", "12ab", 123, 1);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    
    }
    @Test
    public void testgetBuildingById() {
        BuildingController bc = new BuildingController(); 
        
        int buildingId = 2;
        int userId = 5;
        try {
        Building expResult = bc.getCustomerBuilding(2, 5);
        Building result = bc.getCustomerBuilding(buildingId, userId);
        assertEquals(expResult, result); 
        } catch 
            (SQLException ex) {
            ex.printStackTrace();
        }
     }
    
    // TODO add test methods here.
    // The methods must be annotated with annotation @Test. For example:
    //
    // @Test
    // public void hello() {}
}
