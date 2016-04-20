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
        <title>Polygon - Report damage</title>
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
                    <h2>Reporting damage to building: <%= b.getBuildingName() %></h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/buildings.jsp">Your buildings</a></li>
                        <li class="inactive"><a href="/PolygonApp/viewbuilding.jsp?buildingId=<%= buildingId %>">Building</a></li>
                        <li class="inactive"><a href="/PolygonApp/editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a></li>
                        <li class="active"><a href="/PolygonApp/adddamage.jsp?buildingId=<%= buildingId %>">Report damage</a></li>
                        <li class="inactive"><a href="/PolygonApp/uploadfiles.jsp?buildingId=<%= buildingId %>">Upload files</a></li>
                        <li class='inactive'><a href="/PolygonApp/support.jsp">Support</a></li>
                    </ul>
                </div>
            </div>
        </div>
            
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="/PolygonApp/buildings.jsp">Your buildings</a> &raquo; <a href="/PolygonApp/viewbuilding.jsp?buildingId=<%= buildingId %>">Building</a> &raquo; Report damage</p>
                
                <div class="container">
                    <h1>Report a damage to your building</h1>
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
