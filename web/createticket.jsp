<%-- 
    Document   : createticket
    Created on : 20-04-2016, 01:52:50
    Author     : xboxm
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create a support ticket</title>
    </head>
    <body>
        
        <a href="support.jsp">Back to support tickets</a> <br><br>
        
        <form method="POST" action="SupportServlet">
            <input type="text" name="title" placeholder="Title of ticket" maxlength="50" required autofocus> <br><br>
            <input type="hidden" name="action" value="create">
            <textarea name="text" style="width:400px; height:300px" placeholder="Describe your problem as detailed as possible"></textarea>
            <br> <br> 
            <input type="submit" value="Create ticket">
        </form>
        
    </body>
</html>
