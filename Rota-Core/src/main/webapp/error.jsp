<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h2>Error</h2>
    <p style="color:red;"><%= request.getAttribute("error") %></p>
    <a href="login.jsp">Back to Login</a>
</body>
</html>