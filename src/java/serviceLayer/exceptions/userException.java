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
public class userException extends Exception {

    /**
     * Creates a new instance of <code>userException</code> without detail
     * message.
     */
    public userException() {
    }

    /**
     * Constructs an instance of <code>userException</code> with the specified
     * detail message.
     *
     * @param msg the detail message.
     */
    public userException(String msg) {
        super(msg);
    }
}
