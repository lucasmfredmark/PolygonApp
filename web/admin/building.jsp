<%-- 
    Document   : building
    Created on : 13-Apr-2016, 12:09:18
    Author     : Staal
--%>

<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            
            User user = (User) session.getAttribute("user");
            int buildingId = 1;
            BuildingController buildingController = new BuildingController();
            Building building = buildingController.getCustomerBuilding((buildingId), user.getUserId());
            

        %>
       <h1 class="center" style="margin-top: 20px;">View building "<%= building.getBuildingName() %>"</h1>
        <div style="width: 600px; margin: 20px auto; padding: 10px; background: #fafafa; border: 1px solid #333;">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 40%;"><h3 style="font-weight: bold; text-align: left;">Building name:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getBuildingName() %></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Address:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getBuildingAddress() %></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Parcel number:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getBuildingParcelNumber() %></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Size in m&sup2;:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getBuildingSize() %></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Condition level:</h3></td>
                    <td><h3 style="text-align: left;"><%= buildingController.getBuildingConditionLevel(buildingId) %></h3></td>
                </tr>
            </table>
        </div>
        <div class="button">
            <a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a>
        </div>
       
        <div class="button">
            <a href="buildings.jsp"><- Back to overview</a>
        </div>
        <br><hr><br>