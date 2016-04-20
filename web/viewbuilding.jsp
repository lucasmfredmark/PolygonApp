<%@page import="serviceLayer.entities.*"%>
<%@page import="serviceLayer.exceptions.*"%>
<%@page import="serviceLayer.controllers.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SIGN OUT
    if(request.getParameter("logout") != null) {
        if (request.getSession(false) != null) {
            session.invalidate();
        }
        response.sendRedirect("/PolygonApp/index.jsp");
        return;
    }

    // SESSION CHECK
    User user = (User) session.getAttribute("user");
    
    if (user == null) {
        response.sendRedirect("/PolygonApp/index.jsp");
        return;
    } else if (user.getUserType().equals(User.userType.ADMIN)) {
        response.sendRedirect("/PolygonApp/admin/index.jsp");
        return;
    }
   
    // PARAMETER CHECK
    try {
        int buildingId = Integer.parseInt(request.getParameter("buildingId"));
        
        if (buildingId <= 0) {
            response.sendRedirect("/PolygonApp/buildings.jsp");
            return;
        }
    } catch (NumberFormatException ex) {
        response.sendRedirect("/PolygonApp/buildings.jsp");
        return;
    }
    
    int buildingId = Integer.parseInt(request.getParameter("buildingId"));
    
    // OWNER CHECK
    BuildingController bc = new BuildingController();
    Building b = bc.getCustomerBuilding(buildingId, user.getUserId());
   
    if (b == null) {
        response.sendRedirect("/PolygonApp/buildings.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Building</title>
    </head>
    <body>
        <div id="top">
            <div id="header">
                <div class="wrapper">
                    <img src="/PolygonApp/images/polygon-logo.svg" class="header_logo" alt="Polygon">
                    <p>Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
                </div>
            </div>
            <div id="navigation">
                <div class="wrapper">
                    <h2>Viewing building: <%= b.getBuildingName() %></h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/buildings.jsp">Your buildings</a></li>
                        <li class="active"><a href="/PolygonApp/viewbuilding.jsp?buildingId=<%= buildingId %>">Building</a></li>
                        <li class="inactive"><a href="/PolygonApp/editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a></li>
                        <li class="inactive"><a href="/PolygonApp/adddamage.jsp?buildingId=<%= buildingId %>">Report damage</a></li>
                        <li class="inactive"><a href="/PolygonApp/uploadfiles.jsp?buildingId=<%= buildingId %>">Upload files</a></li>
                        <li class='inactive'><a href="/PolygonApp/support.jsp">Support</a></li>
                    </ul>
                </div>
            </div>
        </div>
  
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="/PolygonApp/buildings.jsp">Your buildings</a> &raquo; Building</p>
                
                <div class="left_column">
                    <div class="box">
                        <%
                            if (request.getParameter("error") != null) {
                                out.print("<h3 class='errormsg'>" + request.getParameter("error") + "</h3><br>");
                            } else if (request.getParameter("success") != null) {
                                out.print("<h3 class='errormsg'>" + request.getParameter("success") + "</h3><br>");
                            }
                        %>
                        <table class="viewtable viewinfo">
                            <tr>
                                <td colspan="2">Building information</td>
                            </tr>
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
                            <%
                                String conlvl;
                                    switch(bc.getBuildingConditionLevel(b.getBuildingId())) {
                                        case(0):
                                            conlvl = "0 - Good condition";
                                            break;
                                        case(1):
                                            conlvl = "1 - Decent condition";
                                            break;
                                        case(2):
                                            conlvl = "2 - Bad condition";
                                            break;
                                        case(3):
                                            conlvl = "3 - Critical condition";
                                            break;
                                        default:
                                            conlvl = "Not available";
                                            break;
                                    }
                            %>
                            <tr>
                                <td>Latest condition</td>
                                <td><%= conlvl %></td>
                            </tr>
                        </table>
                    </div>
                    <div class="box">
                        <table class="viewtable viewdmgs">
                            <tr>
                                <td colspan="3">Reported damages</td>
                            </tr>
                            <% 
                                ArrayList<Damage> damage = bc.getDamages(buildingId);

                                if (damage.size() > 0) {
                                    for (Damage d : damage) {
                                        out.print("<tr>");
                                            out.print("<td>" + d.getDmgDate().substring(0, 10) + "</td>");
                                            out.print("<td>" + d.getDmgTitle() + "</td>");
                                            out.print("<td>" + d.getDmgDesc() + "</td>");
                                        out.print("</tr>");
                                    }
                                } else { 
                                     out.print("<td colspan='3'>No recorded damages found, <a href='adddamage.jsp?buildingId=" + buildingId +"'>click here to add one.</a></td>");
                                }
                            %>
                        </table>
                    </div>
                </div>
                        
                <div class="right_column">
                    <div class="box">
                        <table class="viewtable viewreports">
                            <tr>
                                <td colspan="3">Checkup reports</td>
                            </tr>
                            <% 
                                ArrayList<Checkup> checkups = bc.getBuildingCheckups(buildingId);

                                if (checkups.size() > 0) {
                                    for (Checkup c : checkups) {
                                        out.print("<tr>");
                                            out.print("<td>" + c.getCheckupDate().substring(0, 10) + "</td>");
                                            out.print("<td>" + c.getConditionLevel()+ "</td>");
                                            out.print("<td><a href='uploads/reports/'>" + c.getCheckupPath()+ "</a></td>");
                                        out.print("</tr>");
                                    }
                                } else {
                                     out.print("<td colspan='3'>No checkup reports found, <a href='#'>click here to request a checkup.</a></td>");
                                }
                            %>
                        </table>
                    </div>
                    <div class="box">
                        <table class="viewtable viewdocs">
                            <tr>
                                <td colspan="3">Relevant documents</td>
                            </tr>
                            <% 
                                ArrayList<Document> documents = bc.getBuildingDocuments(buildingId);

                                if (documents.size() > 0) {
                                    for (Document d : documents) {
                                        out.print("<tr>");
                                            out.print("<td>" + d.getDocumentDate().substring(0, 10) + "</td>");
                                            out.print("<td>" + d.getDocumentPath() + "</td>");
                                            out.print("<td>" + d.getDocumentNote() + "</td>");
                                        out.print("</tr>");
                                    }
                                } else {
                                     out.print("<td colspan='3'>No documents found, <a href='uploadfiles.jsp?buildingId=" + buildingId +"'>click to add a document.</a></td>");
                                }
                            %>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>