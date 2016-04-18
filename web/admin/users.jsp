<%@page import="serviceLayer.entities.User.userType"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.controllers.UserController"%>
<%@page import="serviceLayer.entities.User"%>
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
        <title>Polygon - Admin - Users</title>
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
                <h2>Viewing all users</h2>
                <ul>
                    <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                    <li class="active"><a href="users.jsp">Users</a></li>
                    <li class="inactive"><a href="customerbuildings.jsp">Buildings</a></li>
                    <li class="inactive"><a href="pending.jsp">Checkups</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="index.jsp">Dashboard</a> &raquo; <span>Users</span></p>
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                
                <div class="table">
                    <table class="users_table">
                        <!-- TABLE HEADER -->
                        <tr>
                            <td>User ID</td>
                            <td>E-mail</td>
                            <td>Full name</td>
                            <td>Number of buildings</td>
                            <td>Creation date</td>
                        </tr>
                        <%
                            UserController uc = new UserController();
                            ArrayList<User> users = uc.getAllUsers("CUSTOMER");
                            for (User u : users) {
                                out.print("<tr onclick=\"document.location='userBuildings.jsp?userId=" + u.getUserId() + "'\">");
                                    out.print("<td>" + u.getUserId() + "</td>");
                                    out.print("<td>" + u.getUserMail() + "</td>");
                                    out.print("<td>" + u.getFullName() + "</td>");
                                    out.print("<td>14</td>");
                                    out.print("<td>" + u.getUserDate().substring(0,10) + "</td>");
                                out.print("</tr>");
                            }
                        %>
                    </table>
                </div>
                
            </div>
        </div>
    </div>   
    </body>
</html>
