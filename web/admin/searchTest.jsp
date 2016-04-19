<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.UserController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Search test</title>
    </head>
    <body>
        <h1>Search test</h1>
        <hr>
        <h2>Search users</h2>
        <input type="text" id="searchUser">
        <table id="usersTable">
            <tr>
                <th>User ID</th>
                <th>Full name</th>
                <th>E-mail address</th>
                <th>Register date</th>
            </tr>
            <tr style="display: none;">
                <td colspan="4">Your search on "<span></span>" gave no results.</td>
            </tr>
            <%
                AdminController ac = new AdminController();
                ArrayList<User> users = ac.getAllUsers("CUSTOMER");
                
                // check arraylist size, if 0 no users
                for (User user : users) {
                    out.print("<tr>");
                    out.print("<td>" + user.getUserId() + "</td>");
                    out.print("<td>" + user.getFullName() + "</td>");
                    out.print("<td>" + user.getUserMail() + "</td>");
                    out.print("<td>" + user.getUserDate() + "</td>");
                    out.print("</tr>");
                }
            %>
        </table>
        <br><hr><br>
        <h2>Search buildings</h2>
        <input type="text" id="searchBuilding">
        <table id="buildingsTable">
            <tr>
                <th>Building ID</th>
                <th>Address</th>
                <th>Parcel number</th>
                <th>Size(m&sup2;)</th>
                <th>Creation date</th>
            </tr>
            <tr style="display: none;">
                <td colspan="5">Your search on "<span></span>" gave no results.</td>
            </tr>
            <%
                ArrayList<Building> buildings = ac.getAllBuildings();
                
                // check arraylist size, if 0 no buildings
                for (Building building : buildings) {
                    out.print("<tr>");
                    out.print("<td>" + building.getBuildingId() + "</td>");
                    out.print("<td>" + building.getBuildingAddress() + "</td>");
                    out.print("<td>" + building.getBuildingParcelNumber() + "</td>");
                    out.print("<td>" + building.getBuildingSize() + "</td>");
                    out.print("<td>" + building.getBuildingDate() + "</td>");
                    out.print("</tr>");
                }
            %>
        </table>
        <br><hr><br>
        <h2>Search reports</h2>
        <input type="text" id="searchReports">
        <table id="reportsTable">
            <tr>
                <th>?</th>
                <th>?</th>
                <th>?</th>
                <th>?</th>
                <th>?</th>
            </tr>
            <tr style="display: none;">
                <td colspan="5">Your search on "<span></span>" gave no results.</td>
            </tr>
            <%
                //ArrayList<Building> buildings = ac.getAllBuildings();
                
                // check arraylist size, if 0 no buildings
                /*
                for (Building building : buildings) {
                    out.print("<tr>");
                    out.print("<td>" + building.getBuildingId() + "</td>");
                    out.print("<td>" + building.getBuildingAddress() + "</td>");
                    out.print("<td>" + building.getBuildingParcelNumber() + "</td>");
                    out.print("<td>" + building.getBuildingSize() + "</td>");
                    out.print("<td>" + building.getBuildingDate() + "</td>");
                    out.print("</tr>");
                }
                */
            %>
        </table>
        <script src="../js/jquery-1.12.3.min.js"></script>
        <script src="../js/main.js"></script>
    </body>
</html>
