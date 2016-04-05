<%@page import="serviceLayer.entities.Checkup"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/resets.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Polygon - View building</title>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            String buildingId = request.getParameter("buildingId");

            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            } else if (buildingId == null) {
                response.sendRedirect("buildings.jsp");
                return;
            }

            BuildingController buildingController = new BuildingController();
            Building building = buildingController.getCustomerBuilding(Integer.parseInt(buildingId), user.getId());

            if (building == null) {
                response.sendRedirect("buildings.jsp");
                return;
            }
        %>
        <h1 class="center" style="margin-top: 20px;">Viewing building "<%= building.getName()%>"</h1>
        <div style="width: 600px; margin: 20px auto; padding: 10px; background: #fafafa; border: 1px solid #333;">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 40%;"><h3 style="font-weight: bold; text-align: left;">Building name:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getName()%></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Address:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getAddress()%></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Parcel number:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getParcelNumber()%></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Size in m&sup2;:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getSize()%></h3></td>
                </tr>
            </table>
        </div>
        <div class="button">
            <a href="editbuilding.jsp?buildingId=<%= buildingId%>">Edit building</a>
        </div>
        <div class="button">
            <a href="buildings.jsp"><- Back to overview</a>
        </div>
        <br><hr><br>
        <h3>Check-up reports</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Check-up date</th>
                <th>Report name</th>
                <th style="width: 150px;">Order date</th>
                <th style="width: 150px;">Condition level</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                ArrayList<Checkup> checkups = buildingController.getCheckupReports(Integer.parseInt(buildingId));

                if (checkups.size() > 0) {
                    for (Checkup c : checkups) {
                        out.print("<tr onclick=\"document.location = 'uploads/reports/" + c.getCheckupPath() + "';\">");
                        out.print("<td>" + c.getCheckupDate() + "</td>");
                        out.print("<td>" + c.getCheckupPath() + "</td>");
                        out.print("<td>" + c.getOrderDate() + "</td>");
                        out.print("<td>" + c.getConditionLevel() + "</td>");
                        out.print("<td><a href=\"uploads/reports/" + c.getCheckupPath() + "\">View</a></td>");
                        out.print("</tr>");
                    }
                } else {
                    out.print("<tr><td colspan=\"5\">There are no check-up reports available for this building yet.</td></tr>");
                }
            %>
        </table>

        <h3>Other documents</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Date uploaded</th>
                <th>Document name</th>
                <th style="width: 150px;">Document note</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                if (checkups.size() > 0) {
                    for (Checkup c : checkups) {
                        out.print("<tr onclick=\"document.location = 'uploads/reports/" + c.getCheckupPath() + "';\">");
                        out.print("<td>" + c.getCheckupDate() + "</td>");
                        out.print("<td>" + c.getCheckupPath() + "</td>");
                        out.print("<td>" + c.getOrderDate() + "</td>");
                        out.print("<td>" + c.getConditionLevel() + "</td>");
                        out.print("<td><a href=\"uploads/reports/" + c.getCheckupPath() + "\">View</a></td>");
                        out.print("</tr>");
                    }
                } else {
                    out.print("<tr><td colspan=\"5\">There are no documents available for this building yet.</td></tr>");
                }
            %>
        </table>

        <form method="POST" enctype="multipart/form-data" action="fup.cgi">
            Choose file to upload: <input type="file" name="upfile"><br/><br>
            Notes about the file: <input type="text" name="note">
            <input type="submit" value="Upload">
        </form>

    </body>
</html>
