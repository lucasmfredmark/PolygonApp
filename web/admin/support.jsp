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

        <style>

            table td {
                padding:5px;
            }

        </style>
    </head>
    <body>

        <% User user = (User) session.getAttribute("user");%>

        <div id="site">
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
                    <li class="active"><a href="index.jsp">Support</a></li>
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
                }

            %>

            <div class="box viewbuilding">
                <h1>Support tickets</h1>
                <%                SupportController sc = new SupportController();
                    ArrayList<Ticket> tickets = sc.getAllTickets();

                    if (tickets.size() > 0) {
                        out.print("<table class='viewdocs'>");
                        for (Ticket t : tickets) {
                            out.print("<tr>");
                            out.print("<td> ID </td>");
                            out.print("<td style='min-width:150px'> Title </td>");
                            out.print("<td style='width:300px'> Message </td>");
                            out.print("<td> Status </td>");
                            out.print("</tr>");
                            out.print("<tr onclick=\"document.location='answerticket.jsp?ticketId=" + t.getTicketId() + "'\">");
                            out.print("<td>" + t.getTicketId() + "</td>");
                            out.print("<td>" + t.getTitle() + "</td>");
                            out.print("<td>" + t.getText() + "</td>");
                            out.print("<td>" + t.getState() + "</td>");
                            out.print("</tr>");
                        }
                        out.print("</table> <br>");
                        out.print("<p>Click on a ticket to read/answer/close it.</p>");
                    } else {
                        out.print("<br><p>There are no tickets reported to this building.</p>");
                    }

                %>
            </div>

            <%                if (request.getParameter("error") != null) {
                    out.print("<h3 style='color:red' class='center'>" + request.getParameter("error") + "</h3>");
                } else if (request.getParameter("message") != null) {
                    out.print("<h3 style='color:green' class='center'>" + request.getParameter("message") + "</h3>");
                }
            %>


    </body>
</html>
