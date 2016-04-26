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
        <script src="../js/jquery-1.12.3.min.js"></script>
        <script src="../js/main.js"></script>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Users</title>
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
                    <h2>Users overview</h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/admin/index.jsp">Dashboard</a></li>
                        <li class="active"><a href="/PolygonApp/admin/users.jsp">Users</a></li>
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
                <p class="breadcrumbs"><a href="/PolygonApp/admin/index.jsp">Admin panel</a> &raquo; Users</p>
                
                <div class="table">
                    <%
                        if (request.getParameter("error") != null) {
                            out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                        } else if (request.getParameter("success") != null) {
                            out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                        }
                    %>
                    <input type="text" class="searchfield right" placeholder="Search keyword" id="searchUser">
                    <table class="users_table" id="usersTable">
                        <!-- TABLE HEADER -->
                        <tr>
                            <td>User ID</td>
                            <td>E-mail</td>
                            <td>Full name</td>
                            <td>Number of buildings</td>
                            <td>Creation date</td>
                        </tr>
                        <tr class="hidden">
                            <td colspan="5">No search results for "<span></span>".</td>
                        </tr>
                        <%
                            UserController uc = new UserController();
                            BuildingController bc = new BuildingController();
                            ArrayList<User> users = uc.getAllUsers("CUSTOMER");
                            for (User u : users) {
                                out.print("<tr onclick=\"document.location='usersbuildings.jsp?userId=" + u.getUserId() + "'\">");
                                    out.print("<td>" + u.getUserId() + "</td>");
                                    out.print("<td>" + u.getUserMail() + "</td>");
                                    out.print("<td>" + u.getFullName() + "</td>");
                                    out.print("<td>" + bc.getCustomerBuildings(u.getUserId()).size() + "</td>");
                                    out.print("<td>" + u.getUserDate().substring(0,10) + "</td>");
                                out.print("</tr>");
                            }
                        %>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
