<%-- 
    Document   : users
    Created on : 14-04-2016, 09:53:40
    Author     : HazemSaeid
--%>

<%@page import="serviceLayer.entities.User.userType"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            User user = (User) session.getAttribute("user");
        %>
        <h3>Hello, <span><%= user.getFullName()%></span> (<%= user.getUserType()%>)</h3>
        <h3><%= user.getUserMail()%></h3>
        <form action="UserServlet" method="POST" style="padding: 0;">
            <input type="hidden" name="action" value="logout">
            <input type="submit" value="Log out">
        </form>
        <br><hr><br>
        <h1 class="center">Overview</h1>
        <%
            if (request.getParameter("error") != null) {
                out.print("<br /><h2 class=\"error-msg\">" + request.getParameter("error") + "</h2>");
            } else if (request.getParameter("success") != null) {
                out.print("<br /><h2 class=\"success-msg\">" + request.getParameter("success") + "</h2>");
            }
        %>
        <br>

            <%
                AdminController ac = new AdminController();
                ArrayList<User> users = ac.getAllUsers("ADMIN");

                if (users.size() > 0) {
                    for (User u : users) {
                        out.print("<td>" + u.getFullName() + "</td>");
                    }
                }
            %>
    </body>
</html>
