<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SESSION CHECK
    User user = (User) session.getAttribute("user");
    
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    
    if(request.getParameter("logout") != null) {

        if (request.getSession(false) != null) {
            session.invalidate();
        } 

        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="css/resets.css" rel="stylesheet" type="text/css">
        <link href="css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Add building</title>
    </head>
    <body>
    <div id="site">
        <div id="header">
            <div class="wrapper">
                <img src="images/polygon-logo.svg" class="header_logo" alt="Polygon">
                <p class="signout">Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
            </div>
        </div>
        <div id="navigation">
            <div class="wrapper">
                <h2>Add a new building</h2>
                <ul>
                    <li class="inactive"><a href="buildings.jsp">Your buildings</a></li>
                    <li class="active"><a href="addbuilding.jsp">Add building</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="buildings.jsp">Your buildings</a> &raquo; <span>Add building</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                <form class="building" method="POST" action="BuildingServlet">
                    <input type="text" name="bname" placeholder="Name of building" maxlength="40" required autofocus>
                    <input type="text" name="address" placeholder="Address" maxlength="50" required>
                    <input type="text" name="parcel" placeholder="Parcel number" maxlength="20" pattern="[0-9a-z]+" required>
                    <input type="text" name="size" placeholder="Size in m&sup2" pattern="\d*" required>
                    <input type="hidden" name="action" value="add">
                    <input type="submit" value="Add new building">
                </form>
            </div>
        </div>
    </div>
    </body>
</html>