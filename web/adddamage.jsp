<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/resets.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Polygon - Add new damage</title>
    </head>
    <body>
        <%
            User user = (User) session.getAttribute("user");
            String buildingId = request.getParameter("buildingId");
            
            if (user == null) {
                response.sendRedirect("index.jsp");
                return;
            } else if (buildingId == null) {
                response.sendRedirect("buildings.jsp");
                return;
            }
            
            try {
                int tempId = Integer.parseInt(buildingId);
                buildingId = String.valueOf(tempId);
            } catch (NumberFormatException ex) {
                response.sendRedirect("buildings.jsp");
                return;
            }
            
            BuildingController buildingController = new BuildingController();
            Building building = buildingController.getCustomerBuilding(Integer.parseInt(buildingId), user.getUserId());
            
            if (building == null) {
                response.sendRedirect("buildings.jsp");
                return;
            }
        %>
        <h1 class="center" style="margin-top: 20px;">Add damage to building "<%= building.getBuildingName() %>"</h1>
        <%
            if (request.getParameter("error") != null) {
                out.print("<br /><h2 class=\"error-msg\">" + request.getParameter("error") + "</h2>");
            } else if (request.getParameter("success") != null) {
                out.print("<br /><h2 class=\"success-msg\">" + request.getParameter("success") + "</h2>");
            }
        %>
        <form action="BuildingServlet" method="POST">
            <input type="text" name="dmgtitle" placeholder="Damage" maxlength="50" required>
            <input type="text" name="dmgdesc" placeholder="Description" required>
            <input type="hidden" name="buildingId" value="<%= buildingId %>">
            <input type="hidden" name="action" value="adddmg">
            <input type="submit" value="Add damage">
            <div class="button">
                <a href="viewbuilding.jsp?buildingId=<%= buildingId %>"><- Back to building</a>
            </div>
        </form>
    </body>
</html>
