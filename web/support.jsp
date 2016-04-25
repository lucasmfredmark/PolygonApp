<%@page import="serviceLayer.entities.*"%>
<%@page import="serviceLayer.exceptions.*"%>
<%@page import="serviceLayer.controllers.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SIGN OUT
    if(request.getParameter("logout") != null) {
        if (request.getSession(false) != null) {
            session.invalidate();
        }
        response.sendRedirect("/PolygonApp/index.jsp");
        return;
    }
    
    // SESSION CHECK
    User user = (User) session.getAttribute("user");
    
    if (user == null) {
        response.sendRedirect("/PolygonApp/index.jsp");
        return;
    } else if (user.getUserType().equals(User.userType.ADMIN)) {
        response.sendRedirect("/PolygonApp/admin/index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Support</title>
    </head>
    <body>
        <div id="top">
            <div id="header">
                <div class="wrapper">
                    <img src="/PolygonApp/images/polygon-logo.svg" class="header_logo" alt="Polygon">
                    <p>Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
                </div>
            </div>
            <div id="navigation">
                <div class="wrapper">
                    <h2>Overview of your support tickets</h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/buildings.jsp">Your buildings</a></li>
                        <li class="inactive"><a href="/PolygonApp/addbuilding.jsp">Add building</a></li>
                        <li class='active'><a href="/PolygonApp/support.jsp">Support</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="\PolygonApp\buildings.jsp">Your buildings</a> &raquo; Support</p>
        
                <div class="table">
                    <table class="support_table">
                        <!-- FEEDBACK MESSAGES -->
                        <%
                            if (request.getParameter("error") != null) {
                                out.print("<h3 class='errormsg'>" + request.getParameter("error") + "</h3><br>");
                            } else if (request.getParameter("success") != null) {
                                out.print("<h3 class='errormsg'>" + request.getParameter("success") + "</h3><br>");
                            }
                        %>
                        <!-- TABLE HEADER -->
                        <tr>
                            <td>Title</td>
                            <td>Message</td>
                            <td>Status</td>
                        </tr>
                        <%
                            SupportController sc = new SupportController();
                            ArrayList<Ticket> tickets = sc.getAllTicketsForCustomer(user.getUserId());

                            if (tickets.size() > 0) {
                                for (Ticket t : tickets) {
                                    out.print("<tr onclick=\"document.location='/PolygonApp/editticket.jsp?ticketId=" + t.getTicketId()+ "'\">");
                                        out.print("<td>" + t.getTitle()+ "</td>");
                                        out.print("<td>" + t.getText() + "</td>");
                                        out.print("<td>" + t.getState() + "</td>");
                                    out.print("</tr>");
                                }
                            } else {
                                out.print("<tr class='nohover'>");
                                    out.print("<td colspan='5'>You have no buildings added to your account.</td>");
                                out.print("</tr>");
                                out.print("<tr class='nohover'>");
                                    out.print("<td colspan='5'>Click <a href='/PolygonApp/addbuilding.jsp'>here</a> to add one.</td>");
                                out.print("</tr>");
                            }
                        %>
                    </table>
                    <form method="POST" action="createticket.jsp">
                        <input type="submit" class="btn" value="Create a new ticket">
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
