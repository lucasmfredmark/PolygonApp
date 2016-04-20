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
%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Your buildings</title>
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
                    <h2>Overview of your buildings</h2>
                    <ul>
                        <li class="active"><a href="/PolygonApp/buildings.jsp">Your buildings</a></li>
                        <li class="inactive"><a href="/PolygonApp/addbuilding.jsp">Add building</a></li>
                        <li class='inactive'><a href="/PolygonApp/support.jsp">Support</a></li>
                    </ul>
                </div>
            </div>
        </div>
            
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs">Your buildings</p>

                <div class="table">
                    <table class="buildings_table">
                        <!-- FEEDBACK MESSAGES -->
                        <%
                            if (request.getParameter("error") != null) {
                                out.print("<h3 class='errormsg'>" + request.getParameter("error") + "</h3><br>");
                            } else if (request.getParameter("success") != null) {
                                out.print("<h3 class='errormsg'>" + request.getParameter("success") + "</h3><br>");
                            }
                        %>
                        <!-- TABLE HEADER -->
                        <tr>
                            <td>Building name</td>
                            <td>Address</td>
                            <td>Parcel number</td>
                            <td>Size(m&sup2)</td>
                            <td>Condition level</td>
                        </tr>
                        <%
                            BuildingController bc = new BuildingController();
                            ArrayList<Building> buildings = bc.getCustomerBuildings(user.getUserId());
                            
                            if (buildings.size() > 0) {
                                String conlvl;
                                for (Building b : buildings) {
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
                                    
                                    out.print("<tr onclick=\"document.location='/PolygonApp/viewbuilding.jsp?buildingId=" + b.getBuildingId() + "'\">");
                                        out.print("<td>" + b.getBuildingName() + "</td>");
                                        out.print("<td>" + b.getBuildingAddress()+ "</td>");
                                        out.print("<td>" + b.getBuildingParcelNumber()+ "</td>");
                                        out.print("<td>" + b.getBuildingSize()+ "</td>");
                                        out.print("<td>" + conlvl + "</td>");
                                    out.print("</tr>");
                                }
                            } else { // If there are currently no buildings linked to this user.
                                out.print("<tr class='nohover'>");
                                    out.print("<td colspan='5'>You have no buildings added to your account.</td>");
                                out.print("</tr>");
                                out.print("<tr class='nohover'>");
                                    out.print("<td colspan='5'>Click <a href='/PolygonApp/addbuilding.jsp'>here</a> to add one.</td>");
                                out.print("</tr>");
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
