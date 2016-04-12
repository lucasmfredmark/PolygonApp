<%@page import="serviceLayer.entities.Damage"%>
<%@page import="serviceLayer.entities.Document"%>
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
            
            try {
                int tempId = Integer.parseInt(buildingId);
                
                if (tempId <= 0) {
                    response.sendRedirect("buildings.jsp");
                    return;
                }
                
                buildingId = String.valueOf(tempId);
            } catch (NumberFormatException ex) {
                response.sendRedirect("buildings.jsp");
                return;
            }
            
            BuildingController buildingController = new BuildingController();
            Building building = buildingController.getCustomerBuilding(Integer.parseInt(buildingId), user.getUserId());

            if (building == null) {
                response.sendRedirect("buildings.jsp");
                return;
            }
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
                    <td><h3 style="text-align: left;"><%= buildingController.getBuildingConditionLevel(Integer.parseInt(buildingId)) %></h3></td>
                </tr>
            </table>
        </div>
        <div class="button">
            <a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a>
        </div>
        <div class="button">
            <a href="adddamage.jsp?buildingId=<%= buildingId %>">Report a damage</a>
        </div>
        <form action="BuildingServlet" method="POST" style="padding: 0;">
            <input type="hidden" name="action" value="request-checkup">
            <input type="hidden" name="buildingId" value="<%= buildingId %>">
            <input type="submit" value="Request a check-up">
        </form>
        <div class="button">
            <a href="buildings.jsp"><- Back to overview</a>
        </div>
        <br><hr><br>
        <%
            if (request.getParameter("error") != null) {
                out.print("<h2 class=\"error-msg\">" + request.getParameter("error") + "</h2><br />");
            } else if (request.getParameter("success") != null) {
                out.print("<h2 class=\"success-msg\">" + request.getParameter("success") + "</h2><br />");
            }
        %>
        <h3>Check-up reports</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Check-up date</th>
                <th>Report name</th>
                <th style="width: 200px;">Order date</th>
                <th style="width: 150px;">Condition level</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                ArrayList<Checkup> checkups = buildingController.getBuildingCheckups(Integer.parseInt(buildingId));

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
        <br><br>
        <h3>Damage reports</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Upload date</th>
                <th style="width: 200px;">Damage title</th>
                <th>Damage description</th>
            </tr>
            <% 
                ArrayList<Damage> damage = buildingController.getDamages(Integer.parseInt(buildingId));
                
                if (damage.size() > 0) {
                    for (Damage d : damage) {
                        out.print("<tr>");
                        out.print("<td>" + d.getDmgDate() + "</td>");
                        out.print("<td>" + d.getDmgTitle() + "</td>");
                        out.print("<td>" + d.getDmgDesc() + "</td>");
                        out.print("</tr>");
                    }
                } else { 
                     out.print("<tr><td colspan=\"3\">There are no damages available for this building yet.</td></tr>");
                }
            %>
        </table>
        <br><br>
        <h3>Other documents</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Upload date</th>
                <th>Document note</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                ArrayList<Document> documents = buildingController.getBuildingDocuments(Integer.parseInt(buildingId));
                
                if (documents.size() > 0) {
                    for (Document d : documents) {
                        out.print("<tr onclick=\"document.location = 'uploads/documents/" + d.getDocumentPath() + "';\">");
                        out.print("<td>" + d.getDocumentDate() + "</td>");
                        out.print("<td>" + d.getDocumentNote() + "</td>");
                        out.print("<td><a href=\"uploads/documents/" + d.getDocumentPath() + "\">View</a></td>");
                        out.print("</tr>");
                    }
                } else {
                    out.print("<tr><td colspan=\"3\">There are no documents available for this building yet.</td></tr>");
                }
            %>
        </table>
        <form method="POST" enctype="multipart/form-data" action="UploadServlet">
            <input type="hidden" name="directory" value="upload-document">
            Choose file to upload:<br><br>
            <input type="file" name="file"><br><br>
            Notes about the file: <input type="text" name="note" maxlength="100">
            <input type="hidden" name="action" value="upload-document">
            <input type="hidden" name="buildingId" value="<%= buildingId %>">
            <input type="submit" value="Upload document">
        </form>
    </body>
</html>
