/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.entities;

/**
 *
 * @author lucas
 */
public class Building {
    private int buildingId;
    private String bdate;
    private String name;
    private String address;
    private String parcelNumber;
    private int size;
    private int conditionLevel;
    private int userId;
    
    public Building(String name, String address, String parcelNumber, int size, int userId) {
        this.name = name;
        this.address = address;
        this.parcelNumber = parcelNumber;
        this.size = size;
        this.userId = userId;
    }
    
    public Building(int buildingId, String bdate, String name, String address, String parcelNumber, int size, int conditionLevel, int userId) {
        this.buildingId = buildingId;
        this.bdate = bdate;
        this.name = name;
        this.address = address;
        this.parcelNumber = parcelNumber;
        this.size = size;
        this.conditionLevel = conditionLevel;
        this.userId = userId;
    }

    public int getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(int buildingId) {
        this.buildingId = buildingId;
    }

    public String getBdate() {
        return bdate;
    }

    public void setBdate(String bdate) {
        this.bdate = bdate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getParcelNumber() {
        return parcelNumber;
    }

    public void setParcelNumber(String parcelNumber) {
        this.parcelNumber = parcelNumber;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public int getConditionLevel() {
        return conditionLevel;
    }

    public void setConditionLevel(int conditionLevel) {
        this.conditionLevel = conditionLevel;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}
