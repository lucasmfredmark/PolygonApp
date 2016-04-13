<%-- 
    Document   : uploadreport
    Created on : 13-Apr-2016, 12:09:50
    Author     : Staal
--%>

<%@page import="serviceLayer.entities.Order"%>
<%@page import="serviceLayer.entities.Checkup"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.Document"%>
<%@page import="serviceLayer.entities.Document"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon upload report</title>
    </head>
    <body>

        <h3>Check Up Reports</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Upload date</th>
                <th>Check up note</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                User user = (User) session.getAttribute("user");
                String buildingId = request.getParameter("buildingId");
                String customerId = request.getParameter("userId");

                if (user == null) {
                    response.sendRedirect("index.jsp");
                    return;
                } else if (buildingId == null) {
                    response.sendRedirect("building.jsp");
                    return;
                } else if (customerId == null) {
                    response.sendRedirect("building.jsp");
                }

                BuildingController bc = new BuildingController();
                int conditionLevel = bc.getBuildingConditionLevel(Integer.parseInt(buildingId));
                Order order = bc.getOrderByBuildingId(Integer.parseInt(buildingId));
                int orderId = order.getOrderId();

                ArrayList<Checkup> checkups = bc.getBuildingCheckups(Integer.parseInt(buildingId));

                if (checkups.size() > 0) {
                    for (Checkup c : checkups) {
                        out.print("<tr onclick=\"document.location = 'uploads/reports/" + c.getCheckupPath() + "';\">");
                        out.print("<td>" + c.getCheckupDate() + "</td>");
                        out.print("<td>" + c.getCheckupPath() + "</td>");
                        out.print("<td>kek</td>");
                        out.print("<td>" + c.getConditionLevel() + "</td>");
                        out.print("<td><a href=\"uploads/reports/" + c.getCheckupPath() + "\">View</a></td>");
                        out.print("</tr>");
                    }
                } else {
                    out.print("<tr><td colspan=\"5\">There are no check-up reports available for this building yet.</td></tr>");
                }

            %>

        </table>
        <form method="POST" enctype="multipart/form-data" action="UploadServlet">
            <input type="hidden" name="directory" value="upload-report">
            Choose file to upload:<br><br>
            <input type="file" name="file"><br><br>
            <input type="hidden" name="action" value="upload-report">
            <input type="hidden" name="buildingId" value="<%= buildingId%>">
            <input type="hidden" name="orderId" value="<%= orderId%>">
            <input type="hidden" name="conditionLevel" value="<%= conditionLevel%>">
            <input type="submit" value="Upload Report.pdf">
        </form>
    </body>
</html>
