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
        <title>Polygon - Answer ticket</title>
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
                    <h2>Answering to a ticket</h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/admin/index.jsp">Dashboard</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/users.jsp">Users</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/buildings.jsp">Buildings</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/pending.jsp">Checkups</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/support.jsp">Support tickets</a></li>
                    </ul>
                </div>
            </div>
        </div>
                
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="/PolygonApp/admin/index.jsp">Admin panel</a> &raquo; <a href="/PolygonApp/admin/support.jsp">Support</a> &raquo; Answer ticket</p>

                    <%
                        SupportController sc = new SupportController();
                        int ticketId = Integer.parseInt(request.getParameter("ticketId"));
                        Ticket t = sc.getTicket(ticketId);
                        String title = t.getTitle();
                        String text = t.getText();
                        String answer = sc.getAnswerToTicket(ticketId);
                        if (answer == null) {
                            answer = "Your ticket has not been reviewed yet";
                        }
                    %>
                    
                    <div class="left_column">
                        <div class="box">
                            <h1>Customers ticket</h1>
                            <form method='POST' action='/PolygonApp/SupportServlet'>
                                <input type="text" name="title" placeholder="Title" value="<%= t.getTitle() %>" readonly>
                                <textarea name="text" rows="6" placeholder="Description" readonly><%= t.getText() %></textarea>
                                <input type="hidden" name="ticketId" value='<%=ticketId%>'>
                                <input type="hidden" name="action" value="close">
                                <input type="submit" onclick='return confirm("Are you sure?")' value="Close ticket">
                            </form>
                        </div>
                    </div>
                    <div class='right_column'>
                        <div class="box">
                            <h1>Your answer</h1>
                            <form method="POST" action="/PolygonApp/SupportServlet">
                                <textarea name="answer" rows="6" placeholder="Type your answer to the customer here" required autofocus></textarea>
                                <input type="hidden" name="action" value="answer">
                                <input type="hidden" name="ticketId" value='<%=ticketId%>'>
                                <input type="submit" value="Commit answer">
                            </form>
                        </div>
                    </div>
            </div>
        </div>
    </body>
</html>
