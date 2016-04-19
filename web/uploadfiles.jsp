<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    String buildingId = request.getParameter("buildingId");
    
    if(request.getParameter("logout") != null) {

        if (request.getSession(false) != null) {
            session.invalidate();
        } 

        response.sendRedirect("index.jsp");
        return;
    }
    
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    } else if (user.getUserType().equals(User.userType.ADMIN)) {
        response.sendRedirect("admin/index.jsp");
        return;
    } else if (buildingId == null) {
        response.sendRedirect("buildings.jsp");
        return;
    }

    try {
        int tempId = Integer.parseInt(buildingId);

        if (tempId <= 0) {
            response.sendRedirect("buildings.jsp");
            return;
        }

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
<!DOCTYPE html>
<html>
    <head>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="css/resets.css" rel="stylesheet" type="text/css">
        <link href="css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Upload files to building</title>
    </head>
    <body>
    <div id="site">
        <div id="header">
            <div class="wrapper">
                <img src="images/polygon-logo.svg" class="header_logo" alt="Polygon">
                <p>Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
            </div>
        </div>
        <div id="navigation">
            <div class="wrapper">
                <h2>Upload files to building: <%= building.getBuildingName() %></h2>
                <ul>
                    <li class="inactive"><a href="buildings.jsp">Your buildings</a></li>
                    <li class="inactive"><a href="viewbuilding.jsp?buildingId=<%= buildingId %>">Building</a></li>
                    <li class="inactive"><a href="editbuilding.jsp?buildingId=<%= buildingId %>">Edit building</a></li>
                    <li class="inactive"><a href="adddamage.jsp?buildingId=<%= buildingId %>">Report damage</a></li>
                    <li class="active"><a href="uploadfiles.jsp?buildingId=<%= buildingId %>">Upload files</a></li>
                    <li class="inactive"><a href="#">Services</a></li>
                </ul>
            </div>
        </div>
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="buildings.jsp">Your buildings</a> &raquo; <a href="viewbuilding.jsp?buildingId=<%= buildingId %>">Building</a> &raquo; <span>Upload files</span></p>
                
                
                <div class="left_column uploadfiles">
                    <h1 class="">Upload a document</h1>
                    <form method="POST" enctype="multipart/form-data" action="UploadServlet" class="building">
                        <input type="hidden" name="directory" value="upload-document">
                        <p>Choose document to upload:</p>
                        <input type="file" name="file">
                        <p>Document description:</p>
                        <input type="text" name="note" maxlength="100" required>
                        <input type="hidden" name="action" value="upload-document">
                        <input type="hidden" name="buildingId" value="<%= buildingId %>">
                        <input type="submit" value="Upload document">
                    </form>
                </div>
                    
                <div class="right_column uploadfiles">
                    <h1 class="">Upload an image</h1>
                    <form method="POST" enctype="multipart/form-data" action="UploadServlet" class="building">
                        <input type="hidden" name="directory" value="upload-image">
                        <p>Choose image to upload:</p>
                        <input type="file" name="file">
                        <p>Image description:</p>
                        <input type="text" name="note" maxlength="100" required>
                        <input type="hidden" name="action" value="upload-image">
                        <input type="hidden" name="buildingId" value="<%= buildingId %>">
                        <input type="submit" value="Upload image">
                    </form>
                </div>
                    
            </div>
        </div>
    </div>
    </body>
</html>