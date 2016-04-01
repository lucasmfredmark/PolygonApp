<%-- 
    Document   : editbuilding
    Created on : 01-04-2016, 20:06:32
    Author     : HazemSaeid
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="serviceLayer.controllers.BuildingController"%>
<%@page import="serviceLayer.entities.Building"%>
<%@page import="serviceLayer.entities.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
     
         <form action="BuildingServlet" method="POST">
              
            <input type="text" name="bname" placeholder="Name of building">  
            <input type="text" name="address" placeholder="Address">
            <input type="text" name="parcel" placeholder="Parcel number">
            <input type="text" name="size" placeholder="Size in m&sup2" pattern="\d*">
            <input type="hidden" name="action" value="edit">
            <input type="submit" value="Save Changes">
        </form>
    </body>
</html>
