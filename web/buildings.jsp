<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
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
        <title>Polygon - Your buildings</title>
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
                <h1>Overview of your buildings</h1>
                <ul>
                    <li class="active"><a href="buildings.jsp">Your buildings</a></li>
                    <li class="inactive"><a href="addbuilding.jsp">Add building</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><span>Your buildings</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3 class='errormsg'>" + request.getParameter("error") + "</h3>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3 class='errormsg'>" + request.getParameter("success") + "</h3>");
                    }
                %>
                <%
                    BuildingController bc = new BuildingController();
                    ArrayList<Building> buildings = bc.getCustomerBuildings(user.getUserId());
                    if (buildings.size() > 0) {
                %>
                <table class="btable">
                    <!-- TABLE HEADER -->
                    <tr>
                        <td>Building name</td>
                        <td>Address</td>
                        <td>Parcel number</td>
                        <td>Size(m&sup2)</td>
                        <td>Condition level</td>
                    </tr>
                    <%
                        for (Building b : buildings) {
                    %>
                    <tr onclick="document.location='viewbuilding.jsp?buildingId=<%= b.getBuildingId() %>';">
                        <td><%= b.getBuildingName() %></td>
                        <td><%= b.getBuildingAddress()%></td>
                        <td><%= b.getBuildingParcelNumber()%></td>
                        <td><%= b.getBuildingSize() %></td>
                        <!-- Skal fortolke værdien. -->
                        <td><%= bc.getBuildingConditionLevel(b.getBuildingId()) %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <% 
                    } else { // If there are currently no buildings linked to this user. MANGLER HTML 
                        out.print("You haven't added any buildings yet. Click on the button below to add one.");
                    }
                %>
            </div>
        </div>
    </div>
    </body>
</html>
