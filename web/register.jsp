<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/reset.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Polygon - Create Account</title>
    </head>
    <body>
        <%
            if (session.getAttribute("user") != null) {
                response.sendRedirect("buildings.jsp");
                return;
            }
        %>
        <div id="content">
            <h1 class="center"><span>Polygon</span>Group</h1>
            <h2>Sign up to Polygon</h2>
            <%
                if (request.getParameter("msg") != null) {
                    out.print("<br /><h2 class=\"error\">" + request.getParameter("msg") + "</h2>");
                }
            %>
            <form method="POST" action="UserServlet">
                <input type="text" name="username" maxlength="30" pattern="[0-9a-zA-Z]+" placeholder="Username" required>
                <input type="password" name="userpass" maxlength="30" placeholder="Password" required>
                <input type="text" name="fullname" maxlength="30" placeholder="Full name" required>
                <input type="email" name="email" placeholder="Email" required>
                <input type="hidden" name="action" value="register">
                <input type="submit" value="Sign up">
                <p>*Feedback</p>
            </form>
            <h2>Already have an account? Sign in <a href="index.jsp">here</a>.</h2>
        </div>
    </body>
</html>
