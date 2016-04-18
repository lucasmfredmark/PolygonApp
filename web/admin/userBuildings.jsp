<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SESSION CHECK
    User user = (User) session.getAttribute("user");
    
    if(request.getParameter("logout") != null) {

        if (request.getSession(false) != null) {
            session.invalidate();
        } 

        response.sendRedirect("../index.jsp");
        return;
    }
    
    if (request.getParameter("userId") == null) {
        response.sendRedirect("users.jsp");
    }
    
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    } else if (user.getUserType().equals(User.userType.CUSTOMER)) {
        response.sendRedirect("../buildings.jsp");
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
        <title>Polygon - Admin - User's buildings</title>
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
                <h2>Viewing buildings from user ID : <%= request.getParameter("userId") %></h2>
                <ul>
                    <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                    <li class="inactive"><a href="users.jsp">Users</a></li>
                    <li class="inactive"><a href="customerbuildings.jsp">Buildings</a></li>
                    <li class="inactive"><a href="pending.jsp">Checkups</a></li>
                    <li class="active"><a href="userBuilding.jsp?userId=<%= request.getParameter("userId") %>">User's buildings</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="index.jsp">Dashboard</a> &raquo; <a href="users.jsp">Users</a> &raquo; <span>User's buildings</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                <div class="table">
                    <table class="userbuildings_table">
                        <!-- TABLE HEADER -->
                        <tr>
                            <td>Building id</td>
                            <td>Address</td>
                            <td>Parcel number</td>
                            <td>Size(m&sup2)</td>
                            <td>Creation date</td>
                        </tr>
                        <%
                            AdminController ac = new AdminController();
                            int userId = Integer.parseInt(request.getParameter("userId"));
                            ArrayList<Building> buildings = ac.getCustomerBuildings(userId);
                            if (buildings.size() > 0) {
                                for (Building b : buildings) {
                                    out.print("<tr onclick=\"document.location='building.jsp?buildingId=" + b.getBuildingId()+ "&userId="+userId+"'\">");
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
    </div>
    </body>
</html>