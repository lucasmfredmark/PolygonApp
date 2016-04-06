/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serviceLayer.entities;

/**
 *
 * @author HazemSaeid
 */
public class Damage {

    int damageId;
    String dmgDate = "";
    String dmgTitle = "";
    String dmgDesc = "";

    public Damage(int damageId, String dmgDate, String dmgTitle, String dmgDesc) {
        this.damageId = damageId;
        this.dmgDate = dmgDate;
        this.dmgTitle = dmgTitle;
        this.dmgDesc = dmgDesc;
    }
    public int getDamageId() {
        return damageId;
    }

    public void setDamageId(int damageId) {
        this.damageId = damageId;
    }

    public String getDmgDate() {
        return dmgDate;
    }

    public void setDmgDate(String dmgDate) {
        this.dmgDate = dmgDate;
    }

    public String getDmgTitle() {
        return dmgTitle;
    }

    public void setDmgTitle(String dmgTitle) {
        this.dmgTitle = dmgTitle;
    }

    public String getDmgDesc() {
        return dmgDesc;
    }

    public void setDmgDesc(String dmgDesc) {
        this.dmgDesc = dmgDesc;
    }
    
    
}
