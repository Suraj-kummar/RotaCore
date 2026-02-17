<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Shift Manager</title>
    <style>
        body {
            font-family: 'FK Grotesk Neue', Arial, sans-serif;
            background: #ffffff;
            margin: 0;
            padding: 0;
        }
        .register-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            background: white;
        }
        h2 {
            font-size: 20px;
            margin-bottom: 20px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 5px;
        }
        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ccc;
        }
        input[type="submit"] {
            margin-top: 15px;
            padding: 10px;
            border: 1px solid #ccc;
            background: #f8f9fa;
            cursor: pointer;
            font-weight: bold;
        }
        input[type="submit"]:hover {
            background: #e2e2e2;
        }
        a {
            display: block;
            margin-top: 15px;
            color: #0645ad;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="register-container">
    <h2>Employee Registration</h2>
    <form action="register" method="post">
        <label>Name:</label>
        <input type="text" name="name" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <input type="submit" value="Register">
    </form>
    <a href="login.jsp">Already registered? Login</a>
</div>
</body>
</html>
