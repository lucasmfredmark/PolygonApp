<%-- 
    Document   : uploadreport
    Created on : 13-Apr-2016, 12:09:50
    Author     : Staal
--%>

<%@page import="serviceLayer.entities.Order"%>
<%@page import="serviceLayer.entities.Checkup"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.entities.User"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.Document"%>
<%@page import="serviceLayer.entities.Document"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon upload report</title>
    </head>
    <body>

        <h3>Check Up Reports</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Upload date</th>
                <th>Check up note</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                User user = (User) session.getAttribute("user");
                
                if (user == null) {
                    response.sendRedirect("index.jsp");
                    return;
                } 
                if (request.getParameter("userId") == null || request.getParameter("buildingId") == null) {
                    response.sendRedirect("index.jsp");
                }
                //int customerId = Integer.parseInt(request.getParameter("userId")); UNUSED VARIABLE SO FAR
                int buildingId = Integer.parseInt(request.getParameter("buildingId"));

                BuildingController bc = new BuildingController();
                int conditionLevel = bc.getBuildingConditionLevel(buildingId);
                Order order = bc.getOrderByBuildingId(buildingId);
                int orderId = order.getOrderId();
            %>

        </table>
        <form method="POST" enctype="multipart/form-data" action="/PolygonApp/UploadServlet">
            <input type="hidden" name="directory" value="upload-report">
            Choose file to upload:<br><br>
            <input type="file" name="file"><br><br>
            <input type="hidden" name="action" value="upload-report">
            <input type="hidden" name="buildingId" value="<%=buildingId%>">
            <input type="hidden" name="orderId" value="<%=orderId%>">
            <input type="hidden" name="conditionLevel" value="<%=conditionLevel%>">
            <input type="submit" value="Upload Report">
        </form>
    </body>
</html>
