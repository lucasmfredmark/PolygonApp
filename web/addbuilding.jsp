<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/resets.css">
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <title>Polygon - Add new building</title>
    </head>
    <body>
        <br>
        <h1 class="center">Add a new building!</h1>
        <br>
        <form name="addform" action="" method="POST">
            <input type="text" name="bname" placeholder="Name of building">
            <input type="text" name="address" placeholder="Address">
            <input type="text" name="parcel" placeholder="Parcel number">
            <input type="text" name="size" placeholder="Size in m&sup2">
            <input type="submit" name="addb" value="Add new building">
        </form>
</html>
