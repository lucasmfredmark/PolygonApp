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
public class Ticket {
    
    private String text;
    private String title;
    private String answer;
    private int state;
    private int ticketId;
    private int userid;

    public Ticket(int ticketId, String title, String text, int state, int userid) {
        this.text = text;
        this.title = title;
        this.ticketId = ticketId;
        this.state = state;
        this.userid = userid;
        this.answer = getAnswer();
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }
    
    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getState() {
        if (this.state == 1) {
            return "open";
        } else {
            return "closed";
        }
    }

    public void setState(int state) {
        this.state = state;
    }
    
    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }
    
    
    
}
