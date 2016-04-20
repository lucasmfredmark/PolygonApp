<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    /* KILL SESSION ON LOGOUT */
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
%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="../css/resets.css" rel="stylesheet" type="text/css">
        <link href="../css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Admin - Dashboard</title>
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
                <h2>Admin dashboard</h2>
                <ul>
                    <li class="active"><a href="index.jsp">Dashboard</a></li>
                    <li class="inactive"><a href="users.jsp">Users</a></li>
                    <li class="inactive"><a href="customerbuildings.jsp">Buildings</a></li>
                    <li class="inactive"><a href="pending.jsp">Checkups</a></li>
                    <li class="inactive"><a href="support.jsp">Support tickets</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><span>Dashboard</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                
                <div class="box dashboard_welcome">
                    <h1>Welcome to the admin panel</h1>
                    <p>From here you can lorem ipsum dolor sit amet.</p>
                </div>
                
                <div class="dashboard_boxes">
                    <a href="users.jsp">
                        <div class="mr20">
                            <img src="../images/users_icon.svg">
                            <h1 class="center">Users</h1>
                            <p class="center">Click here to see a list of all registered users and their buildings.</p>
                        </div>
                    </a>
                    <a href="customerbuildings.jsp">
                        <div class="mr20">
                            <img src="../images/building_icon.svg">
                            <h1 class="center">Buildings</h1>
                            <p class="center">Click here to see a list of all the buildings registered in the system.</p>
                        </div>
                    </a>
                    <a href="pending.jsp">
                        <div>
                            <img src="../images/checkup_icon.svg">
                            <h1 class="center">Pending checkups</h1>
                            <p class="center">Click here to see buildings with an active checkup request.</p>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>     
    </body>
</html>