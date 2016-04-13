<%-- 
    Document   : uploaddocument
    Created on : 13-Apr-2016, 12:10:36
    Author     : Staal
--%>

<%@page import="serviceLayer.entities.Document"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
               <h3>Other documents</h3>
        <table class="overview">
            <tr>
                <th style="width: 200px;">Upload date</th>
                <th>Document note</th>
                <th style="width: 50px;">View</th>
            </tr>
            <%
                ArrayList<CheckUpReport> checkupreports = buildingController.getBuildingDocuments(Integer.parseInt(buildingId));
                
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
        <form method="POST" enctype="multipart/form-data" action="UploadServlet">
            <input type="hidden" name="directory" value="upload-document">
            Choose file to upload:<br><br>
            <input type="file" name="file"><br><br>
            Notes about the file: <input type="text" name="note" maxlength="100">
            <input type="hidden" name="action" value="upload-document">
            <input type="hidden" name="buildingId" value="<%= buildingId %>">
            <input type="submit" value="Upload document">
        </form>
    </body>
</html>
