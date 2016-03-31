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
    private String name;
    private String address;
    private int parcelNumber;
    private int size;
    private int conditionLevel;
    
    public Building(String name, String address, int parcelNumber, int size) {
        this.name = name;
        this.address = address;
        this.parcelNumber = parcelNumber;
        this.size = size;
    }
    
    public Building(int buildingId, String name, String address, int parcelNumber, int size, int conditionLevel) {
        this.buildingId = buildingId;
        this.name = name;
        this.address = address;
        this.parcelNumber = parcelNumber;
        this.size = size;
        this.conditionLevel = conditionLevel;
    }
    
    public int getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(int buildingId) {
        this.buildingId = buildingId;
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

    public int getParcelNumber() {
        return parcelNumber;
    }

    public void setParcelNumber(int parcelNumber) {
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
}
