package serviceLayer.entities;

public class Checkup {
    private int checkupId;
    private String checkupDate;
    private String checkupPath;
    private int conditionLevel;

    public Checkup(int checkupId, String checkupDate, String checkupPath, int conditionLevel) {
        this.checkupId = checkupId;
        this.checkupDate = checkupDate;
        this.checkupPath = checkupPath;
        this.conditionLevel = conditionLevel;
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
}