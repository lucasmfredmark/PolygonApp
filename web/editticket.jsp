<%-- 
    Document   : editticket
    Created on : 20-04-2016, 02:00:39
    Author     : xboxm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="serviceLayer.entities.Ticket"%>
<%@page import="serviceLayer.exceptions.SupportException"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.SupportController"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit support ticket</title>
    </head>
    <body>
        <a href="support.jsp">Back to support tickets</a> <br> <br>
        
        <% 
            SupportController sc = new SupportController();
            int ticketId = Integer.parseInt(request.getParameter("ticketId"));
            Ticket ticket = sc.getTicket(ticketId);
            String title = ticket.getTitle();
            String text = ticket.getText();
            String answer = sc.getAnswerToTicket(ticketId);
            if (answer == null) {
                answer = "Your ticket has not been reviewed yet";
            }
        %>
        
        <form method="POST" action="SupportServlet">
            Title: <br>
            <input type="text" name="title" value='<%=title%>' readonly> <br><br>
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="ticketId" value='<%=ticketId%>'>
            Text: <br>
            <textarea name="text" style="width:400px; height:200px" placeholder='<%=text%>' autofocus required></textarea>
            <br> <br> 
            <input type="submit" value="Commit changes"> <br> <br>
            Answer from an employee: <br>
            <textarea name="answer" style="width:400px; height:200px" placeholder='<%=answer%>' readonly></textarea>
        </form>
        
    </body>
</html>
