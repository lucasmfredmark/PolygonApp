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
        <h1 class="center" style="margin-top: 20px;">Add damage</h1>
        <%
            if (request.getParameter("error") != null) {
                out.print("<br /><h2 class=\"error-msg\">" + request.getParameter("error") + "</h2>");
            } else if (request.getParameter("success") != null) {
                out.print("<br /><h2 class=\"success-msg\">" + request.getParameter("success") + "</h2>");
            }
        %>
        <form action="BuildingServlet" method="POST">
            <input type="text" name="dmgtitle" placeholder="Damage" maxlength="40" required>
            <input type="text" name="dmgdesc" placeholder="Description" maxlength="50" required>
            <input type="hidden" name="buildingId" value="<%= request.getParameter("buildingId")%>">
            <input type="hidden" name="action" value="addDmg">
            <input type="submit" value="Add damage">
            <div class="button">
                <a href="buildings.jsp"><- Back to overview</a>
            </div>
        </form>
    </body>
</html>
