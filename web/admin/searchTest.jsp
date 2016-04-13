<%@page import="serviceLayer.entities.User"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.UserController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Search test</title>
    </head>
    <body>
        <h1>Search test</h1>
        <hr>
        <h2>Search users</h2>
        <input type="text" id="searchUser">
        <table id="usersTable">
            <tr>
                <th>User ID</th>
                <th>Fullname</th>
                <th>E-mail address</th>
                <th>Register date</th>
            </tr>
            <%
                UserController uc = new UserController();
                ArrayList<User> users = uc.getAllUsers("CUSTOMER");

                for (User user : users) {
                    out.print("<tr>");
                    out.print("<td>" + user.getUserId() + "</td>");
                    out.print("<td>" + user.getFullName()+ "</td>");
                    out.print("<td>" + user.getUserMail()+ "</td>");
                    out.print("<td>" + user.getUserDate()+ "</td>");
                    out.print("</tr>");
                }
            %>
        </table>
        <script src="../js/jquery-1.12.3.min.js"></script>
        <script>
            $(function() {
                $('#searchUser').keyup(function() {
                    $('#usersTable tr').each(function() {
                        if ($(this).find('td:nth('))
                    });
                });
            });
        </script>
    </body>
</html>
