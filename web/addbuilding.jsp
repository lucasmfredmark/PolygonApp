<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/resets.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Polygon - Add new building</title>
    </head>
    <body>
        <h1 class="center" style="margin-top: 20px;">Add new building</h1>
        <%
            if (request.getParameter("msg") != null) {
                out.print("<br /><h2 class=\"error\">" + request.getParameter("msg") + "</h2>");
            }
        %>
        <form action="BuildingServlet" method="POST">
            <input type="text" name="bname" placeholder="Name of building">
            <input type="text" name="address" placeholder="Address">
            <input type="text" name="parcel" placeholder="Parcel number">
            <input type="text" name="size" placeholder="Size in m&sup2" pattern="\d*">
            <input type="hidden" name="action" value="add">
            <input type="submit" value="Add new building">
        </form>
    </body>
</html>
