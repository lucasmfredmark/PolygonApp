package serviceLayer.entities;

public class Damage {
    int damageId;
    String dmgDate;
    String dmgTitle;
    String dmgDesc;

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