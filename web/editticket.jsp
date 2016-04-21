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
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
    </head>
    <body>

        <% User user = (User) session.getAttribute("user"); %>

        <%

            // SESSION CHECK
            if (request.getParameter("logout") != null) {

                if (request.getSession(false) != null) {
                    session.invalidate();
                }

                response.sendRedirect("index.jsp");
                return;
            }

            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            } else if (user.getUserType().equals(User.userType.ADMIN)) {
                response.sendRedirect("admin/index.jsp");
                return;
            }

        %>

        <div id="site">
            <div id="header">
                <div class="wrapper">
                    <img src="/PolygonApp/images/polygon-logo.svg" class="header_logo" alt="Polygon">
                    <p>Hello, <%= user.getFullName()%> (<a href="?logout">Sign out</a>)</p>
                </div>
            </div>
            <div id="navigation">
                <h2>Edit Support Ticket</h2>
                <ul>
                    <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                    <li class="inactive"><a href="support.jsp">Support</a></li>
                </ul>
            </div>

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

            <form method="POST" action="SupportServlet" style="width:200px"> <br>
                Title:
                <input type="text" name="title" value='<%=title%>' readonly>
                <input type="hidden" name="action" value="edit">
                <input type="hidden" name="ticketId" value='<%=ticketId%>'>
                Text:
                <textarea id='txt' name="text" style="width:400px; height:150px" placeholder='<%=text%>' autofocus required></textarea>
                <input type="submit" value="Commit changes"> <br>
                Answer from an employee:
                <textarea name="answer" style="width:400px; height:150px" placeholder='<%=answer%>' readonly></textarea>
            </form>
    </body>
</html>
