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
        <div id="content">
            <h1 class="center"><span>Polygon</span>Group</h1>
            <h2>Sign up to Polygon</h2>
            <form name ="loginForm" method="POST" action="Login">
                <input type="text" name="username" maxlength="30" pattern="[0-9a-zA-Z]+" placeholder="Username" required>
                <input type="password" name="userpass" maxlength="30" placeholder="Password" required>
                <input type="submit" name="userlogin" value="Sign up">
                <p>*Feedback</p>
            </form>
        </div>
    </body>
</html>
