<%-- 
    Document   : createticket
    Created on : 20-04-2016, 01:52:50
    Author     : xboxm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="serviceLayer.entities.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <title>Create a support ticket</title>
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
                <h2>Create Support Ticket</h2>
                <ul>
                    <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                    <li class="inactive"><a href="support.jsp">Support</a></li>
                </ul>
            </div>
            <br>
            <form method="POST" action="SupportServlet" style="width:400px">
                <input type="text" name="title" placeholder="Title of ticket" maxlength="50" required autofocus> <br><br>
                <input type="hidden" name="action" value="create">
                <textarea name="text" style="width:400px; height:150px" placeholder="Describe your problem as detailed as possible" required></textarea>
                <br> <br> 
                <input type="submit" value="Create ticket">
            </form>

    </body>
</html>
