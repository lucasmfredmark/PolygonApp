<%-- 
    Document   : users
    Created on : 14-04-2016, 09:53:40
    Author     : HazemSaeid
--%>

<%@page import="serviceLayer.entities.User.userType"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.controllers.UserController"%>
<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All customer buildings</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            User user = (User) session.getAttribute("user");
        %>
        <h3>Hello, <span><%= user.getFullName()%></span> (<%= user.getUserType()%>)</h3>
        <h3><%= user.getUserMail()%></h3>
        <form action="/PolygonApp/UserServlet" method="POST" style="padding: 0;">
            <input type="hidden" name="action" value="logout">
            <input type="submit" value="Log out">
        </form>
        <br><hr><br>
        <h1 class="center">Overview</h1>
        <%
            if (request.getParameter("error") != null) {
                out.print("<br /><h2 class=\"error-msg\">" + request.getParameter("error") + "</h2>");
            } else if (request.getParameter("success") != null) {
                out.print("<br /><h2 class=\"success-msg\">" + request.getParameter("success") + "</h2>");
            }
        %>
        <br>

            <table class="btable">
                    <!-- TABLE HEADER -->
                    <tr>
                        <td>Building id</td>
                        <td>Building name</td>
                        <td>Address</td>
                        <td>Parcel number</td>
                        <td>Size(m&sup2)</td>
                        <td>Belongs to user with id</td>
                    </tr>
                    <%
                        AdminController ac = new AdminController();
                        ArrayList<Building> allBuildings = ac.getAllBuildings();
                        for (Building b : allBuildings) {
                    %>
                    <!-- Pass userId parameter (done) but also userName parameter in one line below: (not done)   -->
                    <tr onclick="document.location='userBuildings.jsp?userId=<%= u.getUserId() %>';">
                        <td><%= b.getBuildingId()%></td>
                        <td><%= b.getBuildingName() %></td>
                        <td><%= b.getBuildingAddress() %></td>
                        <td><%= b.getBuildingParcelNumber() %></td>
                        <td><%= b.getBuildingSize() %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
    </body>
</html>
