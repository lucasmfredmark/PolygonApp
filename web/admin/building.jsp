<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.Checkup"%>
<%@page import="serviceLayer.entities.Damage"%>
<%@page import="serviceLayer.entities.Document"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.controllers.UserController"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    /* DESTROY SESSION ON SIGN OUT */
    if(request.getParameter("logout") != null) {
        if (request.getSession(false) != null) {
            session.invalidate();
        }
        response.sendRedirect("../index.jsp");
        return;
    }
    
    // SESSION CHECK
    User user = (User) session.getAttribute("user");
    
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    } else if (user.getUserType().equals(User.userType.CUSTOMER)) {
        response.sendRedirect("../buildings.jsp");
        return;
    }
    
    // PARAMETER CHECK
    int buildingId = Integer.parseInt(request.getParameter("buildingId"));
    
    if (request.getParameter("buildingId") == null) {
        response.sendRedirect("index.jsp");
    }
    
    AdminController ac = new AdminController();
    Building b = ac.getAdminBuilding(buildingId);
   
    if (b == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="../css/resets.css" rel="stylesheet" type="text/css">
        <link href="../css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Admin - Building information</title>
    </head>
    <body>
    <div id="site">
        <div id="header">
            <div class="wrapper">
                <img src="../images/polygon-logo.svg" class="header_logo" alt="Polygon">
                <p>Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
            </div>
        </div>
        <div id="navigation">
            <div class="wrapper">
                <h2>Viewing building with id: <%= buildingId %></h2>
                <ul>
                    <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                    <li class="inactive"><a href="customerbuildings.jsp">Buildings</a></li>
                    <li class="active"><a href="building.jsp?buildingId=<%= buildingId %>">Building information</a></li>
                    <li class="inactive"><a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a></li>
                    <li class="inactive"><a href="uploadfile.jsp?buildingId=<%= buildingId %>">Upload files</a></li>
                    <li class="inactive"><a href="uploadreport.jsp?buildingId=<%= buildingId %>">Upload report</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="index.jsp">Dashboard</a> &raquo; <a href="customerbuildings.jsp">Buildings</a>  &raquo; <span>Building information</span></p>
                
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                
                <%
                    BuildingController bc = new BuildingController();
                %>
                <div class="left_column">
                    <div class="box viewbuilding">
                        <h1>Building information</h1>
                        <table class="viewinfo">
                            <tr>
                                <td>Building name</td>
                                <td><%= b.getBuildingName() %></td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td><%= b.getBuildingAddress() %></td>
                            </tr>
                            <tr>
                                <td>Parcel number</td>
                                <td><%= b.getBuildingParcelNumber() %></td>
                            </tr>
                            <tr>
                                <td>Size in m&sup2;</td>
                                <td><%= b.getBuildingSize() %></td>
                            </tr>
                            <tr> <!-- Mangler fortolkning af tal -->
                                <td>Latest condition</td>
                                <td><%= bc.getBuildingConditionLevel(buildingId) %></td>
                            </tr>
                        </table>
                    </div>
                    <div class="box viewbuilding">
                        <h1>Reported damages</h1>
                        <% 
                            ArrayList<Damage> damage = bc.getDamages(buildingId);

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
                                 out.print("<br><p>There are no damages reported to this building.</p>");
                            }
                        %>
                    </div>
                </div>
                        
                <div class="right_column">
                    <div class="box viewbuilding">
                        <h1>Checkup reports</h1>
                        <%
                            ArrayList<Checkup> checkups = bc.getBuildingCheckups(buildingId);

                            if (checkups.size() > 0) {
                                out.print("<table class='viewdocs'>");
                                for (Checkup c : checkups) {
                                    out.print("<tr>");
                                        out.print("<td>" + c.getCheckupDate().substring(0, 10) + "</td>");
                                        out.print("<td>" + c.getConditionLevel()+ "</td>");
                                        out.print("<td><a href='#'>" + c.getCheckupPath()+ "</a></td>");
                                    out.print("</tr>");
                                }
                                out.print("</table>");
                                out.print("<p>Click on a report to view its details.</p>");
                            } else {
                                out.print("<br><p>There are no check-up reports available for this building yet.</p>"
                                        + "<br><p>Click <a href='uploadreport.jsp?buildingId=" + buildingId + "'>here</a> to upload a checkup.</p>");
                            }
                        %>
                    </div>
                    <div class="box viewbuilding">
                        <h1>Relevant documents</h1>
                        <%
                            ArrayList<Document> documents = bc.getBuildingDocuments(buildingId);

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
                                         + "<br><p>Click <a href='uploadfile.jsp?buildingId=" + buildingId +"'>here</a> to add one.</p>");
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>  
    </body>
</html>