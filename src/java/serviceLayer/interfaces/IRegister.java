/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.interfaces;

/**
 *
 * @author lucas
 */
public interface IRegister {
    boolean ifExists(String uname); 
    boolean create(String uname, String pword);
}
