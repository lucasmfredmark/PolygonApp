<%-- 
    Document   : buildings
    Created on : 30-03-2016, 10:33:31
    Author     : lucas
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="css/resets.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Overview</title>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            
            if (user != null) {
        %>
        <h2>Hej <b><%= user.getUname() %></b> (<%= user.getFullName() %>)</h2>
        <h3><%= user.getEmail() %></h3>
        <%
            } /*else {
                response.sendRedirect("index.jsp");
            }*/
        %>
        <br>
        <h1 class="center">Overview</h1>
        <br>
        <table class="overview">
            <tr>
                <th class="t1">Name</th>
                <th class="t2">Address</th>
                <th class="t3">Parcel number</th>
                <th class="t4">Size m&sup2;</th>
                <th class="t5">Condition level</th>
                <th class="t6">Action</th>
            </tr>
            <tr>
            <%
                BuildingController buildingController = new BuildingController();
                ArrayList<Building> buildings = buildingController.getAllBuildings(user);
                
                for (Building b : buildings) {
                    out.print("<td>" + b.getName() + "</td>");
                    out.print("<td>" + b.getAddress()+ "</td>");
                    out.print("<td>" + b.getParcelNumber()+ "</td>");
                    out.print("<td>" + b.getSize()+ "</td>");
                    out.print("<td>" + b.getConditionLevel() + "</td>");
                    out.print("<td><a href=\"#\"><img src=\"images/edit.png\"></a><a href=\"#\"><img src=\"images/delete.png\"></a></td>");
                }
            %>
            </tr>         
        </table>
        <br>
        <form name="overviewform" action="BuildingServlet" method="POST">
            <input type="submit" value="Add a new building">        
        </form>
    </body>
</html>
