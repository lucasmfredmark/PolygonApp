<%-- 
    Document   : userBuildings
    Created on : 14-04-2016, 12:23:26
    Author     : HazemSaeid
--%>

<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>


        <p class="breadcrumbs"><span>Your buildings</span></p>
        <%
            User user = (User) session.getAttribute("user");
            String buildingId = request.getParameter("buildingId");
            AdminController ac = new AdminController();
            ArrayList<Building> buildings = ac.getCustomerBuildings(user.getUserId());
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
            <!-- Link virker ikke -->
            <tr onclick="document.location = 'viewbuilding.jsp?buildingId=<%= b.getBuildingId()%>';">
                <td><%= b.getBuildingName()%></td>
                <td><%= b.getBuildingAddress()%></td>
                <td><%= b.getBuildingParcelNumber()%></td>
                <td><%= b.getBuildingSize()%></td>
                <td><%= b.getBuildingId() %></td>
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
    </body>
</html>
