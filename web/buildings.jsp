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
            
            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            }
        %>
        <h3>Hello, <span><%= user.getUname() %></span> (<%= user.getFullName() %>)</h3>
        <h3><%= user.getEmail() %></h3>
        <form action="UserServlet" method="POST" style="padding: 0;">
            <input type="hidden" name="action" value="logout">
            <input type="submit" value="Log out">
        </form>
        <br><hr><br>
        <h1 class="center">Overview</h1>
        <br>
        <table class="overview">
            <tr>
                <th class="t1">Name</th>
                <th class="t2">Address</th>
                <th class="t3">Parcel number</th>
                <th class="t4">Size m&sup2;</th>
                <th class="t5">Condition level</th>
                <th class="t6">Actions</th>
            </tr>
            <%
                BuildingController buildingController = new BuildingController();
                ArrayList<Building> buildings = buildingController.getCustomerBuildings(user);
                
                if (buildings.size() > 0) {
                    for (Building b : buildings) {
                        out.print("<tr>");
                        out.print("<td>" + b.getName() + "</td>");
                        out.print("<td>" + b.getAddress()+ "</td>");
                        out.print("<td>" + b.getParcelNumber()+ "</td>");
                        out.print("<td>" + b.getSize()+ "</td>");
                        out.print("<td>" + b.getConditionLevel() + "</td>");
                            out.print("<td><a href=\"editbuilding.jsp?buildingId=" + b.getBuildingId() + "\"><img src=\"images/edit.png\" title=\"Edit building\"></a> "
                                    + "<form action=\"BuildingServlet\" method=\"POST\"><input type=\"hidden\" name=\"buildingId\" value=\"" + b.getBuildingId() + "\"><input type=\"hidden\" name=\"action\" value=\"delete\"><input type=\"image\" src=\"images/delete.png\" title=\"Delete building\"></form></td>");
                        out.print("</tr>");
                    }
                } else {
                    out.print("<tr><td colspan=\"6\">You haven't added any buildings yet. Click on the button below to add one.</td></tr>");
                }
            %>
        </table>
        <br>
        <div class="button">
            <a href="addbuilding.jsp">Add a new building</a>
        </div>
    </body>
</html>
