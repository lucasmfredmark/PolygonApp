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
%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Admin panel</title>
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
                    <h2>Admin panel</h2>
                    <ul>
                        <li class="active"><a href="/PolygonApp/admin/index.jsp">Dashboard</a></li>
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
                <p class="breadcrumbs">Admin panel</p>
                
                <div class="box dashboard_welcome">
                    <%
                        if (request.getParameter("error") != null) {
                            out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                        } else if (request.getParameter("success") != null) {
                            out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                        }
                    %>
                    <h1>Welcome to the admin panel</h1>
                    <p>From here you can lorem ipsum dolor sit amet.</p>
                </div>
                
                <div class="dashboard_boxes">
                    <a href="/PolygonApp/admin/users.jsp">
                        <div class="mr20">
                            <img src="/PolygonApp/images/users_icon.svg">
                            <h1 class="center">Users</h1>
                            <p class="center">Click here to see a list of all registered users and their buildings.</p>
                        </div>
                    </a>
                    <a href="/PolygonApp/admin/buildings.jsp">
                        <div class="mr20">
                            <img src="/PolygonApp/images/building_icon.svg">
                            <h1 class="center">Buildings</h1>
                            <p class="center">Click here to see a list of all the buildings registered in the system.</p>
                        </div>
                    </a>
                    <a href="/PolygonApp/admin/pending.jsp">
                        <div>
                            <img src="/PolygonApp/images/checkup_icon.svg">
                            <h1 class="center">Pending checkups</h1>
                            <p class="center">Click here to see buildings with an active checkup request.</p>
                        </div>
                    </a>
                </div>
            </div>
        </div> 
    </body>
</html>