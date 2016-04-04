<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/resets.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Polygon - Edit building</title>
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
            
            BuildingController buildingController = new BuildingController();
            Building building = buildingController.getCustomerBuilding(Integer.parseInt(buildingId), user.getId());
            
            if (building == null) {
                response.sendRedirect("buildings.jsp");
                return;
            }
        %>
        <h1 class="center" style="margin-top: 20px;">Editing building "<%= building.getName() %>"</h1>
        <%
            if (request.getParameter("error") != null) {
                out.print("<br /><h2 class=\"error-msg\">" + request.getParameter("error") + "</h2>");
            } else if (request.getParameter("success") != null) {
                out.print("<br /><h2 class=\"success-msg\">" + request.getParameter("success") + "</h2>");
            }
        %>
        <form action="BuildingServlet" method="POST">
            <input type="text" name="bname" value="<%= building.getName() %>" placeholder="Name of building">  
            <input type="text" name="address" value="<%= building.getAddress() %>" placeholder="Address">
            <input type="text" name="parcel" value="<%= building.getParcelNumber() %>" placeholder="Parcel number">
            <input type="text" name="size" value="<%= building.getSize() %>" placeholder="Size in m&sup2" pattern="\d*">
            <input type="hidden" name="buildingId" value="<%= buildingId %>">
            <input type="hidden" name="action" value="edit">
            <input type="submit" value="Save changes">
            <div class="button">
                <a href="buildings.jsp"><- Back to overview</a>
            </div>
        </form>
    </body>
</html>
