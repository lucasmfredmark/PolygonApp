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
public class SupportException extends Exception {

    /**
     * Creates a new instance of <code>SupportException</code> without detail
     * message.
     */
    public SupportException() {
    }

    /**
     * Constructs an instance of <code>SupportException</code> with the
     * specified detail message.
     *
     * @param msg the detail message.
     */
    public SupportException(String msg) {
        super(msg);
    }
}
