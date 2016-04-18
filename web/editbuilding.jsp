<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SESSION CHECK
    User user = (User) session.getAttribute("user");
    String buildingId = request.getParameter("buildingId");

    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    } else if (buildingId == null) {
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
        <title>Polygon - Edit building</title>
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
                <h2>Editing building: <%= building.getBuildingName() %></h2>
                <ul>
                    <li class="inactive"><a href="buildings.jsp">Your buildings</a></li>
                    <li class="inactive"><a href="viewbuilding.jsp?buildingId=<%= buildingId %>">Building</a></li>
                    <li class="active"><a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a></li>
                    <li class="inactive"><a href="adddamage.jsp?buildingId=<%= buildingId %>">Report damage</a></li>
                    <li class="inactive"><a href="adddocument.jsp?buildingId=<%= buildingId %>">Add document</a></li>
                    <li class="inactive"><a href="#">Services</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="buildings.jsp">Your buildings</a> &raquo; <a href="viewbuilding.jsp?buildingId=<%= buildingId %>">Building</a> &raquo; <span>Edit building</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                <form class="building" method="POST" action="BuildingServlet">
                    <input type="text" name="bname" placeholder="Name of building" maxlength="40" value="<%= building.getBuildingName() %>" required autofocus>
                    <input type="text" name="address" placeholder="Address" maxlength="50" value="<%= building.getBuildingAddress() %>" required>
                    <input type="text" name="parcel" placeholder="Parcel number" maxlength="20" pattern="[0-9a-z]+" value="<%= building.getBuildingParcelNumber() %>" required>
                    <input type="text" name="size" placeholder="Size in m&sup2" pattern="\d*" value="<%= building.getBuildingSize() %>" required>
                    <input type="hidden" name="buildingId" value="<%= buildingId %>">
                    <input type="hidden" name="action" value="edit">
                    <input type="submit" value="Apply changes to building">
                </form>               
            </div>
        </div>
    </div>     
    </body>
</html>