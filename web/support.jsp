<%-- 
    Document   : support
    Created on : 19-04-2016, 22:58:13
    Author     : xboxm
--%>
<%@page import="serviceLayer.entities.Ticket"%>
<%@page import="serviceLayer.exceptions.SupportException"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.SupportController"%>
<%@page import="java.util.ArrayList"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <title>Support tickets</title>
    </head>
    <body>
        
        <% User user = (User) session.getAttribute("user"); %>
        
        <div id="site">
        <div id="header">
            <div class="wrapper">
                <img src="/PolygonApp/images/polygon-logo.svg" class="header_logo" alt="Polygon">
                <p>Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
            </div>
        </div>
        <div id="navigation">
            <h2>Support Ticket</h2>
            <ul>
                    <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                </ul>
        </div>
        <br>
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

        <div class="box viewbuilding">
            <%                SupportController sc = new SupportController();
                int userId = user.getUserId();
                ArrayList<Ticket> tickets = sc.getAllTicketsForCustomer(userId);

                if (tickets.size() > 0) {
                    out.print("<table class='viewdocs'>");
                    for (Ticket t : tickets) {
                        out.print("<tr>");
                        out.print("<td> <span style='font-weight:bold'>ID</span> </td>");
                        out.print("<td style='width:150px'> <span style='font-weight:bold'>Title</span> </td>");
                        out.print("<td style='width:600px'> <span style='font-weight:bold'>Message</span> </td>");
                        out.print("<td> <span style='font-weight:bold'>Status</span> </td>");
                        out.print("</tr>");
                        out.print("<tr onclick=\"document.location='editticket.jsp?ticketId=" + t.getTicketId() + "'\">");
                        out.print("<td>" + t.getTicketId() + "</td>");
                        out.print("<td>" + t.getTitle() + "</td>");
                        out.print("<td>" + t.getText() + "</td>");
                        out.print("<td>" + t.getState() + "</td>");
                        out.print("</tr>");
                    }
                    out.print("</table> <br>"); 
                    out.print("<p>Click on a ticket to edit/view it.</p>");
                } else {
                    out.print("<br><p>There are no tickets reported to this building.</p>");
                }

            %>
        </div>



        <p> 
        <form method="POST" action="createticket.jsp" style="width:220px">
            <input type="submit" value="New ticket">
        </form>
        </p>
    </body>
</html>
