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
    
    // PARAMETER CHECK MANGLER EXCEPTION
    if (request.getParameter("userId") == null) {
        response.sendRedirect("users.jsp");
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
        <title>Polygon - Admin - Users buildings</title>
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
                    <h2>Viewing buildings from user ID : <%= request.getParameter("userId") %></h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/admin/index.jsp">Dashboard</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/users.jsp">Users</a></li>
                        <li class="active"><a href="/PolygonApp/admin/userBuilding.jsp?userId=<%= request.getParameter("userId") %>">User's buildings</a></li>
                    </ul>
                </div>
            </div>
        </div>

        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="/PolygonApp/admin/index.jsp">Dashboard</a> &raquo; <a href="/PolygonApp/admin/users.jsp">Users</a> &raquo; User's buildings</p>

                <div class="table">
                    <%
                        if (request.getParameter("error") != null) {
                            out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                        } else if (request.getParameter("success") != null) {
                            out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                        }
                    %>
                    <input type="text" class="searchfield" placeholder="Search keyword" id="searchBuilding">
                    <table class="userbuildings_table" id="buildingsTable">
                        <!-- TABLE HEADER -->
                        <tr>
                            <td>Building id</td>
                            <td>Address</td>
                            <td>Parcel number</td>
                            <td>Size(m&sup2)</td>
                            <td>Creation date</td>
                        </tr>
                        <tr class="hidden">
                            <td colspan="5">No search results for "<span></span>".</td>
                        </tr>
                        <%
                            AdminController ac = new AdminController();
                            int userId = Integer.parseInt(request.getParameter("userId"));
                            ArrayList<Building> buildings = ac.getCustomerBuildings(userId);
                            if (buildings.size() > 0) {
                                for (Building b : buildings) {
                                    out.print("<tr onclick=\"document.location='building.jsp?buildingId=" + b.getBuildingId()+ "'\">");
                                        out.print("<td>" + b.getBuildingId()+ "</td>");
                                        out.print("<td>" + b.getBuildingAddress()+ "</td>");
                                        out.print("<td>" + b.getBuildingParcelNumber()+ "</td>");
                                        out.print("<td>" + b.getBuildingSize() + "</td>");
                                        out.print("<td>" + b.getBuildingDate().substring(0,10) + "</td>");
                                    out.print("</tr>");
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>