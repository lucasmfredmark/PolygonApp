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
public class Checkup {
    private int checkupId;
    private String checkupDate;
    private String checkupPath;
    private int conditionLevel;
    private int orderId;
    private String orderDate;

    public Checkup(int checkupId, String checkupDate, String checkupPath, int conditionLevel, int orderId, String orderDate) {
        this.checkupId = checkupId;
        this.checkupDate = checkupDate;
        this.checkupPath = checkupPath;
        this.conditionLevel = conditionLevel;
        this.orderId = orderId;
        this.orderDate = orderDate;
    }

    public int getCheckupId() {
        return checkupId;
    }

    public void setCheckupId(int checkupId) {
        this.checkupId = checkupId;
    }

    public String getCheckupDate() {
        return checkupDate;
    }

    public void setCheckupDate(String checkupDate) {
        this.checkupDate = checkupDate;
    }

    public String getCheckupPath() {
        return checkupPath;
    }

    public void setCheckupPath(String checkupPath) {
        this.checkupPath = checkupPath;
    }

    public int getConditionLevel() {
        return conditionLevel;
    }

    public void setConditionLevel(int conditionLevel) {
        this.conditionLevel = conditionLevel;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    
    public String getOrderDate() {
        return orderDate;
    }
    
    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }
}
