<%-- 
    Document   : building
    Created on : 13-Apr-2016, 12:09:18
    Author     : Staal
--%>

<%@page import="serviceLayer.controllers.AdminController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.Checkup"%>
<%@page import="serviceLayer.entities.Document"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customer building</title>
    </head>
    <body>
        <%
            
            User user = (User) session.getAttribute("user");
            if (request.getParameter("buildingId") == null) {
                response.sendRedirect("users.jsp");
            } else if(request.getParameter("userId") == null) {
               response.sendRedirect("users.jsp");
            }
            
            int buildingId = Integer.parseInt(request.getParameter("buildingId"));
            int userId = Integer.parseInt(request.getParameter("userId"));
            BuildingController bc = new BuildingController();
            Building building = bc.getCustomerBuilding((buildingId), userId);
            

        %>
       <h1 class="center" style="margin-top: 20px;">View building "<%= building.getBuildingName() %>"</h1>
        <div style="width: 600px; margin: 20px auto; padding: 10px; background: #fafafa; border: 1px solid #333;">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 40%;"><h3 style="font-weight: bold; text-align: left;">Building name:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getBuildingName() %></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Address:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getBuildingAddress() %></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Parcel number:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getBuildingParcelNumber() %></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Size in m&sup2;:</h3></td>
                    <td><h3 style="text-align: left;"><%= building.getBuildingSize() %></h3></td>
                </tr>
                <tr>
                    <td><h3 style="font-weight: bold; text-align: left;">Condition level:</h3></td>
                    <td><h3 style="text-align: left;"><%= bc.getBuildingConditionLevel(buildingId) %></h3></td>
                </tr>
            </table>
        </div>
        <div class="button">
            <a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a>
        </div>
        
        <h3>Check-up reports</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Upload date</th>
                <th>Report name</th>
                <th style="width: 200px;">Path</th>
                <th style="width: 150px;">Condition level</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                ArrayList<Checkup> checkups = bc.getBuildingCheckups(buildingId);

                if (checkups.size() > 0) {
                    for (Checkup c : checkups) {
                        out.print("<tr onclick=\"document.location = 'uploads/reports/" + c.getCheckupPath() + "';\">");
                        out.print("<td>" + c.getCheckupDate() + "</td>");
                        out.print("<td>" + c.getCheckupPath() + "</td>");
                        out.print("<td>kek</td>");
                        out.print("<td>" + c.getConditionLevel() + "</td>");
                        out.print("<td><a href=\"uploads/reports/" + c.getCheckupPath() + "\">View</a></td>");
                        out.print("</tr>");
                    }
                } else {
                    out.print("<tr><td colspan=\"5\">There are no check-up reports available for this building yet.</td></tr>");
                }
            %>
        </table>
        
        <h3>Other documents</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Upload date</th>
                <th>Document note</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                ArrayList<Document> documents = bc.getBuildingDocuments(buildingId);
                
                if (documents.size() > 0) {
                    for (Document d : documents) {
                        out.print("<tr onclick=\"document.location = 'uploads/documents/" + d.getDocumentPath() + "';\">");
                        out.print("<td>" + d.getDocumentDate() + "</td>");
                        out.print("<td>" + d.getDocumentNote() + "</td>");
                        out.print("<td><a href=\"uploads/documents/" + d.getDocumentPath() + "\">View</a></td>");
                        out.print("</tr>");
                    }
                } else {
                    out.print("<tr><td colspan=\"3\">There are no documents available for this building yet.</td></tr>");
                }
            %>
        </table>
        
        <div class="button">
            <a href='uploadreport.jsp?userId=<%=userId%>&buildingId=<%=buildingId%>'><-Upload a report to this building</a>
        </div>
        
        <br>
        
         <div class="button">
            <a href='uploadimg.jsp?userId=<%=userId%>&buildingId=<%=buildingId%>'><-Upload an image to this building</a>
        </div>
        
        <br>
       
        <div class="button">
            <a href="userBuildings.jsp?userId=<%=userId%>&buildingId=<%=buildingId%>"><- Back to overview</a>
        </div>
        <br><hr><br>