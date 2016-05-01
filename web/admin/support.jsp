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
    } else if (user.getUserType().equals(User.userType.CUSTOMER)) {
        response.sendRedirect("/PolygonApp/buildings.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <script src="../js/jquery-1.12.3.min.js"></script>
        <script src="../js/main.js"></script>
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
                    <h2>Support ticket overview</h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/admin/index.jsp">Dashboard</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/users.jsp">Users</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/buildings.jsp">Buildings</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/pending.jsp">Checkups</a></li>
                        <li class="active"><a href="/PolygonApp/admin/support.jsp">Support tickets</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="/PolygonApp/admin/index.jsp">Admin panel</a> &raquo; Support</p>
        
                <div class="table">
                    <table class="adminsupport_table">
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
                            <td>ID</td>
                            <td>Title</td>
                            <td>Message</td>
                            <td>Status</td>
                        </tr>
                        <%
                            SupportController sc = new SupportController();
                            ArrayList<Ticket> tickets = sc.getAllTickets();

                            if (tickets.size() > 0) {
                                for (Ticket t : tickets) {
                                    out.print("<tr onclick=\"document.location='/PolygonApp/admin/answerticket.jsp?ticketId=" + t.getTicketId()+ "'\">");
                                        out.print("<td>" + t.getTicketId() + "</td>");
                                        out.print("<td>" + t.getTitle()+ "</td>");
                                        out.print("<td>" + t.getText() + "</td>");
                                        out.print("<td>" + t.getState() + "</td>");
                                    out.print("</tr>");
                                }
                            } else {
                                out.print("<tr class='nohover'>");
                                    out.print("<td colspan='5'>You have no support tickets yet.</td>");
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
