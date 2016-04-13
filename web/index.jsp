<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="css/resets.css" rel="stylesheet" type="text/css">
        <link href="css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Sign in</title>
    </head>
    <body class="index">
        <!-- Session check -->
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
        
        <!-- Content Include -->
        <div id="login">
            <img class="logo" src="images/polygon-logo.svg" alt="Polygon">
            <h1 class="center">Sign in with your e-mail and password</h1>
            <!-- Error message-->
            <%
                if (request.getParameter("error") != null) {
                    out.print("<h3 class='center'>" + request.getParameter("error") + "</h3>");
                } else if (request.getParameter("success") != null) {
                    out.print("<h3 class='center'>" + request.getParameter("success") + "</h3>");
                }
            %>
            <form method="POST" action="UserServlet">
                <input type="email" name="e-mail" placeholder="E-mail" required autofocus>
                <input type="password" name="userpass" maxlength="20" placeholder="Password" required>
                <input type="hidden" name="action" value="login">
                <input type="submit" value="Sign in">
            </form>
            <p class="center">Don't have an account yet? Sign up <a href="register.jsp">here</a>.</p>
        </div>
    </body>
</html>