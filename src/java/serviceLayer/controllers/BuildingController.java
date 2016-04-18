/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.controllers;

import dataAccessLayer.mappers.BuildingMapper;
import java.sql.SQLException;
import java.util.ArrayList;
import serviceLayer.entities.Building;
import serviceLayer.entities.Checkup;
import serviceLayer.entities.Damage;
import serviceLayer.entities.Document;
import serviceLayer.entities.Order;
import serviceLayer.entities.User;
import serviceLayer.exceptions.BuildingException;

/**
 *
 * @author Staal
 */
public class BuildingController{
    private final BuildingMapper buildingMapper;

    public BuildingController() {
        this.buildingMapper = new BuildingMapper();
    }

    public Building getCustomerBuilding(int buildingId, int userId) throws BuildingException {
        return buildingMapper.getCustomerBuilding(buildingId, userId);
    }

    public ArrayList<Building> getCustomerBuildings(int userId) throws BuildingException {
        return buildingMapper.getCustomerBuildings(userId);
    }

    public void addCustomerBuilding(String name, String address, String parcelNumber, int size, int userId) throws BuildingException {
        if (name != null && address != null && parcelNumber != null && size > 0 && userId > 0) {
            if (name.length() <= 40 && address.length() <= 50 && parcelNumber.length() <= 20) {
                if (parcelNumber.matches("[0-9a-z]+") && String.valueOf(size).matches("\\d*")) {
                    buildingMapper.addCustomerBuilding(name, address, parcelNumber, size, userId);
                }
            }
        } else {
            throw new BuildingException("One or more fields are null or size/userid less than 1");
        }
    }

    public void deleteCustomerBuilding(int buildingId) throws BuildingException {
        if (buildingId > 0) {
            buildingMapper.deleteCustomerBuilding(buildingId);
        } else {
            throw new BuildingException("The building id does not exist");
        }
    }

    public void editCustomerBuilding(String name, String address, String parcelNumber, int size, int buildingId) throws BuildingException {
        if (name != null && address != null && parcelNumber != null && size > 0 && buildingId > 0) {
            if (name.length() <= 40 && address.length() <= 50 && parcelNumber.length() <= 20) {
                if (parcelNumber.matches("[0-9a-z]+") && String.valueOf(size).matches("\\d*")) {
                    buildingMapper.editCustomerBuilding(name, address, parcelNumber, size, buildingId);
                }
            }
        } else {
            throw new BuildingException("One or more fields are null or less than 1");
        }
        
    }

    public ArrayList<Checkup> getBuildingCheckups(int buildingId) throws BuildingException {
        return buildingMapper.getBuildingCheckups(buildingId);
    }

    public ArrayList<Document> getBuildingDocuments(int buildingId) throws BuildingException {
        return buildingMapper.getBuildingDocuments(buildingId);
    }

    public int getBuildingConditionLevel(int buildingId) throws BuildingException {
        return buildingMapper.getBuildingConditionLevel(buildingId);
    }
    
    public void addCheckUpReport(String checkupPath, int conditionLevel, int buildingId, int orderId) throws BuildingException{
        if (checkupPath != null && buildingId > 0 && orderId > 0 && conditionLevel >= -1 && conditionLevel <= 3) {
            buildingMapper.addCheckUpReport(checkupPath, conditionLevel, buildingId, orderId);
    }
    }

    public void addCustomerDocument(String documentNote, String documentPath, int buildingId, int userId) throws BuildingException {
        if (documentNote != null && documentPath != null && buildingId > 0 && userId > 0) {
            buildingMapper.addCustomerDocument(documentNote, documentPath, buildingId, userId);
        }
    }

    public void addDamage(String dmgTitle, String dmgDesc, int buildingId) throws BuildingException {
        if (dmgTitle != null && dmgDesc != null && buildingId > 0) {
            buildingMapper.addDamage(dmgTitle, dmgDesc, buildingId);
        }
    }

    public void deleteDamage(int damageId) throws BuildingException {
        if (damageId > 0) {
            buildingMapper.deleteDamage(damageId);
        }
    }
    
    public ArrayList<Damage> getDamages(int buildingId) throws BuildingException {
        return buildingMapper.getBuildingDamages(buildingId);
    }
    
    public void requestCheckup(int orderStatus, int buildingId, User user) throws BuildingException {
        // A mail server is required for the e-mail to be sent
        /*
        String to = "checkup@polygon.dk";
        String from = user.getUserMail();
        String host = "localhost";
        Properties properties = System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        Session session = Session.getDefaultInstance(properties);
        
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Check-up requested from " + user.getFullName());
            
            Building building = getCustomerBuilding(buildingId, user.getUserId());
            
            if (building != null) {
                message.setText("A check-up has been requested from " + user.getFullName() + " (" + user.getUserMail() + ").\n\n"
                        + "== Building Information ==\n\n"
                        + "Building ID: " + building.getBuildingId() + "\n"
                        + "Building name: " + building.getBuildingName() + "\n"
                        + "Building address: " + building.getBuildingAddress() + "\n"
                        + "Building parcel number: " + building.getBuildingParcelNumber() + "\n"
                        + "Building size: " + building.getBuildingSize());
                
                Transport.send(message);
                */
                buildingMapper.addOrder(orderStatus, buildingId);
            /*
            }
        } catch (MessagingException ex) {
            ex.printStackTrace();
        }
        
        return false;
        */
    }
    
    public Order getOrderByBuildingId(int buildingId) throws BuildingException {
        return buildingMapper.getOrderByBuildingId(buildingId);
    }
    
}
