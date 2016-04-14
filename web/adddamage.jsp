<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.User"%>
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
        <title>Polygon - Report damage</title>
    </head>
    <body>
    <div id="site">
        <div id="header">
            <div class="wrapper">
                <img src="images/polygon-logo.svg" class="header_logo" alt="Polygon">
                <p class="signout">Hello, John Doe (<a href="#Signout">Sign out</a>)</p>
            </div>
        </div>
        <div id="navigation">
            <div class="wrapper">
                <h2>Reporting damage to building: <%= building.getBuildingName() %></h2>
                <ul>
                    <li class="inactive"><a href="buildings.jsp">Your buildings</a></li>
                    <li class="inactive"><a href="viewbuilding.jsp?buildingId=<%= request.getParameter("buildingId") %>">Building</a></li>
                    <li class="inactive"><a href="editbuilding.jsp?buildingId=<%= request.getParameter("buildingId") %>">Edit building</a></li>
                    <li class="active"><a href="adddamage.jsp?buildingId=<%= request.getParameter("buildingId") %>">Report damage</a></li>
                    <li class="inactive"><a href="adddocument.jsp?buildingId=<%= request.getParameter("buildingId") %>">Add document</a></li>
                    <li class="inactive"><a href="#">Services</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="buildings.jsp">Your buildings</a> &raquo; <a href="viewbuilding.jsp?buildingId=<%= request.getParameter("buildingId") %>">Building</a> &raquo; <span>Report damage</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                <form class="building" method="POST" action="BuildingServlet">
                    <input type="text" name="dmgtitle" placeholder="Damage" maxlength="50" required autofocus>
                    <textarea rows="6" maxlength="500" name="dmgdesc" placeholder="Describe the damage" required></textarea>
                    <input type="hidden" name="buildingId" value="<%= buildingId %>">
                    <input type="hidden" name="action" value="adddmg">
                    <input type="submit" value="Report damage">
                </form>
            </div>
        </div>
    </div>
    </body>
</html>
