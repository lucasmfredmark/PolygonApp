<%-- 
    Document   : uploadreport
    Created on : 13-Apr-2016, 12:09:50
    Author     : Staal
--%>

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
        <title>JSP Page</title>
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
                String buildingId = request.getParameter("buildingId");
                if (user == null) {
                    response.sendRedirect("adminIndex.jsp");
                    return;
                }else if (buildingId == null) {
                response.sendRedirect("building.jsp");
                return;
            }
                

                BuildingController bc = new BuildingController();
              
                ArrayList<Checkup> checkups = bc.getBuildingCheckups(Integer.parseInt(buildingId));

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
        <form method="POST" enctype="multipart/form-data" action="UploadServlet">
            <input type="hidden" name="directory" value="upload-document">
            Choose file to upload:<br><br>
            <input type="file" name="file"><br><br>
            Notes about the file: <input type="text" name="note" maxlength="100">
            <input type="hidden" name="action" value="upload-document">
            <input type="hidden" name="buildingId" value="<%= buildingId%>">
            <input type="submit" value="Upload Report.pdf">
        </form>
    </body>
</html>
