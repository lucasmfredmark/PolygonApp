/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.entities;

/**
 *
 * @author xboxm
 */
public class Order {
    
    private int orderId;
    private String dateReceived;
    private String orderStatus;
    private String dateDone;

    public Order(int orderId, String dateReceived, String orderStatus, String dateDone) {
        this.orderId = orderId;
        this.dateReceived = dateReceived;
        this.orderStatus = orderStatus;
        this.dateDone = dateDone;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getDateReceived() {
        return dateReceived;
    }

    public void setDateReceived(String dateReceived) {
        this.dateReceived = dateReceived;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getDateDone() {
        return dateDone;
    }

    public void setDateDone(String dateDone) {
        this.dateDone = dateDone;
    }
    
}
