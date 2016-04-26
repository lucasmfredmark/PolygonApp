<%@page import="serviceLayer.entities.*"%>
<%@page import="serviceLayer.exceptions.*"%>
<%@page import="serviceLayer.controllers.*"%>
<%@page import="java.util.*"%>
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
    } else if (user.getUserType().equals(User.userType.CUSTOMER)) {
        response.sendRedirect("/PolygonApp/buildings.jsp");
        return;
    }
    
    // PARAMETER CHECK
    int buildingId;
    
    try {
        buildingId = Integer.parseInt(request.getParameter("buildingId"));
        
        if (buildingId <= 0) {
            response.sendRedirect("/PolygonApp/admin/buildings.jsp");
            return;
        }
    } catch (NumberFormatException ex) {
        response.sendRedirect("/PolygonApp/admin/buildings.jsp");
        return;
    }    

    AdminController ac = new AdminController();
    Building b = ac.getAdminBuilding(buildingId);
   
    if (b == null) {
        response.sendRedirect("/PolygonApp/admin/buildings.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <script src="../js/jquery-1.12.3.min.js"></script>
        <script src="../js/main.js"></script>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Building information</title>
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
                    <h2>Viewing building with id: <%= buildingId %></h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/admin/index.jsp">Dashboard</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/users.jsp">Users</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/buildings.jsp">Buildings</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/pending.jsp">Checkups</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/support.jsp">Support tickets</a></li>
                    </ul>
                </div>
            </div>
        </div>
                    
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="/PolygonApp/admin/index.jsp">Admin panel</a> &raquo; <a href="/PolygonApp/admin/buildings.jsp">Buildings</a> &raquo; Building information</p>
                
                <%
                    BuildingController bc = new BuildingController();
                %>
                <div class="left_column">
                    <div class="box">
                        <!-- FEEDBACK -->
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
                        <form method="POST" action="/PolygonApp/Admin/editbuilding.jsp?buildingId=<%= buildingId %>">
                            <input type="submit" class="btn" value="Edit building">
                        </form>
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
                                     out.print("<td colspan='3'>No records of damage found.</td>");
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
                                        String repconlvl;
                                        switch(c.getConditionLevel()) {
                                            case(0):
                                                repconlvl = "0 - Good condition";
                                                break;
                                            case(1):
                                                repconlvl = "1 - Decent condition";
                                                break;
                                            case(2):
                                                repconlvl = "2 - Bad condition";
                                                break;
                                            case(3):
                                                repconlvl = "3 - Critical condition";
                                                break;
                                            default:
                                                repconlvl = "Not available";
                                                break;
                                        }
                                        out.print("<tr>");
                                            out.print("<td>" + c.getCheckupDate().substring(0, 10) + "</td>");
                                            out.print("<td>" + repconlvl + "</td>");
                                            out.print("<td><a href='/PolygonApp/uploads/reports/" + c.getCheckupPath() + "' download>" + c.getCheckupPath() + "</a></td>");
                                        out.print("</tr>");
                                    }
                                } else {
                                    out.print("<td colspan='3'>No checkup reports found.</td>");
                                }
                            %>
                        </table>
                        <form method="POST" action="/PolygonApp/admin/uploadreport.jsp?buildingId=<%= buildingId %>">
                            <input type="submit" class="btn" value="Upload report">
                        </form>
                    </div>
                    <div class="box">
                        <table class="viewtable viewdocs">
                            <tr>
                                <td colspan="3">Relevant files</td>
                            </tr>
                            <% 
                                ArrayList<Document> documents = bc.getBuildingDocuments(buildingId);

                                if (documents.size() > 0) {
                                    for (Document d : documents) {
                                        out.print("<tr>");
                                            out.print("<td>" + d.getDocumentDate().substring(0, 10) + "</td>");
                                            out.print("<td><a href='uploads/documents/" + d.getDocumentPath() + "' download>" + d.getDocumentPath() + "</a></td>");
                                            out.print("<td>" + d.getDocumentNote() + "</td>");
                                        out.print("</tr>");
                                    }
                                } else {
                                     out.print("<td colspan='3'>No documents found.</td>");
                                }
                            %>
                        </table>
                        <form method="POST" action="/PolygonApp/admin/uploadfile.jsp?buildingId=<%= buildingId %>">
                            <input type="submit" class="btn" value="Upload files">
                        </form>
                    </div>
                </div>
            </div>
        </div> 
    </body>
</html>