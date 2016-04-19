<%@page import="serviceLayer.entities.*"%>
<%@page import="serviceLayer.exceptions.*"%>
<%@page import="serviceLayer.controllers.*"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    /* DESTROY SESSION ON SIGN OUT */
    if(request.getParameter("logout") != null) {
        if (request.getSession(false) != null) {
            session.invalidate();
        }
        response.sendRedirect("../index.jsp");
        return;
    }
    
    // SESSION CHECK
    User user = (User) session.getAttribute("user");
    
    if (user == null) {
        response.sendRedirect("../index.jsp");
        return;
    } else if (user.getUserType().equals(User.userType.CUSTOMER)) {
        response.sendRedirect("../buildings.jsp");
        return;
    }
    
    // PARAMETER CHECK
    int buildingId = Integer.parseInt(request.getParameter("buildingId"));
    
    if (request.getParameter("buildingId") == null) {
        response.sendRedirect("index.jsp");
    }
    
    AdminController ac = new AdminController();
    Building b = ac.getAdminBuilding(buildingId);
   
    if (b == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="../css/resets.css" rel="stylesheet" type="text/css">
        <link href="../css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Admin - Upload report</title>
    </head>
    <body>
    <div id="site">
        <div id="header">
            <div class="wrapper">
                <img src="../images/polygon-logo.svg" class="header_logo" alt="Polygon">
                <p>Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
            </div>
        </div>
        <div id="navigation">
            <div class="wrapper">
                <h2>Uploading report to building with id: <%= buildingId %></h2>
                <ul>
                    <li class="inactive"><a href="index.jsp">Dashboard</a></li>
                    <li class="inactive"><a href="customerbuildings.jsp">Buildings</a></li>
                    <li class="inactive"><a href="building.jsp?buildingId=<%= buildingId %>">Building information</a></li>
                    <li class="inactive"><a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a></li>
                    <li class="inactive"><a href="uploadfile.jsp?buildingId=<%= buildingId %>">Upload files</a></li>
                    <li class="active"><a href="uploadreport.jsp?buildingId=<%= buildingId %>">Upload report</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="index.jsp">Dashboard</a> &raquo; <a href="customerbuildings.jsp">Buildings</a>  &raquo; <span>Upload report</span></p>
                
                <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                %>
                
                <div class="left_column uploadfiles">
                    <h1 class="">Upload report</h1>
                    <form method="POST" enctype="multipart/form-data" action="/PolygonApp/UploadServlet" class="building">
                        <input type="hidden" name="directory" value="upload-report">
                        <p>Choose report to upload:</p>
                        <input type="file" name="file">
                        <input type="hidden" name="action" value="upload-report">
                        <input type="hidden" name="buildingId" value="<%= buildingId %>">
                        <input type="submit" value="Upload report">
                    </form>
                </div>
                
            </div>
        </div>
    </div>  
    </body>
</html>