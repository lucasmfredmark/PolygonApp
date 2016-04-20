<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SESSION CHECK
    User user = (User) session.getAttribute("user");

    if(request.getParameter("logout") != null) {

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
                <p>Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
            </div>
        </div>
        <div id="navigation">
            <div class="wrapper">
                <h2>Overview of your buildings</h2>
                <ul>
                    <li class="active"><a href="buildings.jsp">Your buildings</a></li>
                    <li class="inactive"><a href="addbuilding.jsp">Add building</a></li>
                    <li class='inactive'><a href='support.jsp'>Support</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><span>Your buildings</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3 class='errormsg'>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3 class='errormsg'>" + request.getParameter("success") + "</h3><br>");
                    }

                    BuildingController bc = new BuildingController();
                    ArrayList<Building> buildings = bc.getCustomerBuildings(user.getUserId());
                    if (buildings.size() > 0) {
                %>
                
                <div class="table">
                    <table class="buildings_table">
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
                                out.print("<tr onclick=\"document.location='viewbuilding.jsp?buildingId=" + b.getBuildingId() + "'\">");
                                    out.print("<td>" + b.getBuildingName() + "</td>");
                                    out.print("<td>" + b.getBuildingAddress()+ "</td>");
                                    out.print("<td>" + b.getBuildingParcelNumber()+ "</td>");
                                    out.print("<td>" + b.getBuildingSize()+ "</td>");
                                    out.print("<td>" + bc.getBuildingConditionLevel(b.getBuildingId())+ "</td>");
                                out.print("</tr>");
                            }
                        %>
                    </table>
                </div>
                <% 
                    } else { // If there are currently no buildings linked to this user. MANGLER HTML 
                        out.print("<h3>You haven't added any buildings yet. Click on the button above to add one.</h3>");
                    }
                %>
            </div>
        </div>
    </div>
    </body>
</html>
