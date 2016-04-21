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
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <title>Edit support ticket</title>
    </head>
    <body>

        <% User user = (User) session.getAttribute("user");%>

        <div id="header">
            <div class="wrapper">
                <img src="/PolygonApp/images/polygon-logo.svg" class="header_logo" alt="Polygon">
                <p>Hello, <%= user.getFullName()%> (<a href="?logout">Sign out</a>)</p>
            </div>
        </div>
        <div id="navigation">
            <h2>Support Ticket</h2>
            <ul>
                <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                <li class="inactive"><a href="support.jsp">Support</a></li>
            </ul>
        </div>
        <br>

        <%            SupportController sc = new SupportController();
            int ticketId = Integer.parseInt(request.getParameter("ticketId"));
            Ticket ticket = sc.getTicket(ticketId);
            String title = ticket.getTitle();
            String text = ticket.getText();
            String answer = sc.getAnswerToTicket(ticketId);
            if (answer == null) {
                answer = "Your ticket has not been reviewed yet";
            }
        %>

        <form method="POST" action="/PolygonApp/SupportServlet" style="width:400px">
            Customer subject <br>
            <input type="text" name="title" value='<%=title%>' readonly> <br><br>
            <input type="hidden" name="action" value="answer">
            <input type="hidden" name="ticketId" value='<%=ticketId%>'>
            Customer asked <br>
            <textarea name="text" style="width:400px; height:125px" placeholder='<%=text%>' readonly></textarea>
            <br> <br> 
            Answer from an employee: <br>
            <textarea id='answ' name="answer" style="width:400px; height:125px" placeholder='Type your answer to the customer here>'></textarea>
            <br>
            <input type="submit" value="Commit answer" style="float:left; width:150px; margin:auto; margin-left:40px"> 
        </form>

        <form method='POST' action='/PolygonApp/SupportServlet'>
            <input type="hidden" name="ticketId" value='<%=ticketId%>'>
            <input type="hidden" name="action" value="close">
            <input type="submit" onclick='return confirm("Are you sure?")' value="Close ticket" style="float:left; width:150px; margin:auto; margin-left:30px">
        </form>    
    </body>
</html>
