/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.entities;

/**
 *
 * @author Staal
 */
public class Documents {
    private int documentId;
    private String ddate;
    private String dpath;
    private int buildingId;

public Documents(int documentId, String ddate, String dpath, int buildingId){
    this.documentId = documentId;
    this.ddate = ddate;
    this.dpath = dpath;
    this.buildingId = buildingId;
}

    public int getDocumentId() {
        return documentId;
    }


    public void setDocumentId(int documentId) {
        this.documentId = documentId;
    }

 
    public String getDdate() {
        return ddate;
    }

   
    public void setDdate(String ddate) {
        this.ddate = ddate;
    }

   
    public String getDpath() {
        return dpath;
    }

    public void setDpath(String dpath) {
        this.dpath = dpath;
    }

   
    public int getBuildingId() {
        return buildingId;
    }

    public void setBuildingId(int buildingId) {
        this.buildingId = buildingId;
    }
    
}
