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
        <title>Support tickets</title>
    </head>
    <body>

        <a href="buildings.jsp">Back to overview</a> <br> <br>

        <%

            // SESSION CHECK
            User user = (User) session.getAttribute("user");

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
            <h1>Support tickets</h1>
            <%                SupportController sc = new SupportController();
                int userId = user.getUserId();
                ArrayList<Ticket> tickets = sc.getAllTicketsForCustomer(userId);

                if (tickets.size() > 0) {
                    out.print("<table class='viewdocs'>");
                    for (Ticket t : tickets) {
                        out.print("<tr>");
                        out.print("<td> ID </td>");
                        out.print("<td> Title </td>");
                        out.print("<td> Message </td>");
                        out.print("<td> Status </td>");
                        out.print("</tr>");
                        out.print("<tr onclick=\"document.location='editticket.jsp?ticketId=" + t.getTicketId() + "'\">");
                        out.print("<td>" + t.getTicketId() + "</td>");
                        out.print("<td>" + t.getTitle() + "</td>");
                        out.print("<td>" + t.getText() + "</td>");
                        out.print("<td>" + t.getState() + "</td>");
                        out.print("</tr>");
                    }
                    out.print("</table>");
                    out.print("<p>Click on a ticket to edit/view it.</p>");
                } else {
                    out.print("<br><p>There are no tickets reported to this building.</p>");
                }

            %>
        </div>



        <p> 
            <a href="createticket.jsp">Create a new ticket</a>
        </p>
    </body>
</html>
