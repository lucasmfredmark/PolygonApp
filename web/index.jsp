<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/reset.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Polygon - Login</title>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            
            if (user != null) {
                if (user.getUserType().equals(User.userType.ADMIN.toString())) {
                    response.sendRedirect("admin/index.jsp");
                    return;
                }
                
                response.sendRedirect("buildings.jsp");
                return;
            }
        %>
        <div id="content">
            <img class="logo" src="images/polygon-logo.svg" alt="Polygon">
            <h2>Sign in with your e-mail and password</h2>
            <%
                if (request.getParameter("error") != null) {
                    out.print("<br /><h2 class=\"error-msg\">" + request.getParameter("error") + "</h2>");
                } else if (request.getParameter("success") != null) {
                    out.print("<br /><h2 class=\"success-msg\">" + request.getParameter("success") + "</h2>");
                }
            %>
            <form method="POST" action="UserServlet">
                <input type="email" name="e-mail" placeholder="E-mail" required>
                <input type="password" name="userpass" maxlength="20" placeholder="Password" required>
                <input type="hidden" name="action" value="login">
                <input type="submit" value="Sign in">
                <p>*Feedback</p>
            </form>
            <h2>Don't have an account yet? Sign up <a href="register.jsp">here</a>.</h2>
        </div>
    </body>
</html>
