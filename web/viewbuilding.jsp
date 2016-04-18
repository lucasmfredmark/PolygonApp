<%@page import="serviceLayer.entities.Damage"%>
<%@page import="serviceLayer.entities.Document"%>
<%@page import="serviceLayer.entities.Checkup"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    
    if(request.getParameter("logout") != null) {

        if (request.getSession(false) != null) {
            session.invalidate();
        } 

        response.sendRedirect("index.jsp");
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
        <title>Polygon - View building</title>
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
                <h2>Viewing building: <%= building.getBuildingName() %></h2>
                <ul>
                    <li class="inactive"><a href="buildings.jsp">Your buildings</a></li>
                    <li class="active"><a href="viewbuilding.jsp?buildingId=<%= buildingId %>">Building</a></li>
                    <li class="inactive"><a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a></li>
                    <li class="inactive"><a href="adddamage.jsp?buildingId=<%= buildingId %>">Report damage</a></li>
                    <li class="inactive"><a href="adddocument.jsp?buildingId=<%= buildingId %>">Add document</a></li>
                    <li class="inactive"><a href="#">Services</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="buildings.jsp">Your buildings</a> &raquo; <span>Building</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                <div class="box">
                    <h1>Building information</h1>
                    <table class="viewinfo">
                        <tr>
                            <td>Building name</td>
                            <td><%= building.getBuildingName() %></td>
                        </tr>
                        <tr>
                            <td>Address</td>
                            <td><%= building.getBuildingAddress() %></td>
                        </tr>
                        <tr>
                            <td>Parcel number</td>
                            <td><%= building.getBuildingParcelNumber() %></td>
                        </tr>
                        <tr>
                            <td>Size in m&sup2;</td>
                            <td><%= building.getBuildingSize() %></td>
                        </tr>
                        <tr> <!-- Mangler fortolkning af tal -->
                            <td>Latest condition</td>
                            <td><%= buildingController.getBuildingConditionLevel(Integer.parseInt(buildingId)) %></td>
                        </tr>
                    </table>
                </div>
                        
                <div class="box">
                    <h1>Checkup reports</h1>
                    <%
                        ArrayList<Checkup> checkups = buildingController.getBuildingCheckups(Integer.parseInt(buildingId));

                        if (checkups.size() > 0) {
                            out.print("<table class='viewdocs'>");
                            for (Checkup c : checkups) {
                                out.print("<tr>");
                                    out.print("<td>" + c.getCheckupDate().substring(0, 10) + "</td>");
                                    out.print("<td>" + c.getConditionLevel()+ "</td>");
                                    out.print("<td><a href='uploads/reports/'>" + c.getCheckupPath()+ "</a></td>");
                                out.print("</tr>");
                            }
                            out.print("</table>");
                            out.print("<p>Click on a report to view its details.</p>");
                        } else {
                            out.print("<br><p>There are no check-up reports available for this building yet.</p>"
                                    + "<br><p>Click <a href='#'>here</a> to request a checkup.</p>");
                        }  
                    %>
                </div>
                <div class="box">
                    <h1>Reported damages</h1>
                    <% 
                        ArrayList<Damage> damage = buildingController.getDamages(Integer.parseInt(buildingId));

                        if (damage.size() > 0) {
                            out.print("<table class='viewdocs'>");
                            for (Damage d : damage) {
                                out.print("<tr>");
                                    out.print("<td>" + d.getDmgDate().substring(0, 10) + "</td>");
                                    out.print("<td>" + d.getDmgTitle() + "</td>");
                                    out.print("<td>" + d.getDmgDesc() + "</td>");
                                out.print("</tr>");
                            }
                            out.print("</table>");
                            out.print("<p>Click on a damage to view its details.</p>");
                        } else { 
                             out.print("<br><p>There are no damages reported to this building.</p>"
                                     + "<br><p>Click <a href='adddamage.jsp?buildingId=" + buildingId +"'>here</a> to add one.</p>");
                        }
                    %>
                </div>
                <div class="box">
                    <h1>Relevant documents</h1>
                    <%
                        ArrayList<Document> documents = buildingController.getBuildingDocuments(Integer.parseInt(buildingId));

                        if (documents.size() > 0) {
                            out.print("<table class='viewdocs'>");
                            for (Document d : documents) {
                                out.print("<tr>");
                                    out.print("<td>" + d.getDocumentDate().substring(0, 10) + "</td>");
                                    out.print("<td>" + d.getDocumentPath() + "</td>");
                                    out.print("<td>" + d.getDocumentNote() + "</td>");
                                out.print("</tr>");
                            }
                            out.print("</table>");
                            out.print("<p>Click on a document to view its details.</p>");
                        } else {
                            out.print("<br><p>There are no documents attached to this building yet.</p>"
                                     + "<br><p>Click <a href='adddocument.jsp?buildingId=" + buildingId +"'>here</a> to add one.</p>");
                        }
                    %>
                </div>
            </div>
        </div>
    </div>        
    </body>
</html>