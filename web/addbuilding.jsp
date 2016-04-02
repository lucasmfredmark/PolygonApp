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
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
                return;
            }
        %>
        <h1 class="center" style="margin-top: 20px;">Add new building</h1>
        <%
            if (request.getParameter("error") != null) {
                out.print("<br /><h2 class=\"error-msg\">" + request.getParameter("error") + "</h2>");
            } else if (request.getParameter("success") != null) {
                out.print("<br /><h2 class=\"success-msg\">" + request.getParameter("success") + "</h2>");
            }
        %>
        <form action="BuildingServlet" method="POST">
            <input type="text" name="bname" placeholder="Name of building">
            <input type="text" name="address" placeholder="Address">
            <input type="text" name="parcel" placeholder="Parcel number">
            <input type="text" name="size" placeholder="Size in m&sup2" pattern="\d*">
            <input type="hidden" name="action" value="add">
            <input type="submit" value="Add new building">
            <div class="button">
                <a href="buildings.jsp"><- Back to overview</a>
            </div>
        </form>
    </body>
</html>
