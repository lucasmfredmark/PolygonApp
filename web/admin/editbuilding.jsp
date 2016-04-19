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
        <title>Polygon - Admin - Edit building</title>
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
                <h2>Editing building with id: <%= buildingId %></h2>
                <ul>
                    <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                    <li class="inactive"><a href="customerbuildings.jsp">Buildings</a></li>
                    <li class="inactive"><a href="building.jsp?buildingId=<%= buildingId %>">Building information</a></li>
                    <li class="active"><a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a></li>
                    <li class="inactive"><a href="uploadfile.jsp?buildingId=<%= buildingId %>">Upload files</a></li>
                    <li class="inactive"><a href="uploadreport.jsp?buildingId=<%= buildingId %>">Upload report</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="index.jsp">Dashboard</a> &raquo; <a href="customerbuildings.jsp">Buildings</a>  &raquo; <span>Edit building</span></p>
                
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                
                <form class="building" method="POST" action="/PolygonApp/AdminServlet">
                    <input type="text" name="bname" placeholder="Name of building" maxlength="40" value="<%= b.getBuildingName() %>" required autofocus>
                    <input type="text" name="address" placeholder="Address" maxlength="50" value="<%= b.getBuildingAddress() %>" required>
                    <input type="text" name="parcel" placeholder="Parcel number" maxlength="20" pattern="[0-9a-z]+" value="<%= b.getBuildingParcelNumber() %>" required>
                    <input type="text" name="size" placeholder="Size in m&sup2" pattern="\d*" value="<%= b.getBuildingSize() %>" required>
                    <input type="hidden" name="buildingId" value="<%= buildingId %>">
                    <input type="hidden" name="action" value="edit">
                    <input type="submit" value="Apply changes to building">
                </form>
                
            </div>
        </div>
    </div>  
    </body>
</html>    