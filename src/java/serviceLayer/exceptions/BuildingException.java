/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.exceptions;

/**
 *
 * @author xboxm
 */
public class BuildingException extends Exception {

    /**
     * Creates a new instance of <code>buildingException</code> without detail
     * message.
     */
    public BuildingException() {
    }

    /**
     * Constructs an instance of <code>buildingException</code> with the
     * specified detail message.
     *
     * @param msg the detail message.
     */
    public BuildingException(String msg) {
        super(msg);
    }
}
