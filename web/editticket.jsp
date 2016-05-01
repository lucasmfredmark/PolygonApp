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
        <title>Polygon - Support ticket</title>
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
                    <h2>Viewing ticket</h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/buildings.jsp">Your buildings</a></li>
                        <li class="inactive"><a href="/PolygonApp/addbuilding.jsp">Add building</a></li>
                        <li class='inactive'><a href="/PolygonApp/support.jsp">Support</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="\PolygonApp\buildings.jsp">Your buildings</a> &raquo; <a href="\PolygonApp\support.jsp">Support</a> &raquo; Create ticket</p>
                
                <%
                    SupportController sc = new SupportController();
                    int ticketId = Integer.parseInt(request.getParameter("ticketId"));
                    Ticket t = sc.getTicket(ticketId);
                    String answer = sc.getAnswerToTicket(ticketId);
                    if (answer == null) {
                        answer = "Your ticket has not been reviewed yet.";
                    }
                %>
                <div class="left_column">
                    <div class="box">
                        <h1>Your ticket</h1>
                        <form method="POST" action="SupportServlet">
                            <input type="text" name="title" placeholder="Title" value="<%= t.getTitle() %>" readonly>
                            <input type="hidden" name="action" value="edit">
                            <input type="hidden" name="ticketId" value='<%= ticketId %>'>
                            <textarea name="text" rows="6" placeholder="Description" autofocus required><%= t.getText() %></textarea>
                            <input type="submit" value="Commit changes">
                        </form>
                    </div>
                </div>
                <div class='right_column'>
                    <div class="box">
                        <h1>Employee answer</h1>
                        <textarea name="answer" rows="6" readonly><%= answer %></textarea>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
