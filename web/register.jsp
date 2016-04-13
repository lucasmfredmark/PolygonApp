<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="css/resets.css" rel="stylesheet" type="text/css">
        <link href="css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Register</title>
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
        <div id="register">
            <img class="logo" src="images/polygon-logo.svg" alt="Polygon">
            <h1 class="center">Sign up to Polygon to add your buildings</h1>
            <!-- Error message-->
            <%
                if (request.getParameter("error") != null) {
                    out.print("<h3 class='center'>" + request.getParameter("error") + "</h3>");
                } else if (request.getParameter("success") != null) {
                    out.print("<h3 class='center'>" + request.getParameter("success") + "</h3>");
                }
            %>
            <form method="POST" action="UserServlet">
                <input type="text" name="fullname" maxlength="50" placeholder="Your full name" required autofocus>
                <input type="email" name="e-mail" placeholder="Your e-mail" required>
                <input type="password" name="userpass" maxlength="20" placeholder="Your password" required>
                <input type="hidden" name="action" value="register">
                <input type="submit" value="Sign up">
            </form>
            <p class="center">Already have an account? Sign in <a href="index.jsp">here</a>.</p>
        </div>
    </body>
</html>