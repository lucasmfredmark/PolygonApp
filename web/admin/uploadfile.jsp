<%@page import="serviceLayer.entities.*"%>
<%@page import="serviceLayer.exceptions.*"%>
<%@page import="serviceLayer.controllers.*"%>
<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // SIGN OUT
    if(request.getParameter("logout") != null) {
        if (request.getSession(false) != null) {
            session.invalidate();
        }
        response.sendRedirect("/PolygonApp/index.jsp");
        return;
    }
    
    // SESSION CHECK
    User user = (User) session.getAttribute("user");
    
    if (user == null) {
        response.sendRedirect("/PolygonApp/index.jsp");
        return;
    } else if (user.getUserType().equals(User.userType.CUSTOMER)) {
        response.sendRedirect("/PolygonApp/buildings.jsp");
        return;
    }
    
    // PARAMETER CHECK
    int buildingId;
    
    try {
        buildingId = Integer.parseInt(request.getParameter("buildingId"));
        
        if (buildingId <= 0) {
            response.sendRedirect("/PolygonApp/admin/buildings.jsp");
            return;
        }
    } catch (NumberFormatException ex) {
        response.sendRedirect("/PolygonApp/admin/buildings.jsp");
        return;
    }    

    AdminController ac = new AdminController();
    Building b = ac.getAdminBuilding(buildingId);
   
    if (b == null) {
        response.sendRedirect("/PolygonApp/admin/buildings.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <script src="../js/jquery-1.12.3.min.js"></script>
        <script src="../js/main.js"></script>
        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,400italic' rel='stylesheet' type='text/css'>
        <link href="/PolygonApp/css/resets.css" rel="stylesheet" type="text/css">
        <link href="/PolygonApp/css/new_style.css" rel="stylesheet" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Upload files</title>
    </head>
    <body>
        <div id="top">
            <div id="header">
                <div class="wrapper">
                    <img src="/PolygonApp/images/polygon-logo.svg" class="header_logo" alt="Polygon">
                    <p>Hello, <%= user.getFullName() %> (<a href="?logout">Sign out</a>)</p>
                </div>
            </div>
            <div id="navigation">
                <div class="wrapper">
                    <h2>Uploading files to building with id: <%= buildingId %></h2>
                    <ul>
                        <li class="inactive"><a href="/PolygonApp/admin/index.jsp">Dashboard</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/users.jsp">Users</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/buildings.jsp">Buildings</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/pending.jsp">Checkups</a></li>
                        <li class="inactive"><a href="/PolygonApp/admin/support.jsp">Support tickets</a></li>
                    </ul>
                </div>
            </div>
        </div>
                    
        <div id="content">
            <div class="wrapper">
                <!-- BREADCRUMBS -->
                <p class="breadcrumbs"><a href="/PolygonApp/admin/index.jsp">Admin panel</a> &raquo; <a href="/PolygonApp/admin/buildings.jsp">Buildings</a> &raquo; <a href="/PolygonApp/admin/viewbuilding.jsp?buildingId=<%= buildingId %>">Building information</a> &raquo; Upload files</p>
                
                <div class="container">
                    <%
                    if (request.getParameter("error") != null) {
                        out.print("<h3>" + request.getParameter("error") + "</h3><br>");
                    } else if (request.getParameter("success") != null) {
                        out.print("<h3>" + request.getParameter("success") + "</h3><br>");
                    }
                    %>
                    <h1>Upload a document or an image</h1>
                    <form method="POST" enctype="multipart/form-data" action="/PolygonApp/UploadServlet" class="building">
                        <input type="hidden" name="directory" value="upload-document">
                        <input type="file" name="file">
                        <input type="text" name="note" maxlength="100" placeholder="File description" required>
                        <input type="hidden" name="action" value="upload-document">
                        <input type="hidden" name="buildingId" value="<%= buildingId %>">
                        <input type="submit" value="Upload file">
                    </form>
                </div>
                        
                
            </div>
        </div>
    </body>
</html>    