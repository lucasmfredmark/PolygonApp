<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Polygon - Edit building</title>
    </head>
    <body>
        <%
            if (session.getAttribute("user") == null) {
                response.sendRedirect("index.jsp");
                return;
            }
        %>
        <h1 class="center" style="margin-top: 20px;">Edit building {name}</h1>
        <%
            if (request.getParameter("msg") != null) {
                out.print("<br /><h2 class=\"error\">" + request.getParameter("msg") + "</h2>");
            }
        %>
         <form action="BuildingServlet" method="POST">
            <input type="text" name="bname" placeholder="Name of building">  
            <input type="text" name="address" placeholder="Address">
            <input type="text" name="parcel" placeholder="Parcel number">
            <input type="text" name="size" placeholder="Size in m&sup2" pattern="\d*">
            <input type="hidden" name="action" value="edit">
            <input type="submit" value="Save changes">
            <div class="button">
                <a href="buildings.jsp"><- Back to overview</a>
            </div>
        </form>
    </body>
</html>
