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
        
        <form method="POST" action="/PolygonApp/SupportServlet">
            Customer subject <br>
            <input type="text" name="title" value='<%=title%>' readonly> <br><br>
            <input type="hidden" name="action" value="answer">
            <input type="hidden" name="ticketId" value='<%=ticketId%>'>
            Customer asked <br>
            <textarea name="text" style="width:400px; height:200px" placeholder='<%=text%>' readonly></textarea>
            <br> <br> 
            Answer from an employee: <br>
            <textarea name="answer" style="width:400px; height:200px" placeholder='Type your answer to the customer here>'></textarea>
            <br> <br>
            <input type="submit" value="Commit answer">
        </form>
        
    </body>
</html>
