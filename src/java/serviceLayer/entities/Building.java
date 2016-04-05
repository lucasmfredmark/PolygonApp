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
    private String buildingDate;
    private String buildingName;
    private String buildingAddress;
    private String buildingParcelNumber;
    private int buildingSize;

    public Building(int buildingId, String buildingDate, String buildingName, String buildingAddress, String buildingParcelNumber, int buildingSize) {
        this.buildingId = buildingId;
        this.buildingDate = buildingDate;
        this.buildingName = buildingName;
        this.buildingAddress = buildingAddress;
        this.buildingParcelNumber = buildingParcelNumber;
        this.buildingSize = buildingSize;
    }

    public int getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(int buildingId) {
        this.buildingId = buildingId;
    }

    public String getBuildingDate() {
        return buildingDate;
    }

    public void setBuildingDate(String buildingDate) {
        this.buildingDate = buildingDate;
    }

    public String getBuildingName() {
        return buildingName;
    }

    public void setBuildingName(String buildingName) {
        this.buildingName = buildingName;
    }

    public String getBuildingAddress() {
        return buildingAddress;
    }

    public void setBuildingAddress(String buildingAddress) {
        this.buildingAddress = buildingAddress;
    }

    public String getBuildingParcelNumber() {
        return buildingParcelNumber;
    }

    public void setBuildingParcelNumber(String buildingParcelNumber) {
        this.buildingParcelNumber = buildingParcelNumber;
    }

    public int getBuildingSize() {
        return buildingSize;
    }

    public void setBuildingSize(int buildingSize) {
        this.buildingSize = buildingSize;
    }
}
